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