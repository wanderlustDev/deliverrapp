output "env_name" {
  value = module.eb.env_name
}

output "app_version" {
  value = module.eb.app_version
}

output "app_name" {
  value = module.eb.app_name
}

output "s3_bucket" {
  value = aws_s3_bucket.app_bucket.id
}

output "s3_bucket_key" {
  value = aws_s3_bucket_object.app_jar.id
}
