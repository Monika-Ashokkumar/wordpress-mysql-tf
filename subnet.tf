# public subnet
resource "aws_subnet" "mon-public-subnet-tf" {
  depends_on = [
    aws_vpc.mon-vpc-app1
  ]

  vpc_id = aws_vpc.mon-vpc-app1.id
  cidr_block = "192.168.0.0/24"
  availability_zone_id = "use2-az1"

  tags = {
    Name = "mon-public-subnet-tf"
  }

  map_public_ip_on_launch = true
}

# private subnet
resource "aws_subnet" "mon-private-subnet-tf" {
  depends_on = [
    aws_vpc.mon-vpc-app1
  ]

  vpc_id = aws_vpc.mon-vpc-app1.id
  cidr_block = "192.168.1.0/24"
  availability_zone_id = "use2-az2"

  tags = {
    Name = "mon-private-subnet-tf"
  }
}
