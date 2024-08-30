# store the terraform state file in s3 and lock with dynamodb
terraform {
  backend "s3" {
    bucket         = "wiz-cnapp-terraform-state"
    key            = "terraform/youtube-downloader-infra/terraform.tfstate"
    encrypt        = true
    region         = "eu-west-1"
    profile        = "terraform-user"
    dynamodb_table = "wiz-cnapp-terraform-state-lock"
  }
}