resource "aws_instance" "mongodb" {
  ami           = local.ami_id
  instance_type = "t3.micro"

  #we have to create in the database subnet us-east-1a
  subnet_id = local.database_subnet_id

  #sg group id
  vpc_security_group_ids = [local.mongodb_sg_id]

  tags = merge(
    {
        Name = "${var.project}-${var.environment}-mongodb"
    },
    local.common_tags
  )
}

#we are using terraform data

resource "terraform_data" "bootstrap" {
  triggers_replace = [
    aws_instance.mongodb.id,
    #aws_instance.database.id
  ]
  #we need to take the connections by using connections block

  connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = aws_instance.mongodb.private_ip
  }

#copy the bootstrap script file to mongodb
  provisioner "file" {
  source = "bootstrap.sh"
  destination = "/tmp/bootstrap.sh"
  }
  #then execute the script file
  provisioner "remote-exec" {
    #inline block we used for run the multiple commands
    inline = [
      #giving the execute permissions to bootstrap.sh file
      "chmod +x /tmp/bootstrap.sh",
      #run the script file
      "sudo sh /tmp/bootstrap.sh"
    ]
  }
}