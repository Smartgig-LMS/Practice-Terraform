resource "aws_eip" "eip-ngw" {
  vpc      = true
  tags = {
    Name        = "${var.app_name}-ngw"
    Environment = var.app_environment
  }
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eip-ngw.id
  subnet_id     = aws_subnet.public_subnet.0.id

  tags = {
    Name        = "${var.app_name}-ngw"
    Environment = var.app_environment
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}