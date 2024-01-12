# ecs.tf

# Create ECS cluster
resource "aws_ecs_cluster" "main" {
  name = "${terraform.workspace}_bible_beasts_ecs_cluster"

  tags = {
    Name = "${terraform.workspace}_ecs_cluster"
  }

}

# Template file data for ECS container definition
data "template_file" "bible_beasts" {
  template = file("./templates/ecs/bible_beasts_${terraform.workspace}.json.tpl")

  vars = {
    app_image      = var.app_image
    app_port       = var.app_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    aws_region     = var.aws_region
  }
}

# Create ECS task definition
resource "aws_ecs_task_definition" "app" {
  family                   = "bible_beasts_task_${terraform.workspace}"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.bible_beasts.rendered

}

# Create ECS service using Fargate
resource "aws_ecs_service" "main" {
  name            = "${terraform.workspace}_bible_beasts_ecs_service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = aws_subnet.private.*.id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.app.id
    container_name   = "bible_beasts_${terraform.workspace}"
    container_port   = var.app_port
  }

  depends_on = [aws_alb_listener.front_end, aws_iam_role_policy_attachment.ecs_task_execution_role]

  tags = {
    Name = "${terraform.workspace}_ecs_service"
  }

}
