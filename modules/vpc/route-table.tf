# -----------------  public route table ----------

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.rt-all-traffic-cidr
    gateway_id = aws_internet_gateway.igw.id
  }


  tags = {
    Name        = "${var.app_name}-route-table-public"
    Environment = var.app_environment
  }
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidr)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public-rt.id
}

# -----------------  private route table ----------

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = var.rt-all-traffic-cidr
    gateway_id = aws_nat_gateway.ngw.id
  }


  tags = {
    Name        = "${var.app_name}-route-table-private"
    Environment = var.app_environment
  }
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_cidr)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_route_table.private-rt.id
}