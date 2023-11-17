## Create Public IPs for NAT Gateways

resource "aws_eip" "pub1" {
  vpc                           = true
  tags = {
    Name                        = join("", [var.coid, "-eip-nat"])
  }
}  


resource "aws_eip" "pub2" {
  vpc                           = true
  tags = {
    Name                        = join("", [var.coid, "-eip-nat-vmx"])
  }
  }
