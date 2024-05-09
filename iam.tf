resource "aws_iam_role" "iam_role" {
  name = "${var.name}-${var.env}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = merge(var.tags, {Name="${var.env}-${var.name}-role" })
}

resource "aws_iam_role_policy" "iam_ssm_role_policy" {
  name = "${var.name}-${var.env}-role-policy"
  role = aws_iam_role.iam_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Sid": "VisualEditor0",
        "Effect": "Allow",
        "Action": [
          "kms:Decrypt",
          "ssm:GetParameterHistory",
          "ssm:GetParametersByPath",
          "ssm:GetParameters",
          "ssm:GetParameter"
        ],
        "Resource":  concat([var.kms_arn], local.resources)
      }
    ]
  })
}

resource "aws_iam_instance_profile" "iam_ssm_instance_profile" {
  name = "${var.name}-${var.env}-instance-profile"
  role = aws_iam_role.iam_role.name
}