## backend for the state file
terraform {
  backend "s3" {
    bucket = "asalu123"
    key    = "nexgen-prod.tfstate"
    region = "us-east-1"


  }
}