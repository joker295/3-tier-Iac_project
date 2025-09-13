variable "username" {

    type      = string
    sensitive = true
  
}

variable "password" {
    
    type      =  string
    sensitive = true

}


variable "vpc_id"{
  

}


variable"private_subnet_id" {

    type = list(string)
  
}


variable "frontend_sg_id" {
    
  
}