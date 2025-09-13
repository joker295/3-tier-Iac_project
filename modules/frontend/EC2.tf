#-----------------------
# EC2 Instances
#------------------------

resource "aws_instance" "frontend"{

        
    count                  = var.instance_count
    instance_type          = var.instance_type 
    ami                    = var.ami
    subnet_id              = element(var.public_subnet, count.index % length(var.public_subnet))
    user_data              = var.user_data
    depends_on             = [aws_security_group.frontend_sg]
    vpc_security_group_ids = [aws_security_group.frontend_sg.id]
   
    tags = {
      "name"        = "${terraform.workspace}-frontend" 
      "Environment" = "${terraform.workspace}"
    }

}


# ---------------------------
# VPC_SG
#----------------------------

resource "aws_security_group" "frontend_sg" {
  
    name    = "${terraform.workspace}_frontend_sg"
    vpc_id  = var.vpc_id 

}

resource "aws_vpc_security_group_ingress_rule""allow_ssh_traffic" {
        
        security_group_id = aws_security_group.frontend_sg.id
        cidr_ipv4         = "0.0.0.0/0"
        from_port         = 22
        to_port           = 22
        ip_protocol       = "TCP"
}


resource "aws_vpc_security_group_ingress_rule""allow_http_traffic" {
        
        security_group_id = aws_security_group.frontend_sg.id
        cidr_ipv4         = "0.0.0.0/0"
        from_port         = 80
        to_port           = 80
        ip_protocol       = "TCP"
}

resource "aws_vpc_security_group_ingress_rule""allow_https_traffic" {
        
        security_group_id = aws_security_group.frontend_sg.id
        cidr_ipv4         = "0.0.0.0/0"
        from_port         = 443
        to_port           = 443
        ip_protocol       = "TCP"
}

resource "aws_vpc_security_group_egress_rule""allow_all_outbound" {

      security_group_id = aws_security_group.frontend_sg.id
        cidr_ipv4         = "0.0.0.0/0"
        ip_protocol       = "-1"
  
}


# # -----------------
# # VPC Endpoint
# # -----------------

# resource "aws_vpc_endpoint""backend_endpoint"{

#     vpc_id            = var.vpc_id
#     vpc_endpoint_type = "Interface"
#     service_name      = "com.amazonaws-us-east-1.rds"

#     tags = {
#       "name" = "${terraform.workspace}" 
#     }
  
# }