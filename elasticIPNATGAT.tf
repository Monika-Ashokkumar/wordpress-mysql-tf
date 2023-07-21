# Create an Elastic IP
resource "aws_eip" "mon-EIP-tf" {
  vpc = true
}

# Create a NAT Gateway
resource "aws_nat_gateway" "mon-NGW-tf" {
  allocation_id = aws_eip.mon-EIP-tf.id
  subnet_id     = aws_subnet.mon-public-subnet-tf.id
}