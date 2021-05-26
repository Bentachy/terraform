terraform {

  backend "s3" {
    region  = "eu-central-1"
    profile = "crm"

    bucket  = "crm-terraform-state"
    key     = "global/terraform.tfstate"
    encrypt = true

    dynamodb_table = "crm_terraform_state_lock"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3"
    }
  }
}
