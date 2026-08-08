terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "terraform_project/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
  }
}
