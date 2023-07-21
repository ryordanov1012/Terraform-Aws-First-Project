e# Define variables and use them as needed in your code
variable "ec2_instance_type" {
  type = string
  default = "t2.micro"
}
variable "ec2_instance_name" {
  type = string
  default = "Terraform"
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "172.31.0.0/16"
}

variable "private-subnet-cidr" {
  default = "172.31.1.0/24"
  description = "Public Subnet CIDR Block"
  type = string 
}


variable "ssh-location" {
  default = "76.193.47.58/32"
  description = "Allow only from my IP"
  type = string 
}


variable "endpoint-email" {
  default = "EMAIL@gmail.com"
  description = "sns topic subscription variable"
  type = string
}
