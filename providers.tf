terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      "Automation" = "terraform"
      "Project"    = var.project_name
    }
  }
}


data "aws_ssm_parameter" "github_pat" {
  name = "Github_PAT"
}

provider "github" {
  token = data.aws_ssm_parameter.github_pat.value
}