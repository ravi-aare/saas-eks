terraform {
  backend "s3" {
    bucket = "terraformstate06102025"
    key    = "eks/dev/terraform.tfstate"
    region = "ap-south-1"
    use_lockfile = true
  }
}
