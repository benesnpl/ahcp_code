##SG For main VPC


resource "aws_security_group" "public_sg" {
  name                          = "public_sg"
  description                   = "public SG"
  vpc_id                        = aws_vpc.main_vpc.id
  
  dynamic "ingress" {
    for_each                    = var.rules_inbound_public_sg
    content {
      from_port                 = ingress.value["port"]
      to_port                   = ingress.value["port"]
      protocol                  = ingress.value["proto"]
      cidr_blocks               = ingress.value["cidr_block"]
    }
  }
  
  dynamic "egress" {
    for_each                    = var.rules_outbound_public_sg
    content {
      from_port                 = egress.value["port"]
      to_port                   = egress.value["port"]
      protocol                  = egress.value["proto"]
      cidr_blocks               = egress.value["cidr_block"]
    }
  }
  
  tags = {
    Name = join("", [var.coid, "-Public-sg"])
  }
}


resource "aws_security_group" "private_sg" {
  name                          = "private_sg"
  description                   = "Private SG"
  vpc_id                        = aws_vpc.main_vpc.id

  dynamic "ingress" {
    for_each                    = var.rules_inbound_private_sg
    content {
      from_port                 = ingress.value["port"]
      to_port                   = ingress.value["port"]
      protocol                  = ingress.value["proto"]
      cidr_blocks               = ingress.value["cidr_block"]
    }
  }
  dynamic "egress" {
    for_each                    = var.rules_outbound_private_sg
    content {
      from_port                 = egress.value["port"]
      to_port                   = egress.value["port"]
      protocol                  = egress.value["proto"]
      cidr_blocks               = egress.value["cidr_block"]
    }
  }
  tags = {
    Name = join("", [var.coid, "-Private-sg"])
  }
}

## SG_For_Meraki_VPC

resource "aws_security_group" "public_vmx_sg" {
  name                          = "public_VMx_sg"
  description                   = "public_VMx_sg"
  vpc_id                        = var.vpc_cidr_vmx.id
  
  dynamic "ingress" {
    for_each                    = var.rules_inbound_vmx_public_sg
    content {
      from_port                 = ingress.value["port"]
      to_port                   = ingress.value["port"]
      protocol                  = ingress.value["proto"]
      cidr_blocks               = ingress.value["cidr_block"]
    }
  }
  
  dynamic "egress" {
    for_each                    = var.rules_outbound_vmx_public_sg
    content {
      from_port                 = egress.value["port"]
      to_port                   = egress.value["port"]
      protocol                  = egress.value["proto"]
      cidr_blocks               = egress.value["cidr_block"]
    }
  }
  
  tags = {
    Name = join("", [var.coid, "-Public-VMx-sg"])
  }
}


resource "aws_security_group" "private_vmx_sg" {
  name                          = "private_VMx_sg"
  description                   = "private_VMx_sg"
  vpc_id                        = var.meraki_vpc.id

  dynamic "ingress" {
    for_each                    = var.rules_inbound_vmx_private_sg
    content {
      from_port                 = ingress.value["port"]
      to_port                   = ingress.value["port"]
      protocol                  = ingress.value["proto"]
      cidr_blocks               = ingress.value["cidr_block"]
    }
  }
  dynamic "egress" {
    for_each                    = var.rules_outbound_vmx_private_sg
    content {
      from_port                 = egress.value["port"]
      to_port                   = egress.value["port"]
      protocol                  = egress.value["proto"]
      cidr_blocks               = egress.value["cidr_block"]
    }
  }
  tags = {
    Name = join("", [var.coid, "-Private-VMx-sg"])
  }
}
