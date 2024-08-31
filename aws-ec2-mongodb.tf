resource "aws_instance" "wiz-mongodb" {
  ami           = "ami-0932dacac40965a65" # Ubuntu 22.04 LTS
  instance_type = "t2.micro"
  count         = 1
  key_name        = aws_key_pair.wiz-ssh-keypair.key_name
  subnet_id       = aws_subnet.wiz-public-subnet.id
  security_groups  = [aws_security_group.wiz-tasky-sg.id]
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.wiz-ec2-role-attachment.name
  user_data = base64encode(templatefile("mongodb-init.sh.tpl", {
    MONGODB_USER  = var.mongodb_user
    MONGODB_PASS  = var.mongodb_pass
  } ))
  tags = {
    Name = "wiz-mongodb"
  }
}

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
