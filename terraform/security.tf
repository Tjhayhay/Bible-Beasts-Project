# security.tf

# ALB security Group: Edit to restrict access to the application
resource "aws_security_group" "lb" {
  name        = "${terraform.workspace}-bible_beasts-load-balancer-security-group"
  description = "controls access to the ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "acces from ${terraform.workspace} ALB only"
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allows all outgoing traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${terraform.workspace}_load_balancer_sg"
  }

}

# Traffic to the ECS cluster should only come from the ALB
resource "aws_security_group" "ecs_tasks" {
  name        = "${terraform.workspace}_bible_beasts_ecs_tasks_security_group"
  description = "alow inbound access from the ${terraform.workspace} ALB only"
  vpc_id      = aws_vpc.main.id

  ingress {
    description     = "access from ${terraform.workspace} ALB only"
    from_port       = var.app_port
    to_port         = var.app_port
    protocol        = "tcp"
    security_groups = [aws_security_group.lb.id]
  }

  egress {
    description = "Allows all outgoing traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${terraform.workspace}_ecs_tasks_sg"
  }

}
