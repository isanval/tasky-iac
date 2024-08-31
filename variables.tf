# environment variables

variable "region" {
  description = "Default AWS region"
  type        = string
}

variable "project_name" {
  description = "Tasky App"
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

variable "mongodb_user" {
  description = "MongoDB User"
  type = string
}

variable "mongodb_pass" {
  description = "MongoDB Password"
  type = string
}

variable "mongodb_secret" {
  description = "MongoDB Secret Key"
  type = string
}
