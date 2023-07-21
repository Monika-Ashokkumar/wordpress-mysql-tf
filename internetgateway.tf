# internet gateway
resource "aws_internet_gateway" "internet_gateway" {
  depends_on = [
    aws_vpc.mon-vpc-app1,
  ]

  vpc_id = aws_vpc.mon-vpc-app1.id

  tags = {
    Name = "internet-gateway"
  }
}