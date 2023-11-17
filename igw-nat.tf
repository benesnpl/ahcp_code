## Create IGW on both VPCs


resource "aws_internet_gateway" "main_igw" {
  depends_on                            = [aws_ec2_transit_gateway.main_tgw,aws_internet_gateway.main_igw]
  vpc_id                                = aws_vpc.main_vpc.id
  tags = {
    Name                                = join("", [var.coid, "-IGW"])
  }
}

resource "aws_internet_gateway" "main_igw_vmx" {
  depends_on                            = [aws_ec2_transit_gateway.main_tgw,aws_internet_gateway.main_igw]
  vpc_id                                = aws_vpc.meraki_vpc.id
  tags = {
    Name                                = join("", [var.coid, "-VMx-IGW"])
  }
}

## Create NAT Gateways on Both VPCs

resource "aws_nat_gateway" "fw-nat" {
  allocation_id                         = aws_eip.pub1.id
  subnet_id                             = aws_subnet.public_subnet[0].id

  tags = {
    Name                                = "\NAT-GW"
  }
  depends_on                            = [aws_internet_gateway.main_igw]
}

resource "aws_nat_gateway" "shr-nat" {
  allocation_id                         = aws_eip.pub2.id
  subnet_id                             = aws_subnet.public_subnet_vmx[0].id

  tags = {
    Name                                = "NAT-GW-VMx"
  }
  depends_on                            = [aws_internet_gateway.main_igw]
}
