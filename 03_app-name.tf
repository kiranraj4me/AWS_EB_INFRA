resource "aws_elastic_beanstalk_application" "app_namespace" {
 name = upper(var.app-name)
  tags = local.common_tags
}
