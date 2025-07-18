resource "aws_instance""Devops-machine"{
count         = 1
ami           = "ami-0f918f7e67a3323f0"
instance_type = "t2.micro" 
subnet_id     = var.subnet_id

}


resource"aws_security_group""sg-1"{

vpc_id = var.vpc_id
name = "security-group-1"
ingress {   

    description= "Allows SSH Access"
    to_port = 22
    from_port= 22   
    protocol= "tcp"
    cidr_blocks = ["0.0.0.0/0"]

}
}