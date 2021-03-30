variable "app" {
  type = string
}

variable "environment" {
  type = string
}

variable "app_s3_bucket" {
  type = string
}

variable "app_s3_bucket_key" {
  type = string
}

variable "iam_instance_profile" {
  type = string
}

variable "ec2_instance_type" {
  type = string
}

variable "ec2_security_group" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_id" {
  type = string
}

variable "service_role" {
  type = string
}