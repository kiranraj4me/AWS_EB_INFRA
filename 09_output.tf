output "vpc"{
value = var.vpc[var.env]
}
output "account"{
    value = "${lookup(var.account-id, var.account-type[var.env])}"
    }
output "env-name"{
     value = "${var.env}-${var.app-name}"
}
output "s3_bucket" {
      value = "${lookup(var.s3-bucket, var.account-type[var.env])}"
}
