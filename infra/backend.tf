# Create a remote backend using S3 with native state locking
terraform {
  backend "s3" {
    bucket       = "threat-composer-tfbucket"
    key          = "threat-composer-tfbucket/terraform.tfstate"
    use_lockfile = true
    region       = "ap-southeast-2"
  }
}