variable "region" {
  type    = string
  default = "ap-northeast-1"
}

variable "vpc_cidr" {
  type    = string
  default = "10.20.0.0/16"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "ami_id" {
  type    = string
  default = "ami-070d2b24928913a49"
}

# SSHは自分のIP/32（Phase3と同様、ローカルでtfvarsに入れる）
variable "my_ip" {
  type        = string
  description = "Your public IP with /32 (e.g., 203.0.113.10/32)"
}

# RDS設定
variable "db_name" {
  type    = string
  default = "appdb"
}

variable "db_username" {
  type    = string
  default = "admin"
}

variable "db_password" {
  type        = string
  sensitive   = true
  description = "DB password (set via terraform.tfvars, never commit)"
}

variable "db_instance_class" {
  type    = string
  default = "db.t3.micro"
}


