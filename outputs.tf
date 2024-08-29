
output "mongodb-s3-backup-user-id" {
  value = aws_iam_access_key.mongodb-s3-backup-user-key.id
}

output "mongodb-s3-backup-user-key" {
  value = aws_iam_access_key.mongodb-s3-backup-user-key.secret
  sensitive = true
}
