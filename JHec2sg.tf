resource "aws_security_group" "mon_sg_jump_host_tf" {
  depends_on   = [
    aws_vpc.mon-vpc-app1,
  ]
  
  name         = "mon-sg-jump-host-tf"
  description  = "jump host security group"
  vpc_id       = aws_vpc.mon-vpc-app1.id
  
  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "jump_host" {
  depends_on = [
    aws_security_group.mon_sg_jump_host_tf,
  ]
  
  ami                      = "ami-069d73f3235b535bd"
  instance_type            = "t2.micro"
  key_name                 = "K8S"  # Fixed the attribute here
  
  vpc_security_group_ids   = [aws_security_group.mon_sg_jump_host_tf.id]
  subnet_id                = aws_subnet.mon-public-subnet-tf.id
  
  tags = {
    Name = "jump host"
  }
}
