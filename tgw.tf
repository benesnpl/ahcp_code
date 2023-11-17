## Create TGW

resource "aws_ec2_transit_gateway" "main_tgw" {
  description                               = "TGW"
  auto_accept_shared_attachments            = "enable"
  tags = {
   Name                                     = join("", [var.coid, "-DR-TGW"])
  }
}

## Create VPC attachment for main_vpc

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-main" {
  depends_on                                = [aws_ec2_transit_gateway.main_tgw]
  subnet_ids                                = "${aws_subnet.private_subnet.*.id}"
  transit_gateway_id                        = aws_ec2_transit_gateway.main_tgw.id
  vpc_id                                    = aws_vpc.main_vpc.id
  tags = {
   Name                                     = join("", [var.coid, "-DR-VPC"])
  }
}

## Create VPC attachment for vMX VPC

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-main-shr" {
  depends_on                                = [aws_ec2_transit_gateway.main_tgw]
  subnet_ids                                = "${aws_subnet.private_subnet_vmx.*.id}"
  transit_gateway_id                        = aws_ec2_transit_gateway.main_tgw.id
  vpc_id                                    = aws_vpc.meraki_vpc.id
  tags = {
   Name                                     = join("", [var.coid, "-VMx-VPC"])
  }
}

