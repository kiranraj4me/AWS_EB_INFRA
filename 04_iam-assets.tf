variable "iam_application_policy_arn" {
  description = "IAM Policy to be attached to Application role"
  type = "list"
  default = [
            "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess", 
            "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess",
            "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker",
            "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess",
            "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier",
            "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier",
            "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
            ]
}

variable "iam_service_policy_arn" {
  description = "IAM Policy to be attached to Service role"
  type = "list"
  default = [
           "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkEnhancedHealth",
           "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkService"
            ]
}

resource "aws_iam_role" "iam-application-role" {
  name = "${var.env}-${var.app-name}-iam-application-role"
  assume_role_policy = "${file("policy/application-role.json")}"

  tags = local.common_tags
}

resource "aws_iam_role" "service-iam-role" {
  name = "${var.env}-${var.app-name}-iam-service-role"
  assume_role_policy = "${file("policy/service-role.json")}"

 tags = local.common_tags
}

resource "aws_iam_role_policy_attachment" "policy-attach" {
  role       = "${aws_iam_role.iam-application-role.name}"
  count      = "${length(var.iam_application_policy_arn)}"
  policy_arn = "${var.iam_application_policy_arn[count.index]}"
 }

resource "aws_iam_role_policy_attachment" "service-policy-attach" {
  role       = "${aws_iam_role.service-iam-role.name}"
  count      = "${length(var.iam_service_policy_arn)}"
  policy_arn = "${var.iam_service_policy_arn[count.index]}"
 }

data "template_file" "s3-read-policy" {
  template = "${file("policy/bucket-read.json")}"

  vars = {
    resource = "arn:aws:s3:::${lookup(var.s3-bucket, var.account-type[var.env])}/*"
  }
}

data "template_file" "ecr-fetch" {
  template = "${file("policy/ecr-repo-fetch.json")}"
}

resource "aws_iam_policy" "update-s3-policy" {
   name       = "${var.env}-${var.app-name}-S3-AgentBucket-Read"
   policy = "${data.template_file.s3-read-policy.rendered}"
}

resource "aws_iam_policy" "ecr-fetch-policy" {
   name       = "${var.env}-${var.app-name}-ecr-fetch-policy"
   policy = "${data.template_file.ecr-fetch.rendered}"
}

resource "aws_iam_role_policy_attachment" "attach-s3agentBucket" {
    role       = "${aws_iam_role.iam-application-role.name}"
    policy_arn = "${aws_iam_policy.update-s3-policy.arn}"
}

resource "aws_iam_role_policy_attachment" "ecr-fetch-attach" {
   role       = "${aws_iam_role.iam-application-role.name}"
   policy_arn = "${aws_iam_policy.ecr-fetch-policy.arn}"
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.env}-${var.app-name}-instance-profile"
  role = "${aws_iam_role.iam-application-role.name}"
}
