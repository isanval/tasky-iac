resource "aws_instance" "wiz-mongodb" {
  ami           = "ami-0932dacac40965a65" # Ubuntu 22.04 LTS
  instance_type = "t2.micro"
  count         = 1
  key_name        = aws_key_pair.wiz-ssh-keypair.key_name
  subnet_id       = aws_subnet.wiz-public-subnet.id
  security_groups  = [aws_security_group.wiz-tasky-sg.id]
  associate_public_ip_address = true
  user_data = base64encode(templatefile("mongodb-init.sh.tpl", {
    MONGODB_USER  = var.mongodb_user
    MONGODB_PASS  = var.mongodb_pass
  } ))
/*
  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install gnupg curl
              curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
              gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
              --dearmor
              echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
              apt-get update
              apt-get install -y mongodb-org
              systemctl start mongod
              systemctl enable mongodb
              echo 'db.createUser({user:"wiz", pwd:"hackme", roles:[]})' | mongosh
              echo "security.authorization : enabled" >> /etc/mongod.conf
              systemctl restart mongod
              EOF
*/
  tags = {
    Name = "wiz-mongodb"
  }
}

resource "aws_key_pair" "wiz-ssh-keypair" {
  key_name   = "wiz-ssh-keypair"
  public_key = file("./id_rsa.pub")
}
