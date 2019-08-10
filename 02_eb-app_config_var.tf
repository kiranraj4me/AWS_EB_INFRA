variable "account-type" {
    type = "map"
    default = {
        dev = "non-prod" 
        qa = "non-prod"
        uat = "non-prod"
        prod = "prod"
    }
}
variable "solution-stack" {
    type = "map"
    default = {
    "non-prod" = "64bit Amazon Linux 2018.03 v2.12.16 running Docker 18.06.1-ce"
    "prod" = "64bit Amazon Linux 2018.03 v2.12.16 running Docker 18.06.1-ce"
    }
}
variable "account-id" {
    type = "map"
    default = {
    "non-prod" = ""
    "prod" = ""
    }
}

variable "vpc" {
    type = "map"
    default = {
    "dev" = "vpc-" 
    "qa" = "vpc-"
    "uat" = "vpc-"
    "prod" = ""
    }
}

variable "private-subnet" {
    type = "map"
    default = {
    "dev" = "subnet-,subnet-,subnet-"
    "qa" = "subnet-,subnet-,subnet-"
    "uat" = "subnet-a7279488,subnet-bb6810df,subnet-6c1da931"
    "prod" = "" 
    }
}

variable "public-subnet" {
    type    = "map"
    default = {
       "dev" = "subnet-,subnet-,subnet-00c5669f7ded1289d"
       "qa" = "subnet-6c8d2931,subnet-718df915,subnet-218a290e" 
       "uat" = "subnet-9b1ca8c6,subnet-b9037bdd,subnet-27269508"
       "prod" = "" 
        }
    }


variable "s3-bucket" {
    type = "map"
    default = {
  "prod"    = ""
  "non-prod" = ""
  }
}

variable "instance-type" {
type = "map"
default = {
  "dev"  = "t2.large"
  "qa"  = "t2.micro"
  "uat"  = "t2.micro"
  "prod" = "t2.micro"
  }
}

variable "root-volume" {
    type = "map"
    default = {
    "dev"  = "gp2"
    "qa"  = "gp2"
    "uat"  = "gp2"
    "prod" = "gp2"
  }
}

variable "cloudwatch-monitor-interval" {
    type = "map"
    default = {
    "dev"  = "5 minute"
    "qa"  = "5 minute"
    "uat"  = "5 minute"
    "prod" = "1 minute"
  }
}

  variable "asg-minsize" {
    type = "map"
    default = {
    "dev"  = "3"
    "qa"  = "2"
    "uat"  = "2"
    "prod" = "2"
  }
}

variable "asg-maxsize" {
 type = "map"
 default = {
    "dev"  = "4"
    "qa"  = "4"
    "uat"  = "4"
    "prod" = "4"
  }
}