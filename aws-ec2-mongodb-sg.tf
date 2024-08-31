resource "aws_security_group" "wiz-tasky-sg" {
  name        = "wiz-tasky-sg"
  description = "Allow SSH inbound traffic, VPC traffic and all outbound traffic"
  vpc_id      = aws_vpc.wiz-vpc.id

  tags = {
    Name = "wiz-tasky-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.wiz-tasky-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_vpc_ipv4" {
  security_group_id = aws_security_group.wiz-tasky-sg.id
  cidr_ipv4         = aws_vpc.wiz-vpc.cidr_block
  ip_protocol       = -1
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.wiz-tasky-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
