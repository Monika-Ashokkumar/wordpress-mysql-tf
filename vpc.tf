# vpc
resource "aws_vpc" "mon-vpc-app1" {
  cidr_block       = "192.168.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "mon-vpc-app1"
  }

  enable_dns_hostnames = true
}

