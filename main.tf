# -----------------------------# VPC,Subnet

module "VPC" {
  source = "./modules/VPC"

}

# Route-Table,Route-Table Association, 


module "Route-table" {
    source           = "./modules/Route-Table"
    vpc_id           = module.VPC.vpc_id
    internet-gateway = module.VPC.internet-gateway  
    subnet_id        = module.VPC.subnet_id
    
}



# ------------------------------# Security Group


module "EC2" {
    source = "./modules/EC2"
    vpc_id = module.VPC.vpc_id
    subnet_id = module.VPC.subnet_id
}
