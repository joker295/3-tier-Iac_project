resource"aws_vpc""Devops"{

    cidr_block = var.vpc_cidr

}

# Subnets

resource "aws_subnet""Devops-Public-1"{

vpc_id = aws_vpc.Devops.id
cidr_block = var.Subnet_cidr
availability_zone = "ap-south-1a"
  
}

# Internet Gateway

resource "aws_internet_gateway""Dev-IGW"{

    vpc_id = aws_vpc.Devops.id
}

