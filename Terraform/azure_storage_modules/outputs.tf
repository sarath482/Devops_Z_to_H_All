output "dev_blob_endpoint" {
    value = module.dev_storage.primary_blob_endpoint
  
}

output "qa_blob_endpoint" {
    value = module.qa_storage.primary_blob_endpoint
  
}
output "prod_blob_endpoint" {
    value = module.prod_storage.primary_blob_endpoint
  
}