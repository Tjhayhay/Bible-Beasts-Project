# logs.terraform

# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "bible_beasts_log_group" {
  name              = "/ecs/bible_beasts_${terraform.workspace}"
  retention_in_days = 30

  tags = {
    Name = "${terraform.workspace}_service_cpu_high"
  }

}

resource "aws_cloudwatch_log_stream" "bible_beasts_log_stream" {
  name           = "${terraform.workspace}_bible_beasts_log_stream"
  log_group_name = aws_cloudwatch_log_group.bible_beasts_log_group.name
}
