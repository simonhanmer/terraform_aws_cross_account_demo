resource "aws_iam_role" "s3_copier_role" {
  name = "${var.project_name}_s3_copier_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_copier_role_policy_attachment" {
  role       = aws_iam_role.s3_copier_role.name
  policy_arn = aws_iam_policy.lambda_logging_policy.arn
}


data "archive_file" "s3_copier_zip" {
  type        = "zip"
  source_file = "source/s3_copier/lambda_function.py"
  output_path = "source/s3_copier.zip"
}

resource "aws_lambda_function" "s3_copier_function" {
  function_name                  = "${var.project_name}_s3_copier"
  role                           = aws_iam_role.s3_copier_role.arn
  description                    = "Read SQS Events"
  filename                       = data.archive_file.s3_copier_zip.output_path
  source_code_hash               = data.archive_file.s3_copier_zip.output_base64sha256
  handler                        = "lambda_function.lambda_handler"
  runtime                        = "python3.9"
  reserved_concurrent_executions = 1
  environment {
    variables = {
      LOG_LEVEL = "INFO"
    }
  }
}

resource "aws_cloudwatch_log_group" "s3_copier_log_group" {
  name = "/aws/lambda/${aws_lambda_function.s3_copier_function.function_name}"
  retention_in_days = 1
}


