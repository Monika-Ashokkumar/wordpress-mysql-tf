resource "aws_security_group" "mon-sg-wordpress-tf" {
  depends_on = [
    aws_vpc.mon-vpc-app1,
  ]

  description = "Allow http inbound traffic"
  vpc_id      = aws_vpc.mon-vpc-app1.id

  ingress {
    description = "allow TCP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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

# wordpress ec2 instance
resource "aws_instance" "mon-wordpress-tf" {
  depends_on = [
    aws_security_group.mon-sg-wordpress-tf,
    aws_instance.mon-mysql-tf
  ]

  ami           = "ami-069d73f3235b535bd"
  instance_type = "t2.micro"
  key_name      = "K8S"
  vpc_security_group_ids = [aws_security_group.mon-sg-wordpress-tf.id]
  subnet_id     = aws_subnet.mon-public-subnet-tf.id
  user_data = file("wordpress.sh") 

  // user_data = <<-EOF
  //  #!/bin/bash
  //  yum update
  //  yum install docker -y
  //  systemctl restart docker
  //  systemctl enable docker
  // docker pull wordpress
  //  docker run --name wordpress -p 80:80 -e WORDPRESS_DB_HOST=192.168.1.70 \
  //  -e WORDPRESS_DB_USER=root -e WORDPRESS_DB_PASSWORD=root -e WORDPRESS_DB_NAME=wordpressdb -d wordpress
  // EOF

  tags = {
    Name = "wordpress"
  }
}

