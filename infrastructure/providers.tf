provider "aws" {
  default_tags {
    tags = {
      Environment = "Production"
      Owner       = "Kaycee"
      Project     = "Redshift Deployment"
      Managedby  = "Terraform"
    }
  }

  region = "us-east-1"
}
