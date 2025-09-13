variable "cidr_block" {

    type = string
    default = "10.0.0.0/16"
  
}

variable "vpc_name" {
    
    type   = string 
}

variable "public_cidr" {

    type = list(string)
  
}

variable "private_cidr" {

    type = list(string)
  
}

variable "azs" {

    type= list(string)

}