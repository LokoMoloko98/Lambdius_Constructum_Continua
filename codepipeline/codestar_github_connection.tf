resource "aws_codestarconnections_connection" "github_connection" {
  name          = "${var.project_name}-GitHubConnection"
  provider_type = "GitHub"
}
