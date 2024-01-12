# alb.tf

resource "aws_alb" "main" {
  name            = "${terraform.workspace}-bb-load-balancer"
  subnets         = aws_subnet.public.*.id
  security_groups = [aws_security_group.lb.id]

  tags = {
    Name = "${terraform.workspace}_load_balancer"
  }

}

resource "aws_alb_target_group" "app" {
  name        = "${terraform.workspace}-bb-target-group"
  port        = 443
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }

  tags = {
    Name = "${terraform.workspace}_target_group"
  }

}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.main.id
  port              = var.app_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.app.id
    type             = "forward"
  }

  tags = {
    Name = "${terraform.workspace}_listener"
  }

}
