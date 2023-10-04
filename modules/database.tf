resource "aws_db_instance" "MySQLDB" {
  allocated_storage    = 20
  db_name              = "maindb_sql"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "milunauser"
  password             = var.DB_password
  publicly_accessible  = true
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.DB_SecurityGroup.id]
}

resource "null_resource" "DB_Script" {
  triggers = {
    db_id = aws_db_instance.MySQLDB.id
  }
  provisioner "local-exec" {
    working_dir = "/home/pi/Desktop/DEVOPS/Terraform/blogBot/modules"
    command = "python3 conection.py ${aws_db_instance.MySQLDB.address} ${aws_db_instance.MySQLDB.username} ${var.DB_password} "
  }
}
