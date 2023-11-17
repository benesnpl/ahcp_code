## Public Routing for main VPC

resource "aws_route_table" "public_rt" {
  depends_on                    = [aws_internet_gateway.main_igw,aws_ec2_transit_gateway.main_tgw,aws_vpn_connection.Oakbrook]
  vpc_id                        = aws_vpc.main_vpc.id
  
  route {
    cidr_block                  = "0.0.0.0/0"
    gateway_id                  = aws_internet_gateway.main_igw.id
  }
  
  tags = {
    Name = ("Public-rt")
  }
}

## Public Routing for Meraki VPC

resource "aws_route_table" "public_vmx_rt" {
  depends_on                    = [aws_internet_gateway.meraki_igw,aws_ec2_transit_gateway.main_tgw,aws_vpn_connection.Oakbrook]
  vpc_id                        = aws_vpc.meraki_vpc.id
  
  route {
    cidr_block                  = "0.0.0.0/0"
    gateway_id                  = aws_internet_gateway.meraki_igw.id
  }
  
  tags = {
    Name = ("Public-vmx-rt")
  }
}


## Private Routing for Main VPC

resource "aws_route_table" "private_rt" {
  depends_on                    = [aws_internet_gateway.main_igw,aws_ec2_transit_gateway.main_tgw,aws_vpn_connection.Oakbrook]
  vpc_id                        = aws_vpc.main_vpc.id
  
  route {
    cidr_block                  = "10.0.0.0/8"
    gateway_id                  = aws_ec2_transit_gateway.main_tgw.id
  }
  
  route {
    cidr_block                  = "0.0.0.0/0"
    gateway_id                  = aws_nat_gateway.main-nat.id
  }
  
  route {
    cidr_block                  = "192.168.0.0/16"
    gateway_id                  = aws_ec2_transit_gateway.main_tgw.id
  }
  
   route {
    cidr_block                  = "100.70.0.0/15"
    gateway_id                  = aws_ec2_transit_gateway.main_tgw.id
  }

  route {
    cidr_block                  = "172.16.0.0/12"
    gateway_id                  = aws_ec2_transit_gateway.main_tgw.id
  }
  
  tags = {
    Name = ("Private-rt")
  }
}

## Private Routing for vMX VPC

resource "aws_route_table" "private_vmx_rt" {
  depends_on                    = [aws_internet_gateway.main_igw,aws_ec2_transit_gateway.main_tgw,aws_vpn_connection.Oakbrook]
  vpc_id                        = aws_vpc.meraki_vpc.id
  
  route {
    cidr_block                  = "10.0.0.0/8"
    gateway_id                  = aws_ec2_transit_gateway.main_tgw.id
  }
  
  route {
    cidr_block                  = "0.0.0.0/0"
    gateway_id                  = aws_nat_gateway.vmx-nat.id
  }
  
  route {
    cidr_block                  = "192.168.0.0/16"
    gateway_id                  = aws_ec2_transit_gateway.main_tgw.id
  }
  
   route {
    cidr_block                  = "100.70.0.0/15"
    gateway_id                  = aws_ec2_transit_gateway.main_tgw.id
  }

  route {
    cidr_block                  = "172.16.0.0/12"
    gateway_id                  = aws_ec2_transit_gateway.main_tgw.id
  }
  
  tags = {
    Name = ("Private-VMx-rt")
  }
}

### Route Table Associations


resource "aws_route_table_association" "prvt" {
  depends_on                    = [aws_route_table.private_rt]
  count                         = length(var.private_cidr)
  subnet_id                     = element(aws_subnet.private_subnet.*.id,count.index)
  route_table_id                = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "prvt-vmx" {
  depends_on                    = [aws_route_table.private_vmx_rt,aws_ec2_transit_gateway_vpc_attachment.tgw-main-shr]
  subnet_id                     = aws_subnet.private_subnet_vmx.id
  route_table_id                = aws_route_table.private_vmx_rt.id
}

resource "aws_route_table_association" "public" {
  depends_on                    = [aws_route_table.public_rt]
  count                         = length(var.public_cidr)
  subnet_id                     = element(aws_subnet.public_subnet.*.id,count.index)
  route_table_id                = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public-vmx" {
  depends_on                    = [aws_route_table.public_vmx_rt]
  subnet_id                     = aws_subnet.public_subnet_vmx.id
  route_table_id                = aws_route_table.public_vmx_rt.id
}
