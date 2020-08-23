output "storage_bucket_name" {
  description = "Name of the GCP storage bucket"
  value = module.gcp-bucket.bucket_name
}

