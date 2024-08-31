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
