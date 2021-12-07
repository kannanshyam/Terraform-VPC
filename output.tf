output "webserver-public-ip" {
  value = aws_instance.webserver.public_ip
}

output "webserver-private-ip" { 
  value = aws_instance.webserver.private_ip
}

output "bastion-public-ip" {    
  value = aws_instance.bastion.public_ip   
}

output "database-public-ip" {
  value = aws_instance.database.private_ip
}
