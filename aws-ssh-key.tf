resource "aws_key_pair" "wiz-ssh-keypair" {
  key_name   = "wiz-ssh-keypair"
  public_key = file("./id_rsa.pub")
}