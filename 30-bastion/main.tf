resource "aws_instance" "bastion" {
  ami           = local.ami_id
  instance_type = "t3.micro"

  #we have to create in the public subnet us-east-1a
  subnet_id = local.public_subnet_id

  #sg group id
  vpc_security_group_ids = [local.bastion_sg_id]

  iam_instance_profile = aws_iam_instance_profile.bastion.name
  user_data = filebase64("bastion.sh")
  #we need to increase the memory of bastion host to install the terraform as there are more instances we will create
  root_block_device {
    volume_size = 50
    volume_type = "gp3"
     # Ebs volum tags
    tags =  merge(
    {
        Name = "${var.project}-${var.environment}-bastion"
    },
    local.common_tags
  )
  }
  tags = merge(
    {
        Name = "${var.project}-${var.environment}-bastion"
    },
    local.common_tags
  )
}

resource "aws_iam_role" "bastion" {
  name = "RoboShopDevBastion"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = merge(
    {
        Name = "RoboShopDevBastion"
    },
    local.common_tags
  )
}

resource "aws_iam_role_policy_attachment" "bastion" {
  role       = aws_iam_role.bastion.name
  #policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "bastion" {
  name = "${var.project}-${var.environment}-bastion"
  role = aws_iam_role.bastion.name
}