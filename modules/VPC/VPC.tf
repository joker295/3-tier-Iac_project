# ------------------------
# VPC
# ------------------------

resource "aws_vpc""UAT-VPC"{
    cidr_block = var.cidr_block
    enable_dns_hostnames = true
    tags = {
        Name= "${terraform.workspace}_${var.vpc_name}"
    }
  
}

resource"aws_internet_gateway""main-gtw"{

    vpc_id = aws_vpc.UAT-VPC.id
    
    tags = {
        Name= "${terraform.workspace}_IGW"
    }
  



}
# ------------------------
# Public Subnet
# -----------------------
resource "aws_subnet""public_subnet" {
    count             = length(var.public_cidr)
    vpc_id            = aws_vpc.UAT-VPC.id
    cidr_block        = var.public_cidr[count.index]
    availability_zone = var.azs[count.index] 
    tags = {

        Name = "${terraform.workspace}-public-{count.index}" 

        }
}
# ------------------------
# Private Subnet
# ------------------------
resource "aws_subnet""private_subnet"{
    count = length(var.private_cidr)
    vpc_id = aws_vpc.UAT-VPC.id
    availability_zone = var.azs[count.index]
    cidr_block = var.private_cidr[count.index]
    tags={

        Name = "${terraform.workspace}-private-{count.index}" 
        }

}

# ------------------------
# NAT Gateway
# ------------------------
resource "aws_eip" "nat_eip" {
    tags= {
        name = "${var.vpc_name}_eip"
    }
}

resource "aws_nat_gateway""nat-gw-UAT" {
    allocation_id = aws_eip.nat_eip.id 
    subnet_id     = aws_subnet.public_subnet[1].id
    tags = {

        Name= "${terraform.workspace}_nat-gw"  
    }
}
# ------------------------
# Route Table -1
# ------------------------

resource"aws_route_table""public_route_table"{
    vpc_id = aws_vpc.UAT-VPC.id
    
    route {
        gateway_id = aws_internet_gateway.main-gtw.id
        cidr_block = "0.0.0.0/0"

    }  

    tags = {
      Name = "${terraform.workspace}_public-rt" 
    }
    
}

# ------------------------
# Public Route table Association 
# ------------------------

resource "aws_route_table_association" "public_association" {
  count          = length(aws_subnet.public_subnet) 
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

# ------------------------
# Route Table -2
# ------------------------

resource"aws_route_table""private_route_table"{
    vpc_id = aws_vpc.UAT-VPC.id
    
    route {
        gateway_id = aws_nat_gateway.nat-gw-UAT.id
        cidr_block = "0.0.0.0/0"

    }  

    tags = {
      Name = "${terraform.workspace}_private-rt" 
    }       
    
}
# ------------------------
# Private Route table Association 
# ------------------------
resource "aws_route_table_association""private_association" {
  count          = length(aws_subnet.private_subnet) 
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}
