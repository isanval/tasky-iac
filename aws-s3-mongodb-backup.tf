resource "aws_s3_bucket" "mongodb-s3-backup-bucket" {
  bucket = var.mongodb_s3_backup_bucket

  tags = {
    Name        = "wiz-mongodb-backup"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_public_access_block" "mongodb-s3-backup-public" {
  bucket = aws_s3_bucket.mongodb-s3-backup-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  restrict_public_buckets = false
  ignore_public_acls      = false
}

resource "aws_s3_bucket_policy" "mongodb-s3-backup-bucket_policy" {
  bucket = aws_s3_bucket.mongodb-s3-backup-bucket.id
  depends_on = [ aws_s3_bucket_public_access_block.mongodb-s3-backup-public ]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = [
          "s3:GetObject",        # Permite descargar objetos
          "s3:ListBucket"        # Permite listar los objetos en el bucket
        ]
        Effect    = "Allow"
        Resource  = "${aws_s3_bucket.mongodb-s3-backup-bucket.arn}/*"
        Resource = [
          "${aws_s3_bucket.mongodb-s3-backup-bucket.arn}/*",  # Acceso a los objetos dentro del bucket
          "${aws_s3_bucket.mongodb-s3-backup-bucket.arn}"     # Acceso al listado de objetos en el bucket
        ]
        Principal = "*"
      }
    ]
  })
}
