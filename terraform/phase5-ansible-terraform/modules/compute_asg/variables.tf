variable "project" { type = string }
variable "ami_id" { type = string }
variable "instance_type" { type = string }
variable "vpc_id" { type = string }
variable "public_subnet_ids" { type = list(string) }
variable "alb_sg_id" { type = string }
variable "target_group_arn" { type = string }
variable "instance_profile_name" { type = string }