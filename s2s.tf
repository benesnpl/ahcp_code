## Oakbrook Customer Gateway

resource "aws_customer_gateway" "oakbrook" {
  bgp_asn                               = 65000
  ip_address                            = var.il_external
  type                                  = "ipsec.1"

  tags = {
    Name                                = join("", [var.coid, "-Oakbrook-CGW"])
  }
}

## VPN Connection Oakbrook

resource "aws_vpn_connection" "Oakbrook" {
  transit_gateway_id                    = aws_ec2_transit_gateway.main_tgw.id
  customer_gateway_id                   = aws_customer_gateway.oakbrook.id
  type                                  = "ipsec.1"
  static_routes_only                    = true
  tags = {
    Name                                = join("", [var.coid, "-Oakbrook-ipsec"])
  }
  
}

## Get the Oakbrook ipsec VPN attachment ID

data "aws_ec2_transit_gateway_vpn_attachment" "oak_attach" {
  transit_gateway_id                    = aws_ec2_transit_gateway.main_tgw.id
  vpn_connection_id                     = aws_vpn_connection.Oakbrook.id
}


resource "aws_ec2_transit_gateway_route" "oak_vpn_1" {
  destination_cidr_block                = "10.159.94.0/23"
  transit_gateway_attachment_id         = data.aws_ec2_transit_gateway_vpn_attachment.oak_attach.id
  transit_gateway_route_table_id        = aws_ec2_transit_gateway.main_tgw.association_default_route_table_id
  blackhole                             = false
}

resource "aws_ec2_transit_gateway_route" "oak_vpn_2" {
  destination_cidr_block                = "100.70.0.0/15"
  transit_gateway_attachment_id         = data.aws_ec2_transit_gateway_vpn_attachment.oak_attach.id
  transit_gateway_route_table_id        = aws_ec2_transit_gateway.main_tgw.association_default_route_table_id
  blackhole                             = false
}
