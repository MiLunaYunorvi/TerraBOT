resource "aws_instance" "SecuBotEC2" {
  # Regla de seguridad para permitir todo el tráfico interno desde la red por defecto
  ami = "ami-024e6efaf93d85776"
  instance_type = "t2.micro"
  key_name = "KeyPEM"
  tags = {
    Name = "SecuBotEC2"
  }
  security_groups = [ aws_security_group.ec2_SecurityGroup.name]
}

resource "null_resource" "EC2Deployment" {
  triggers = {
    ec2_id = aws_instance.SecuBotEC2.id
  }
  provisioner "local-exec" {
    working_dir = "/home/pi/Desktop/DEVOPS/Terraform/blogBot/modules"
    command = "sudo bash local.sh ${aws_instance.SecuBotEC2.public_ip} ${aws_db_instance.MySQLDB.address} ${aws_db_instance.MySQLDB.username} ${var.DB_password}"
  }
}