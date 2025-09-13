# --------------
# RDS Database
# --------------

resource"aws_db_instance""db_instance"{

    db_name                =  "backend${terraform.workspace}db"
    engine                 = "postgres"
    allocated_storage      =  20
    engine_version         = "17.4"
    instance_class         = "db.t4g.micro"
    username               = var.username
    password               = var.password
    skip_final_snapshot    = true 
    vpc_security_group_ids = [aws_security_group.db_sg.id]
    db_subnet_group_name   = aws_db_subnet_group.db_subnet.name
    publicly_accessible    =  false

    tags = {
      "name"        = "${terraform.workspace}-db"
      "Environment" =  "${terraform.workspace}"
    }

}

# ------------------
# RDS Subnet Group
# ------------------


resource "aws_db_subnet_group" "db_subnet" {

        name       =  "${terraform.workspace}_db_subnet"
        subnet_ids =   var.private_subnet_id
        
        
  
}



# ------------------
# RDS Security group 
# ------------------

resource "aws_security_group" "db_sg" {

    name = "${terraform.workspace}_db_sg"
    vpc_id = var.vpc_id

  
}

resource "aws_vpc_security_group_ingress_rule" "allow_frontend_traffic"{

    security_group_id            =  aws_security_group.db_sg.id
    referenced_security_group_id =  var.frontend_sg_id
    from_port                    = 5432
    to_port                      = 5432
    ip_protocol                  = "TCP"   
 
}

resource "aws_vpc_security_group_egress_rule" "allow_frontend_traffic"{

    security_group_id            =  aws_security_group.db_sg.id
    cidr_ipv4                    = "0.0.0.0/0"
    ip_protocol                  = "-1"  

 
}

