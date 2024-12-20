# data "aws_ssm_parameter" "Github_Webhook_token" {
#   name = "Github_Webhook_token"
# }

# resource "aws_codepipeline_webhook" "github_webhook" {
#   name            = "${var.project_name}-github-webhook"
#   target_action   = "Source"
#   target_pipeline = aws_codepipeline.lambdius-constructum-continua-lambda-codepipeline.name
#   authentication  = "GITHUB_HMAC" # This should be a string

#   authentication_configuration {
#     secret_token = data.aws_ssm_parameter.Github_Webhook_token.value
#   }

#   filter {
#     json_path    = "$.ref"
#     match_equals = "refs/heads/main" # Trigger only on changes to the main branch
#   }
