terraform {
  required_providers {
    aws = {
      version = "2.33.0"
    }
    random = {
      version = "2.2"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "random" {}

resource "random_pet" "table_name" {}

resource "aws_dynamodb_table" "tfc_example_table" {
  name = "${var.db_table_name}-${random_pet.table_name.id}"

  read_capacity  = var.db_read_capacity
  write_capacity = var.db_write_capacity
  hash_key       = "UUID"
  range_key      = "UserNameTwo"

  attribute {
    name = "UUID"
    type = "S"
  }

  attribute {
    name = "UserNameTwo"
    type = "S"
  }
}
