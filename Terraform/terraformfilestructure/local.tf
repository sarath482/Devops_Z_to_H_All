locals {
  common_tags = {
    environment = var.environment
    log = "banking"
    stage = "alpha"
  }
}