# store the terraform state file in s3 and lock with dynamodb
terraform {
  backend "s3" {
    bucket         = "isv-cnapp-terraform-state"
    key            = "terraform/youtube-downloader-infra/terraform.tfstate"
    encrypt        = true
    region         = "eu-west-1"
    profile        = "terraform-user"
    dynamodb_table = "isv-cnapp-terraform-state-lock"
  }
}