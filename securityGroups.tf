resource "aws_security_group" "worker-nodes-mngt" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "worker-ingress-1" {
    description = "This is the Ingress rule for Worker nodes. Allowing the traffic only from EKS"
    security_group_id = aws_security_group.worker-nodes-mngt.id
    cidr_ipv4   = "10.0.0.0/8"
    ip_protocol = -1
}

resource "aws_vpc_security_group_ingress_rule" "worker-ingress-2" {
    description = "This is the Ingress rule for Worker nodes. Allowing the traffic only from EKS"
    security_group_id = aws_security_group.worker-nodes-mngt.id
    cidr_ipv4   = "172.16.0.0/12"
    ip_protocol = -1
}

resource "aws_vpc_security_group_ingress_rule" "worker-ingress-3" {
    description = "This is the Ingress rule for Worker nodes. Allowing the traffic only from EKS"
    security_group_id = aws_security_group.worker-nodes-mngt.id
    cidr_ipv4   = "192.168.0.0/16"
    ip_protocol = -1
}


resource "aws_vpc_security_group_egress_rule" "worker-egress" {
    description = "Allowing the traffic to go anywhere"
    security_group_id = aws_security_group.worker-nodes-mngt.id
    cidr_ipv4   = "0.0.0.0/0"
    ip_protocol = -1
}
