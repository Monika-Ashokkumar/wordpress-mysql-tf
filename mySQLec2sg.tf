resource "aws_security_group" "mon-sg-mysql-tf" {
  depends_on = [
    aws_vpc.mon-vpc-app1,
  ]

  description = "Allow mysql inbound traffic"
  vpc_id      = aws_vpc.mon-vpc-app1.id

  ingress {
    description = "allow TCP"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    #security_groups = [aws_security_group.mon-sg-wordpress-tf.id]
  }

  ingress {
    description = "allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.mon_sg_jump_host_tf.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# mysql ec2 instance
resource "aws_instance" "mon-mysql-tf" {
  depends_on = [
    aws_security_group.mon-sg-mysql-tf,
    aws_nat_gateway.mon-NGW-tf,
    aws_route_table_association.mon_route_table_to_pri_sn_tf,
  ]

  ami           = "ami-069d73f3235b535bd"
  instance_type = "t2.micro"
  key_name      = "K8S"
  vpc_security_group_ids = [aws_security_group.mon-sg-mysql-tf.id]
  subnet_id     = aws_subnet.mon-private-subnet-tf.id
  user_data = file("mysql.sh") 
  
  //user_data = <<-EOF
  //  #!/bin/bash
  //  sudo yum update
  //  sudo yum install docker -y
  //  sudo systemctl restart docker
  //  sudo systemctl enable docker
  //  sudo docker pull mysql
  //  sudo docker run --name mysql -e MYSQL_ROOT_PASSWORD=root \
  //  -e MYSQL_DATABASE=wordpressdb -p 3306:3306 -d mysql:5.7
  //EOF
  tags = {
    Name = "mysql-instance"
  }
}
