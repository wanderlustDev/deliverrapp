resource "aws_elastic_beanstalk_application" "eb_app" {
  name        = "${var.app}-${var.environment}-eb-app"
  description = "$Elastic Beanstalk application"

  tags = {
    Environment = var.environment
  }
}

resource "aws_elastic_beanstalk_application_version" "eb_app_version" {
  application = aws_elastic_beanstalk_application.eb_app.name
  bucket      = var.app_s3_bucket
  key         = var.app_s3_bucket_key
  name        = "${var.app}-${var.environment}-eb-app-version"
  description = "Elastic Beanstalk application version"

  tags = {
    Environment = var.environment
  }
}

resource "aws_elastic_beanstalk_environment" "eb_env" {
  name                = "${var.app}-${var.environment}-eb-env"
  application         = aws_elastic_beanstalk_application.eb_app.name
  description         = "Elastic Beanstalk Environment"
  solution_stack_name = "64bit Amazon Linux 2 v3.1.6 running Corretto 11"

  setting {
    name      = "Availability Zones"
    namespace = "aws:autoscaling:asg"
    value     = "Any 1"
  }
  setting {
    name      = "MinSize"
    namespace = "aws:autoscaling:asg"
    value     = "1"
  }
  setting {
    name      = "MaxSize"
    namespace = "aws:autoscaling:asg"
    value     = "1"
  }
  setting {
    name      = "IamInstanceProfile"
    namespace = "aws:autoscaling:launchconfiguration"
    value     = var.iam_instance_profile
  }
  setting {
    name      = "InstanceType"
    namespace = "aws:autoscaling:launchconfiguration"
    value     = var.ec2_instance_type
  }
  setting {
    name      = "SecurityGroups"
    namespace = "aws:autoscaling:launchconfiguration"
    value     = var.ec2_security_group
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SSHSourceRestriction"
    value     = var.ec2_security_group
  }
  setting {
    name      = "VPCId"
    namespace = "aws:ec2:vpc"
    value     = var.vpc_id
  }
  setting {
    name      = "Subnets"
    namespace = "aws:ec2:vpc"
    value     = var.public_subnet_id
  }
  setting {
    name      = "AssociatePublicIpAddress"
    namespace = "aws:ec2:vpc"
    value     = true
  }
  setting {
    name      = "EnvironmentType"
    namespace = "aws:elasticbeanstalk:environment"
    value     = "SingleInstance"
  }
  setting {
    name      = "ServiceRole"
    namespace = "aws:elasticbeanstalk:environment"
    value     = var.service_role
  }

  tags = {
    Environment = var.environment
  }
}