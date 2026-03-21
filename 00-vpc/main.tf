# to run the all the resource we have to use this command 
# for i in 00-vpc/ 10-sg/ 20-sg-rules / 30-bastion/; do cd $i ; terraform apply -auto-approve; cd ..;done
module "vpc" {
    source = "git::https://github.com/rreddyga/terraform-aws-vpc.git?ref=main"
    #source = "../../terraform-aws-vpc"
    #mandatory variables we need to pass

    project = var.project
    environment = var.environment
    is_vpc_peering_required = true
    #is_vpc_peering_required = false

}