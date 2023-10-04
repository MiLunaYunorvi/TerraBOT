output "db_connector" {
  value = split(":", aws_db_instance.MySQLDB.endpoint)[0]
}
output "db_username" {
  value = aws_db_instance.MySQLDB.username
}

output "public_ip_EC2" {
  value = aws_instance.SecuBotEC2.public_ip
}