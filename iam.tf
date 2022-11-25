resource "aws_iam_policy" "lambda_logging_policy" {
  name        = "policy_${var.project_name}"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect   = "Allow"
        Sid      = "LambdaLogging"
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}
