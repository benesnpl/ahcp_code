## Adding Variables

variable "aws_region" {
	default                         = "us-west-2"
}



variable "coid" {
	default                         = "TAKS"
}

variable "vpc_name_vmx" {
	default                         = "TAKS-VPC-VMX"
}

variable "vpc_name" {
	default                         = "TAKS-VPC"
}


## Variables for VPC and Subnets


variable "vpc_cidr" {
	default                         = "10.0.0.0/23"
}

variable "az" {
	default                         = "us-west-2a"
}

variable "vpc_cidr_vmx" {
	default                         = "192.168.0.0/24"
}

variable "azs" {
	type = list
	default                         = ["us-west-2a","us-west-2b"]
}

variable "public_cidr" {
	type = list
	default                         = ["10.0.0.0/26","10.0.0.64/26"]
}

variable "private_cidr" {
	type = list
	default                         = ["10.0.0.128/26","10.0.0.192/26"]
}

variable "public_cidr_vmx" {
	type = list
	default                         = ["192.168.0.0/26","192.168.0.64/26"]
}

variable "private_cidr_vmx" {
	type = list
	default                         = ["192.168.0.128/26","192.168.0.192/26"]
}


## Variables For SG Main

variable "rules_inbound_public_sg" {
  default = [
    {
      port                          = 0
      proto                         = "-1"
      cidr_block                    = ["0.0.0.0/0"]
    }
    ]
}


variable "rules_outbound_public_sg" {
  default = [
    {
      port                          = 0
      proto                         = "-1"
      cidr_block                    = ["0.0.0.0/0"]
    }
    ]
}


variable "rules_inbound_private_sg" {
  default = [
    {
      port                          = 0
      proto                         = "-1"
      cidr_block                    = ["10.0.0.0/8","192.168.0.0/16","172.16.0.0/12","100.70.0.0/15"]
    }
    ]
}

variable "rules_outbound_private_sg" {
  default = [
    {
      port                          = 0
      proto                         = "-1"
      cidr_block                    = ["0.0.0.0/0"]
    }
    ]
}


## Variables For SG VMX

variable "rules_inbound_vmx_public_sg" {
  default = [
    {
      port                          = 0
      proto                         = "-1"
      cidr_block                    = ["0.0.0.0/0"]
    }
    ]
}


variable "rules_outbound_vmx_public_sg" {
  default = [
    {
      port                          = 0
      proto                         = "-1"
      cidr_block                    = ["0.0.0.0/0"]
    }
    ]
}


variable "rules_inbound_vmx_private_sg" {
  default = [
    {
      port                          = 0
      proto                         = "-1"
      cidr_block                    = ["10.0.0.0/8","192.168.0.0/16","172.16.0.0/12","100.70.0.0/15"]
    }
    ]
}

variable "rules_outbound_vmx_private_sg" {
  default = [
    {
      port                          = 0
      proto                         = "-1"
      cidr_block                    = ["0.0.0.0/0"]
    }
    ]
}


## Other Variables

variable "il_external" {
	default                         = "207.223.34.132"
}

variable "aws_access_key_id" {
	default                         = null
}

variable "aws_secret_access_key" {
	default                         = null
}
