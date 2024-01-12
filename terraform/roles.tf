# roles.tf
# ECS task execution role data
data "aws_iam_policy_document" "ecs_task_execution_role" {
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# AWS secrets manager read data
data "aws_iam_policy_document" "aws_secrets_read" {
  statement {
    effect = "Allow"
    actions = ["kms:Decrypt",
      "secretsmanager:GetSecretValue",
    ]
    resources = ["arn:aws:secretsmanager:us-east-1:815628510286:secret:github-PAT-54C23Q",
      "arn:aws:kms:us-east-1:815628510286:key/*",
    ]
  }
}

# AWS secrets manager read policy
resource "aws_iam_policy" "aws_secrets_read" {
  name        = "aws-secrets-read-policy_${terraform.workspace}"
  description = "Read the secrets stored in AWS, to authenticate to private registry"
  policy      = data.aws_iam_policy_document.aws_secrets_read.json

  tags = {
    Name = "${terraform.workspace}_aws_secrets_read-policy"
  }

}


# ECS task execution role
resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "${var.ecs_task_execution_role_name}_${terraform.workspace}"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role.json

  tags = {
    Name = "${terraform.workspace}_ecs_task_execution_role"
  }
}

# Attach AWS read secrets policy to role
resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.aws_secrets_read.arn
}

# Attach ECS task execution policy to role
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ECS auto scale role data
data "aws_iam_policy_document" "ecs_auto_scale_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["application-autoscaling.amazonaws.com"]
    }
  }
}

# ECS auto scale role
resource "aws_iam_role" "ecs_auto_scale_role" {
  name               = "${var.ecs_auto_scale_role_name}_${terraform.workspace}"
  assume_role_policy = data.aws_iam_policy_document.ecs_auto_scale_role.json

  tags = {
    Name = "${terraform.workspace}_ecs_auto_scale_role"
  }
}

# ECS auto scale role policy attachment
resource "aws_iam_role_policy_attachment" "ecs_auto_scale_role" {
  role       = aws_iam_role.ecs_auto_scale_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole"
}
