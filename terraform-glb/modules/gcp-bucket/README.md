## Module description

Terraform module for creating one GCP storage bucket with public read access.

Variables:
- `bucket_name` - GCP storage bucket name
- `bucket_location` - GCP storage bucket location

Outputs:
- `bucket_name` - GCP storage bucket name

Module usage example:

```terraform
module "gcp-bucket" {
  source = "./modules/gcp-bucket"

  bucket_name = "test-web-bucket"
  bucket_location = "US"
}
```