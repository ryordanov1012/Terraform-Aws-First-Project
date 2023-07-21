# Create SNS Topic
# Terraform aws sns topic
resource "aws_sns_topic" "user_updates" {
  name = "user-updates-topic"
}
# Create SNS Topic Subscriptin
# Terraform asw sns topic subscription
resource "aws_sns_topic_subscription" "notification-topic" {
  topic_arn = aws_sns_topic.user_updates.arn
  protocol  = "email"
  endpoint  = var.endpoint-email
}
