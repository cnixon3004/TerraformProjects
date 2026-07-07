# Create an S3 Bucket 

resource "aws_s3_bucket" "lab_bucket"{
    bucket = var.bucket_name
    tags = {
    Owner = var.owner
    Environment = var.environment
    CreatedBy = "Terraform" 
    }
}
resource "aws_s3_bucket_versioning" "lab_bucket_versioning"{
    bucket = aws_s3_bucket.lab_bucket.id

    versioning_configuration {
        status = "Enabled"
    }
}