# ROUTING #
resource "aws_route_table" "pub-rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

}

resource "aws_route_table" "private-rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    #nat_gateway_id = aws_nat_gateway.nat.id
    gateway_id = aws_internet_gateway.igw.id

  }

}

resource "aws_route_table_association" "rta-pub-sub1" {
  subnet_id      = aws_subnet.pub-sub1.id
  route_table_id = aws_route_table.pub-rtb.id
}

resource "aws_route_table_association" "rta-private-sub1" {
  subnet_id      = aws_subnet.private-sub1.id
  route_table_id = aws_route_table.private-rtb.id
}

resource "aws_route_table_association" "rta-pub-sub2" {
  subnet_id      = aws_subnet.pub-sub1.id
  route_table_id = aws_route_table.pub-rtb.id
}

resource "aws_route_table_association" "rta-private-sub2" {
  subnet_id      = aws_subnet.private-sub1.id
  route_table_id = aws_route_table.private-rtb.id
}
