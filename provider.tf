terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
   region = "us-west-1"
  access_key = "home/joker/Desktop/Terraform/Day5/accesskey.txt"
  secret_key = "home/joker/Desktop/Terraform/Day5/secretkey.txt"   
}



resource "aws_s3_bucket" "terraform_scripts" {

bucket = "devops-directive -tf-state" # Specifies the name of the S3 bucket.
force_destroy = true   # Indicates whether all objects should be deleted from the bucket so that it can be destroyed when removed from Terraform state.

}


resource"aws_s3_bucket_versioning""versioning_example"{
bucket = aws_s3_bucket.terraform_scripts
versioning_configuration {
enabled= true  
}
}

resource "aws_s3_bucket_public_access_block" "" {
 bucket = "devops-directive -tf-state" 

}
















# -------------------------Advanced Configuration____________________
# resource "aws_s3_bucket_versioning" "terraform_scripts_versoning" {
#   bucket=aws_s3_bucket.terraform_scripts.id 
#   enabled=true 
# }


#  server_side_encryption_configuration {  # Configures server-side encryption for the bucket.
#     rule {
#       apply_server_side_encryption_by_default {  # Specifies the default server-side encryption configuration.
#         sse_algorithm = "AES256"  # Specifies the encryption algorithm to use (AES256 in this case).
#       }
#     }
#   }
# }






