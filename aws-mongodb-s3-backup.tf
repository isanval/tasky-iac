resource "aws_iam_user" "mongodb-s3-backup-user" {
  name = var.mongodb_s3_backup_user
}

resource "aws_iam_access_key" "mongodb-s3-backup-user-key" {
  user = aws_iam_user.mongodb-s3-backup-user.name
}

resource "aws_iam_user_policy_attachment" "iam_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  user       = aws_iam_user.mongodb-s3-backup-user.name
}

resource "aws_s3_bucket" "mongodb-s3-backup-bucket" {
  bucket = var.mongodb_s3_backup_bucket

  tags = {
    Name        = "wiz-mongodb-backup"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_public_access_block" "mongodb-s3-backup-public" {
  bucket = aws_s3_bucket.mongodb-s3-backup-bucket.id

  block_public_acls   = true
  block_public_policy = true
}