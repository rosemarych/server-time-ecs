# ECS Security Group
resource "aws_security_group" "ecs" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.resource_tags
}

# ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "server-time-cluster"

  tags = var.resource_tags
}

# ECS Task Definition
resource "aws_ecs_task_definition" "main" {
  family                   = "server-time-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([{
    name  = "server-time-container"
    image = var.container_image
    portMappings = [{
      containerPort = 5000
      hostPort      = 5000
    }]
  }])

  tags = var.resource_tags
}

# ECS Service
resource "aws_ecs_service" "main" {
  name            = "server-time-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = 1

  launch_type = "FARGATE"

  network_configuration {
    subnets         = aws_subnet.private_subnet[*].id
    security_groups = [aws_security_group.ecs.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.main.arn
    container_name   = "server-time-container"
    container_port   = 5000
  }

  tags = var.resource_tags
  depends_on = [aws_lb_listener.http]
}
