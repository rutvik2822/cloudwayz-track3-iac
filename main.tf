module "network" {
  source = "./modules/network"

  project_name = "cloudwayz-track3"
  environment  = "dev"

  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"

  availability_zone = "ap-south-1a"
}

module "storage" {
  source = "./modules/storage"

  environment = "dev"

  bucket_name         = "cloudwayz-track3-rutvik-devdare"
  dynamodb_table_name = "cloudwayz-track3-table"

  hash_key = "id"

  s3_lifecycle_days = 30
}

module "iam" {
  source = "./modules/iam"

  project_name = "cloudwayz-track3"
  environment  = "dev"

  s3_bucket_arn      = module.storage.bucket_arn
  dynamodb_table_arn = module.storage.dynamodb_table_arn
}

module "ec2" {
  source = "./modules/ec2"

  project_name = "cloudwayz-track3"
  environment  = "dev"

  vpc_id           = module.network.vpc_id
  public_subnet_id = module.network.public_subnet_id

  instance_profile_name = module.iam.instance_profile_name

  key_pair_name = "cloudwayz-key"

  ssh_cidr  = "0.0.0.0/0"
  http_cidr = "0.0.0.0/0"
}