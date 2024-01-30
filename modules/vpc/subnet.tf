# # create the Public Subnet
resource "aws_subnet" "public_subnet" {
  count = 3
  vpc_id = aws_vpc.vpc.id
  cidr_block = "${element(var.public_subnet_cidr, count.index)}"
  availability_zone = "${element(var.subnet_azs, count.index)}"
  map_public_ip_on_launch = true
  tags = {
    Name        = "${var.app_name}-public-subnet-${count.index + 1}"
    Environment = var.app_environment
  }
}

# # create the Private Subnet
resource "aws_subnet" "private_subnet" {
  count = 3
  vpc_id = aws_vpc.vpc.id
  cidr_block = "${element(var.private_subnet_cidr, count.index)}"
  availability_zone = "${element(var.subnet_azs, count.index)}"
  tags = {
    Name        = "${var.app_name}-private-subnet-${count.index + 1}"
    Environment = var.app_environment
  }
}





