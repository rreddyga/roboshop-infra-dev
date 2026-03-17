module "vpc" {
    source = "git::https://github.com/rreddyga/terraform-aws-vpc.git?ref=main"
    #source = "../../terraform-aws-vpc"
    #mandatory variables we need to pass

    project = var.project
    environment = var.environment
    is_vpc_peering_required = true
    #is_vpc_peering_required = false

}