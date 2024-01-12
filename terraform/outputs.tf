# outputs.tf

#Share this with Spruce
output "alb_hostname" {
  value = "${aws_alb.main.dns_name}:${var.app_port}"
}
