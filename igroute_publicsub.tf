# route table with target as internet gateway
resource "aws_route_table" "mon-IG-route-table-tf" {
  depends_on = [
    aws_vpc.mon-vpc-app1,
    aws_internet_gateway.internet_gateway,
  ]

  vpc_id = aws_vpc.mon-vpc-app1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "mon-IG-route-table-tf"
  }
}

# associate route table to public subnet
resource "aws_route_table_association" "associate_routetable_to_public_subnet" {
  depends_on = [
    aws_subnet.mon-public-subnet-tf,
    aws_route_table.mon-IG-route-table-tf,
  ]
  subnet_id      = aws_subnet.mon-public-subnet-tf.id
  route_table_id = aws_route_table.mon-IG-route-table-tf.id
}