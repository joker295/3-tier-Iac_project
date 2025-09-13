variable "region" {

    type    = string
    default = "ap-south-1"
  
}


variable "username" {
    
    description = "Username for RDS database"
    default     = "master"
    type        = string

}


variable "password" {
    
    description = "Password for RDS database"
    default     = "Kingdown1234"
    sensitive   = true
    type        = string

}