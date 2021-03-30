# create a zip of deployment jar
data "archive_file" "app_jar_zip" {
  type        = "zip"
  source_file = "${path.root}/${var.file_location}"
  output_path = "${path.root}/${var.file_location}.zip"
}

resource "aws_s3_bucket" "app_bucket" {
  bucket = "${var.app}-${var.environment}-bucket"
  acl    = "private"

  tags = {
    Name        = "${var.app}-${var.environment}-s3-bucket"
    Environment = var.environment
  }
}
resource "aws_s3_bucket_object" "app_jar" {
  key    = "${var.app}-${var.environment}/app-${uuid()}"
  bucket = aws_s3_bucket.app_bucket.id
  source = data.archive_file.app_jar_zip.output_path

  tags = {
    Name        = "${var.app}-${var.environment}-s3-bucket-obj"
    Environment = var.environment
  }
}