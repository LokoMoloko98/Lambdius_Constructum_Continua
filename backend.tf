# store the terraform state file in s3 and lock with dynamodb
terraform {
  backend "s3" {
    bucket         = "mol-remote-states-store"
    key            = "Lambdius_Constructum_Continua/state.tfstate"
    region         = "us-east-1"
    profile        = "default"
    dynamodb_table = "terraform-state-lock"
  }
}