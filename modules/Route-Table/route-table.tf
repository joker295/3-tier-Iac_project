resource "aws_route_table" "route-public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet-gateway
  }

  tags = {
    Name = "example"
  }
}

resource "aws_route_table_association" "example" {
  subnet_id      = var.subnet_id
  route_table_id = aws_route_table.route-public.id
}
