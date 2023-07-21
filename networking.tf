
# Create VPC
# terraform aws create vpc
resource "aws_vpc" "vpc_cidr_block" {
  cidr_block              = var.vpc_cidr_block
  instance_tenancy        = "default"
  enable_dns_hostnames    = true
  enable_dns_support      = true
  tags      = {
    Name    = "Terraform VPC"
  }
}

# Create Internet Gateway and Attach it to VPC
# terraform aws create internet gateway
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id    = aws_vpc.vpc_cidr_block.id
  tags      = {
    Name    = "Terraform GateWay"
  }
}

# Create Private Subnet 
# terraform aws create subnet
resource "aws_subnet" "private-subnet-cidr" {
  vpc_id                  = aws_vpc.vpc_cidr_block.id
  cidr_block              = var.private-subnet-cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags      = {
    Name    = "Terraform Public Subnet"
  }
}
# Create Route Table and Add Public Route
# terraform aws create route table
resource "aws_route_table" "public-route-table" {
  vpc_id       = aws_vpc.vpc_cidr_block.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }
  tags       = {
    Name     = "Terraform Public Route Table"
  }
}
# Associate Public Subnet to "Public Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "public-subnet-route-table-association" {
  subnet_id           = aws_subnet.private-subnet-cidr.id
  route_table_id      = aws_route_table.public-route-table.id
}

# Create Network Interface
# Terraform aws Network Interface
resource "aws_network_interface" "private-interface" {
  subnet_id       = aws_subnet.private-subnet-cidr.id
  private_ips     = ["172.31.1.25"]
  security_groups = [aws_security_group.allow_ssh.id]

}
# Create Elastic IP and assosiate it the Network Interface
# EIP dedpends on the Internet Gateway so make sure you have one and use depends_om
# Terraform aws eip
resource "aws_eip" "Terraform-eip" {
  instance                  = aws_instance.terraform.id
  depends_on                = [ aws_internet_gateway.internet-gateway ]
  network_interface         = aws_network_interface.private-interface.id
 
  
}
# After compiling, output the public ip of EC2 instance 
output "Server_Public_ip" {
  value = aws_eip.Terraform-eip.public_ip
}
#output the private ip of EC2 instance 
output "Server_Private_ip" {
  value = aws_eip.Terraform-eip.private_ip
}
#output the private DNS of EC2 instance 
output "Server_Public_DNS" {
  value = aws_eip.Terraform-eip.public_dns
}
