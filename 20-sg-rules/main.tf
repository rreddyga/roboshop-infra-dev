resource "aws_security_group_rule" "bastion_internet" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  #cidr_blocks       = ["0.0.0.0/0"]
  #how to get the ipv4 address from terraform few cases the my ip address changes
  cidr_blocks = [local.my_ip]
  # which sg you are creating this rule -> bastion_sg group name we have to get from ssm-parameter
  security_group_id = local.bastion_sg_id
}
resource "aws_security_group_rule" "mongodb_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  #cidr_blocks       = [aws_vpc.example.cidr_block]
  source_security_group_id =local.bastion_sg_id
  security_group_id = local.mongodb_sg_id
}

#mongodb-catalouge
resource "aws_security_group_rule" "mongodb_catalouge" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  #cidr_blocks       = [aws_vpc.example.cidr_block]
  source_security_group_id =local.catalogue_sg_id
  security_group_id = local.mongodb_sg_id
}

#mongodb-user
resource "aws_security_group_rule" "mongodb_user" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  #cidr_blocks       = [aws_vpc.example.cidr_block]
  source_security_group_id =local.user_sg_id
  security_group_id = local.mongodb_sg_id
}

#redis-bastion

resource "aws_security_group_rule" "redis_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  #cidr_blocks       = [aws_vpc.example.cidr_block]
  source_security_group_id =local.bastion_sg_id
  security_group_id = local.redis_sg_id
}

#mysql-bastion

resource "aws_security_group_rule" "mysql_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  #cidr_blocks       = [aws_vpc.example.cidr_block]
  source_security_group_id =local.bastion_sg_id
  security_group_id = local.mysql_sg_id
}