provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "existing_instance" {
  ami           = "ami-0db56f446d44f2f09"
  instance_type = "c7i.flex-large"

  tags = {
    Name = "tf-managed-instance"
  }
}
