provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "existing_instance" {
  ami           = "ami-0db56f446d44f2f09"
  instance_type = "c7i-flex.large"

  tags = {
    Name = "tf-managed-instance"
  }
}


resource "aws_s3_bucket" "public_bucket" {
  bucket = "aviz-hcp-test-12062026"
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.public_bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "this" {
  bucket     = aws_s3_bucket.public_bucket.id
  depends_on = [aws_s3_bucket_public_access_block.this]
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = "*"
      Action    = "s3:GetObject"
      Resource  = "${aws_s3_bucket.public_bucket.arn}/*"
    }]
  })
}

