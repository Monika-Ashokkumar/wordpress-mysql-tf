resource "aws_route_table" "mon_nat_route_table_tf" {
  vpc_id = aws_vpc.mon-vpc-app1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.mon-NGW-tf.id
  }

  tags = {
    Name = "mon-nat-route-table-tf"
  }
}

resource "aws_route_table_association" "mon_route_table_to_pri_sn_tf" {
  subnet_id      = aws_subnet.mon-private-subnet-tf.id
  route_table_id = aws_route_table.mon_nat_route_table_tf.id
}
