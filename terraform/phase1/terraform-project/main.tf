provider "aws" {
  region = "ap-northeast-1"
}



resource "aws_instance" "test" {
  ami           = "ami-070d2b24928913a49"
  instance_type = var.instance_type

  subnet_id = "subnet-03cc5b92799278c5e"
}
