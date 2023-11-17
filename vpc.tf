## Create VPCs

resource "aws_vpc" "main_vpc" {
  cidr_block       					         = var.vpc_cidr
  tags = {
    Name                                     = var.vpc_name
  }
}

resource "aws_vpc" "meraki_vpc" {
  cidr_block       					         = var.vpc_cidr_vmx
  tags = {
    Name                                     = var.vpc_name_vmx
  }
}

## Create Public Subnet

resource "aws_subnet" "public_subnet" {
    count                                   = length(var.public_cidr)
    cidr_block                              = element(var.public_cidr,count.index)
    vpc_id                                  = aws_vpc.main_vpc.id
    availability_zone                       = element(var.azs,count.index)
    map_public_ip_on_launch                 = false
    tags = {
        Name = ("Public-Subnet-AZ${count.index+1}")
        }
       }
       
resource "aws_subnet" "public_subnet_vmx" {
    cidr_block                              = var.public_cidr_vmx
    vpc_id                                  = aws_vpc.meraki_vpc.id
    availability_zone                       = var.az
    map_public_ip_on_launch                 = false
    tags = {
        Name = ("Public-Subnet-VMx")
        }
       }

## Create Private Subnet


resource "aws_subnet" "private_subnet" {
    count                                   = length(var.private_cidr)
    cidr_block                              = element(var.private_cidr,count.index)
    vpc_id                                  = aws_vpc.main_vpc.id
    availability_zone                       = element(var.azs,count.index)
    map_public_ip_on_launch                 = false
    tags = {
        Name = ("Private-Subnet-AZ${count.index+1}")
        }
       }
       

resource "aws_subnet" "private_subnet_vmx" {
    cidr_block                              = var.private_cidr_vmx
    vpc_id                                  = aws_vpc.meraki_vpc.id
    availability_zone                       = var.az
    map_public_ip_on_launch                 = false
    tags = {
        Name = ("Private-Subnet-VMx")
        }
       }
