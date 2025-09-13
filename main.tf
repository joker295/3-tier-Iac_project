#-----------------------------
# Modules
#-----------------------------

module "VPC" {
  
  source         = "./modules/VPC"
  vpc_name       = "main-vpc"
  azs            = ["ap-south-1a","ap-south-1b"]
  public_cidr    = ["10.0.1.0/24","10.0.3.0/24"]
  private_cidr   = ["10.0.2.0/24","10.0.4.0/24"] 

}

module "frontend" {
  
  source         = "./modules/frontend"
  instance_count = 2
  instance_type  = "t3.micro"
  vpc_id         = module.VPC.vpc_id
  public_subnet  = module.VPC.public_subnet_id
  ami            = "ami-0b982602dbb32c5bd"
  
}


module "database" {

  source            = "./modules/database"
  vpc_id            = module.VPC.vpc_id
  frontend_sg_id    = module.frontend.frontend_sg_id
  private_subnet_id = module.VPC.private_subnet_id  
  username          = var.username
  password          = var.password

  
}