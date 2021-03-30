variable "environment" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "engine" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "name" {
  type = string
}

variable "username" {
  type = string
}

variable "password" {
  type = string
}

variable "allocated_storage" {
  type = string
}

variable "skip_final_snapshot" {
  type = bool
}

variable "db_security_group_id" {
  type = string
}