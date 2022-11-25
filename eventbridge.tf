resource "aws_cloudwatch_event_rule" "demo_event_rule" {
    name        = "${var.project_name}_test_bucket_event_rule"
    description = "Rule to trigger eventbridge on PutObject to test bucket"

    event_pattern = jsonencode(
        {
        "source" : ["aws.s3"],
        "detail-type" : ["AWS API Call via CloudTrail"],
            "detail" : {
            "eventSource" : ["s3.amazonaws.com"],
            "eventName" : ["PutObject"],
                "requestParameters" : {
                    "bucketName" : [aws_s3_bucket.source_bucket.id]
                }
            }
        }
    )
}

resource "aws_cloudwatch_event_target" "eventbridge_lambda" {
    rule = aws_cloudwatch_event_rule.demo_event_rule.name
    arn  = aws_lambda_function.s3_copier_function.arn
}

resource "aws_lambda_permission" "trigger_reader_from_eventbridge" {
    statement_id  = "AllowExecutionFromEventbridge"
    action        = "lambda:InvokeFunction"
    function_name = aws_lambda_function.s3_copier_function.function_name
    principal     = "events.amazonaws.com"
    source_arn    = aws_cloudwatch_event_rule.demo_event_rule.arn
}