resource "aws_iam_role" "wiz-ec2-role" {
  name = "wiz-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_fullaccess_role_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role = aws_iam_role.wiz-ec2-role.name
}

resource "aws_iam_role_policy_attachment" "ec2_fullaccess_role_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  role = aws_iam_role.wiz-ec2-role.name
}

resource "aws_iam_instance_profile" "wiz-ec2-role-attachment" {
  name = "wiz-ec2-role-attachment"
  role = aws_iam_role.wiz-ec2-role.name
}
