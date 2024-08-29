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
    Name        = "isv-mongodb-backup"
    Environment = var.environment
  }
}

# https://awspolicygen.s3.amazonaws.com/policygen.html
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.mongodb-s3-backup-bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid: "AllAccess",
        Effect: "Allow",
        Principal: "*",
        Action: "s3:*",
        Resource: [
          "${aws_s3_bucket.mongodb-s3-backup-bucket.arn}/*",
          "${aws_s3_bucket.mongodb-s3-backup-bucket.arn}"
        ]
      },
      {
        Effect = "Allow",
        Principal = {
          AWS = [
            "arn:aws:iam::602457137222:user/terraform-user",
            "${aws_iam_user.mongodb-s3-backup-user.arn}"
          ]
        }
        Action = [
          "s3:*"
        ]
        Resource = [
          "${aws_s3_bucket.mongodb-s3-backup-bucket.arn}/*",
          "${aws_s3_bucket.mongodb-s3-backup-bucket.arn}"
        ]
      },
      {
        Effect : "Deny",
        NotPrincipal : {
          "AWS" : [
            "arn:aws:iam::602457137222:user/terraform-user",
            "${aws_iam_user.mongodb-s3-backup-user.arn}"
          ]
        },
        Action : "*:*",
        Resource : [
          "${aws_s3_bucket.mongodb-s3-backup-bucket.arn}/*",
          "${aws_s3_bucket.mongodb-s3-backup-bucket.arn}"
        ]
      }
    ]
  })
}


{
  "Id": "BucketPolicy",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllAccess",
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": [
         "arn:aws:s3:::my-bucket",
         "arn:aws:s3:::my-bucket/*"
      ],
      "Principal": "*"
    }
  ]
}