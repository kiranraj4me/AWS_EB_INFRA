resource "aws_elastic_beanstalk_environment" "beanstalk-env" {
  name = "${var.env}-${var.app-name}"
  application = upper(var.app-name)
  solution_stack_name = "${lookup(var.solution-stack, var.account-type[var.env])}"
  cname_prefix = "${var.env}-${var.app-name}"
  setting {
    namespace = "aws:autoscaling:asg"
    name = "MinSize"
    value = "${var.asg-minsize[var.env]}"
  }
    setting {
    namespace = "aws:autoscaling:asg"
    name = "Availability Zones"
    value = "Any 3"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "AssociatePublicIpAddress"
    value = "false"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name = "MaxSize"
    value = "${var.asg-maxsize[var.env]}"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "IamInstanceProfile"
    value = "${aws_iam_instance_profile.instance_profile.arn}"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "InstanceType"
    value = "${var.instance-type[var.env]}"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "MonitoringInterval"
    value = "${var.cloudwatch-monitor-interval[var.env]}"
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "SecurityGroups"
    value = "${aws_security_group.instance-security-group.id}"
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name = "BreachDuration"
    value = "5"
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name = "LowerBreachScaleIncrement"
    value = "-1"
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name = "LowerThreshold"
    value = "20"
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name = "MeasureName"
    value = "CPUUtilization"
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name = "Period"
    value = "5"
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name = "Unit"
    value = "Percent"
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name = "UpperBreachScaleIncrement"
    value = "1"
  }
  setting {
    namespace = "aws:autoscaling:trigger"
    name = "UpperThreshold"
    value = "60"
  }
  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name = "MaxBatchSize"
    value = "1"
  }
  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name = "MinInstancesInService"
    value = "1"
  }
  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name = "RollingUpdateEnabled"
    value = "false"
  }
  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name = "RollingUpdateType"
    value = "Health"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "VPCId"
    value = "${var.vpc[var.env]}"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "Subnets"
    value = "${var.private-subnet[var.env]}"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "ELBSubnets"
    value = "${var.public-subnet[var.env]}"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name = "ELBScheme"
    value = "public"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application"
    name      = "Application Healthcheck URL"
    value     = "HTTP:80${lookup(var.health, var.account-type[var.env])}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:command"
    name = "DeploymentPolicy"
    value = "AllAtOnce"
  }
  setting {
    namespace = "aws:elasticbeanstalk:command"
    name = "BatchSize"
    value = "100"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name = "ServiceRole"
    value = "${aws_iam_role.service-iam-role.name}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name = "LoadBalancerType"
    value = "application"
  }
  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name = "SystemType"
    value = "enhanced"
  }
  setting {
    namespace = "aws:elasticbeanstalk:managedactions"
    name = "ManagedActionsEnabled"
    value = "true"
  }
  setting {
    namespace = "aws:elasticbeanstalk:managedactions"
    name = "PreferredStartTime"
    value = "Sun:05:00"
  }
  setting {
    namespace = "aws:elasticbeanstalk:managedactions:platformupdate"
    name = "UpdateLevel"
    value = "minor"
  }
  setting {
    namespace = "aws:elbv2:loadbalancer"
    name = "SecurityGroups"
    value = "${aws_security_group.internal-elb-security-group.id}"
  }
  setting {
    namespace = "aws:elbv2:loadbalancer"
    name = "ManagedSecurityGroup"
    value = "${aws_security_group.internal-elb-security-group.id}"
  }
  setting {
    namespace = "aws:elbv2:listener:default"
    name = "ListenerEnabled"
    value = "true"
  }
  setting {
    namespace = "aws:elbv2:listener:80"
    name = "ListenerEnabled"
    value = "true"
  }
  setting {
    namespace = "aws:elbv2:listener:80"
    name = "Protocol"
    value = "HTTP"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name = "HealthCheckPath"
    value = "${lookup(var.health, var.account-type[var.env])}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name = "Port"
    value = "80"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name = "Protocol"
    value = "HTTP"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name = "StickinessEnabled"
    value = "false"
  }
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name = "Environment"
    value = "${var.env}"
  }
    setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name = "Application"
    value = "${var.app-name}"
  }
  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs"
    name = "StreamLogs"
    value = "true"
  }
  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs"
    name = "RetentionInDays"
    value = "90"
  }
  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs:health"
    name = "HealthStreamingEnabled"
    value = "true"
  }
  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs:health"
    name = "RetentionInDays"
    value = "90"
  }
  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs"
    name      = "DeleteOnTerminate"
    value     = "true"
  }



tags = local.common_tags
}