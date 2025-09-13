#-------------------
# Remote Backend
#------------------

terraform {

  backend "s3"{

    bucket = "my-remote-bucket-701"
    key    = "env/terraform.tfstate"
    region = "ap-south-1"

  }
}