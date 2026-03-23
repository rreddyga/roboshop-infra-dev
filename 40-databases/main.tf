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
    timestamp()
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
      "sudo sh /tmp/bootstrap.sh mongodb"
    ]
  }
}

#redis
resource "aws_instance" "redis" {
  ami           = local.ami_id
  instance_type = "t3.micro"

  #we have to create in the database subnet us-east-1a
  subnet_id = local.database_subnet_id

  #sg group id
  vpc_security_group_ids = [local.redis_sg_id]

  tags = merge(
    {
        Name = "${var.project}-${var.environment}-redis"
    },
    local.common_tags
  )
}

#we are using terraform data for redis

resource "terraform_data" "bootstrap-redis" {
  triggers_replace = [
    aws_instance.redis.id,
    timestamp()
    #aws_instance.database.id
  ]
  #we need to take the connections by using connections block

  connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = aws_instance.redis.private_ip
  }

#copy the bootstrap script file to redis
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
      "sudo sh /tmp/bootstrap.sh redis"
    ]
  }
}

#mysql
resource "aws_instance" "mysql" {
  ami           = local.ami_id
  instance_type = "t3.micro"

  #we have to create in the database subnet us-east-1a
  subnet_id = local.database_subnet_id

  #sg group id
  vpc_security_group_ids = [local.mysql_sg_id]

  tags = merge(
    {
        Name = "${var.project}-${var.environment}-mysql"
    },
    local.common_tags
  )
}

#we are using terraform data for mysql

resource "terraform_data" "bootstrap-mysql" {
  triggers_replace = [
    aws_instance.mysql.id,
    timestamp()
    #aws_instance.database.id
  ]
  #we need to take the connections by using connections block

  connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = aws_instance.mysql.private_ip
  }

#copy the bootstrap script file to mysql
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
      "sudo sh /tmp/bootstrap.sh mysql"
    ]
  }
}
#rabbitmq
resource "aws_instance" "rabbitmq" {
  ami           = local.ami_id
  instance_type = "t3.micro"

  #we have to create in the database subnet us-east-1a
  subnet_id = local.database_subnet_id

  #sg group id
  vpc_security_group_ids = [local.rabbitmq_sg_id]

  tags = merge(
    {
        Name = "${var.project}-${var.environment}-rabbitmq"
    },
    local.common_tags
  )
}

#we are using terraform data for rabbitmq

resource "terraform_data" "bootstrap-rabbitmq" {
  triggers_replace = [
    aws_instance.rabbitmq.id,
    timestamp()
    #aws_instance.database.id
  ]
  #we need to take the connections by using connections block

  connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = aws_instance.rabbitmq.private_ip
  }

#copy the bootstrap script file to rabbitmq
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
      "sudo sh /tmp/bootstrap.sh rabbitmq"
    ]
  }
}