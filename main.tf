#Vpc Resources
 module "vpc" {
   vpc_id              = var.vpc_id
   vpc_name            = var.vpc_name
   app_name            = var.app_name
   app_environment     = var.app_environment
   source              = "./modules/vpc"
   vpc_cidr            = "10.0.0.0/16"
   subnet_azs          = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
   private_subnet_name = ["private_subnet_1a", "private_subnet_1b", "private_subnet_1c"]
   private_subnet_cidr = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
   public_subnet_name  = ["public_subnet_1a", "public_subnet_1b", "public_subnet_1c"]
   public_subnet_cidr  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

 }

#EC2 Resources
module "ec2" {
  app_name            = var.app_name
  app_environment     = var.app_environment
  source              = "./modules/ec2"
  private_subnet_1_id  = "subnet-0dfe667b866c7f21d"
  ec2-ami             = "ami-0cca134ec43cf708f"
  ec2-instancetype    = "t2.micro"
  ec2-volume-size     = 20
}

#S3 Resources
module "s3" {
  app_name            = var.app_name
  app_environment     = var.app_environment
  source              = "./modules/s3"
 }

#ECS Resources
module "ecs" {
  app_name            = var.app_name
  vpc_id              = var.vpc_id
  app_environment     = var.app_environment
  source              = "./modules/ecs"
  private_subnet_1_id = module.vpc.private_subnet_1_id
  private_subnet_2_id = module.vpc.private_subnet_2_id
}


#ECR Resources
module "ecr" {
  app_name            = var.app_name
  source              = "./modules/ecr"

}
