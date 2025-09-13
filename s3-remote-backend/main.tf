#-------------------
# AWS S3 bucket
#------------------


resource"aws_s3_bucket""remote_bucket" {

    bucket = var.remote_bucket_name
    versioning{
	enabled = true
	}
    tags = {
      "Name" = "Remote-bucket" 
    }

}

