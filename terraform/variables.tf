variable "app" {
  type    = string
  default = "deliverr"
}

variable "region" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "public_subnet_cidr" {
  type = string
}

variable "private_subnet_cidr" {
  type = string
}

variable "private_subnet_cidr_2" {
  type = string
}

variable "rds_identifier" {
  type = string
}

variable "rds_engine" {
  type = string
}

variable "rds_engine_version" {
  type = string
}

variable "rds_instance_class" {
  type = string
}

variable "rds_allocated_storage" {
  type = string
}

variable "rds_name" {
  type = string
}

variable "rds_username" {
  type = string
}

variable "rds_password" {
  description = "The password of the DB master user"
}

variable "rds_skip_final_snapshot" {
  type    = bool
  default = true
}

variable "access_key" {
  description = "The username for the IAM user"
  type        = string
}

variable "secret_key" {
  description = "The password for the IAM user"
  type        = string
}

variable "file_location" {
  type    = string
  default = "../../ClaimsApp/target/claims-0.0.1-SNAPSHOT.jar"
}

variable "availability_zone_a" {
  type    = string
  default = "us-west-2a"
}

variable "availability_zone_b" {
  type    = string
  default = "us-west-2b"
}

variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"
}