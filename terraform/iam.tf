resource "aws_iam_role" "eb_ec2_role" {
  name               = "eb_e2_role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.eb_ec2_assume_role_policy.json

  tags = {
    Environment = var.environment
  }
}

resource "aws_iam_role" "eb_service_role" {
  name               = "eb_service_role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.eb_service_assume_role_policy.json

  tags = {
    Environment = var.environment
  }
}

resource "aws_iam_instance_profile" "eb_instance_profile" {
  name = "eb_user_profile2"
  role = aws_iam_role.eb_ec2_role.name

  tags = {
    Environment = var.environment
  }
}

resource "aws_iam_policy" "eb_user_policy" {
  name   = "${var.environment}-eb-iam-access-policy"
  policy = data.aws_iam_policy_document.eb_user_policy_document.json
}

resource "aws_iam_role_policy_attachment" "eb_policy_to_ec2_role" {
  policy_arn = aws_iam_policy.eb_user_policy.arn
  role       = aws_iam_role.eb_ec2_role.name
}

resource "aws_iam_role_policy_attachment" "eb_policy_to_service_role" {
  policy_arn = aws_iam_policy.eb_user_policy.arn
  role       = aws_iam_role.eb_service_role.name
}

data "aws_iam_policy_document" "eb_user_policy_document" {
  statement {
    sid = "userSid"

    actions = [
      "ec2:*",
      "ecs:*",
      "elasticloadbalancing:*",
      "autoscaling:*",
      "cloudwatch:*",
      "s3:*",
      "sns:*",
      "cloudformation:*",
      "sqs:*",
      "rds:*"
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "eb_ec2_assume_role_policy" {
  statement {
    sid = "assumeSid"

    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["ec2.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "eb_service_assume_role_policy" {
  statement {
    sid = "assumeSid"

    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["elasticbeanstalk.amazonaws.com"]
      type        = "Service"
    }

    condition {
      test     = "StringEquals"
      values   = ["elasticbeanstalk"]
      variable = "sts:ExternalId"
    }
  }
}