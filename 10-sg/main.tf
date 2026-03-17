module "sg" {
    source = "../../terraform-aws-sg"
    project = "${var.project}"
    environment = "${var.environment}"
    sg_name = "mongodb"
    #to read from ssm parameter 
    vpc_id = local.vpc_id
}