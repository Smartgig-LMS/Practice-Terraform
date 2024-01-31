resource "aws_ecs_task_definition" "ecs-td" {
  family                   = "${var.app_name}-ecs-td"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  runtime_platform {
    operating_system_family = "LINUX"
    #cpu_architecture        = "X86_64"
  }
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.image
      essential = true
      # environment = var.container_environment
      portMappings = [
        {
          protocol      = "tcp"
          containerPort = var.ecs-containerPort
        #  hostPort      = 80
        }
      ]

    }
  ])
}

resource "aws_ecs_service" "ecs-svc" {
  name                               = "ecs-svc"
  cluster                            = aws_ecs_cluster.ecs-cluster.id
  task_definition                    = aws_ecs_task_definition.ecs-td.arn
  desired_count                      = var.desired_count
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"

  network_configuration {
    security_groups  = [aws_security_group.ecs-sg.id]
    subnets          = [var.private_subnet_1_id, var.private_subnet_2_id]
    assign_public_ip = true
  }

}
