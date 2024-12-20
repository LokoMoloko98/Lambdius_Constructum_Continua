resource "aws_codestarconnections_connection" "github_connection" {
  name          = "GitHubConnection"
  provider_type = "GitHub"
}
