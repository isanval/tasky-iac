# environment variables

variable "region" {
  description = "Default AWS region"
  type        = string
}

variable "project_name" {
  description = "YouTube Downloader App"
  type        = string
}

variable "environment" {
  description = "Environment description"
  type        = string
}

variable "mongodb_s3_backup_bucket" {
  description = "S3 bucket for MongoDB backups"
  type = string
}

variable "mongodb_s3_backup_user" {
  description = "Username for access to S3 bucket for MongoDB backups"
  type = string
}
