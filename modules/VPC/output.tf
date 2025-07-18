output "vpc_id"{

value = aws_vpc.Devops.id

}

output "subnet_id"{

    value = aws_subnet.Devops-Public-1.id
  
}

output "internet-gateway"{

    value = aws_internet_gateway.Dev-IGW.id
}
