variable "vpc_id" {
  
}
variable "public_subnet"{
  
  type = list(string) 

}


variable "instance_count" {

  type = number

}
variable"ami"{
    
  type = string
  
}

variable "user_data" {

   type    = string
   default = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl enable httpd
              systemctl start httpd
              echo "Hello from $(hostname)" > /var/www/html/index.html
              EOF

}

variable "instance_type" {
  
  type    =  string  
}
