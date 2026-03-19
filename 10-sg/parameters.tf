#single sg_id below code
#resource "aws_ssm_parameter" "mongodb_sg_id" {
#    name = "/${var.project}/${var.environment}/mongodb_sg_id"
#    type = "String"
#    value = module.sg.sg_id
#}

#create multiple sg ids
resource "aws_ssm_parameter" "sg_id" {
    count = length(var.sg_names)
    name = "/${var.project}/${var.environment}/${var.sg_names[count.index]}_sg_id"
    type = "String"
    value = module.sg[count.index].sg_id
}
