variable "env" {
default = "dev"
}
variable "app-name" {
    default = "hackathon"
}
variable "health" {
    type = "map"
    default = {
  "prod"    = "/api/datachart/healthcheck"
  "non-prod" = "/api/datachart/healthcheck"
  }
}
provider "aws" {
  region = "us-east-2"
}

variable "build-commit" {
default = "1234"
}
variable "build-repo" {
default = "repo_url"
}
variable "build-branch" {
default = "repo_branch"
}

locals {
    build-commit = var.build-commit
    build-repo = var.build-repo
    build-branch = var.build-branch
}

locals {
  common_tags = {
  "contact" = "kiran"
  "build-commit" = local.build-commit
  "build-repo" = local.build-repo
  "build-branch" = local.build-branch
  }
}

output "tags-out" {
  value = local.common_tags
}
