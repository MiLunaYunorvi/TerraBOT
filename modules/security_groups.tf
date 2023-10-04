data "aws_vpc" "default_vpc" {
  default = true
}
data "aws_subnets" "default_subnets" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.default_vpc.id]
  }
}

###########################################
#SECURITY GROUP AND RULES FOR DATABASE
resource "aws_security_group" "DB_SecurityGroup" {
  name = "DB_SecurityGroup"
}
resource "aws_security_group_rule" "allow_mysql_connection"{
  type = "ingress"
  security_group_id = aws_security_group.DB_SecurityGroup.id
  from_port = 3306
  to_port = 3306
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
}
resource "aws_security_group_rule" "allow_db_all_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.DB_SecurityGroup.id
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

###########################################
#SECURITY GROUP AND RULES FOR COMPUTE EC2

resource "aws_security_group" "ec2_SecurityGroup" {
  name = "EC2_Secubot_SecurityGroup"
}


resource "aws_security_group_rule" "allow_http_inbound" {
  type = "ingress"
  security_group_id = aws_security_group.ec2_SecurityGroup.id
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "allow_ssh_inbound" {
  type = "ingress"
  security_group_id = aws_security_group.ec2_SecurityGroup.id
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [ "0.0.0.0/0" ]
}

resource "aws_security_group_rule" "allow_all_utboundEC2" {
  type              = "egress"
  security_group_id = aws_security_group.ec2_SecurityGroup.id
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

# Regla de seguridad para permitir todo el tráfico interno desde la red por defecto
resource "aws_security_group_rule" "allow_internal_inbound" {
  type = "ingress"
  security_group_id = aws_security_group.ec2_SecurityGroup.id
  from_port = 0
  to_port = 65535
  protocol = "-1"
  cidr_blocks = [ data.aws_vpc.default_vpc.cidr_block ]
}
