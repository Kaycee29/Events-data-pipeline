terraform {
  backend "s3" {
    bucket         = "events-ticket-2025"
    key            = "terraform.tfstate"
    region         = "us-east-1"
  }
}