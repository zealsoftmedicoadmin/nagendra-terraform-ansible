/***********
  Providers
***********/

provider "google" {
  /* Used with credentials JSON file of service account key
    If not use it don't forget run "gcloud auth application-default login" 
    command to get default credentials 
  */
  credentials = file(var.global_credentials_file)
  project = var.global_project
  region = var.global_region
}

resource "random_integer" "gcp_bucket_suffix" {
  min = 1
  max = 1000
}


/***********
  Modules
***********/

module "gcp-bucket" {
  
  source = "./modules/gcp-bucket"

  bucket_name = "medico-${random_integer.gcp_bucket_suffix.result}"
  bucket_location = "US"

}


module "gcp-lb" {
  
  source = "./modules/gcp-lb"

  extip_name = "http-lb-address"
  backend_bucket_name = "backend-bucket-1"
  bucket_name = module.gcp-bucket.bucket_name

  urlmap_name = "url-map-1"
  http_proxy_name = "http-lb-proxy"
  forward_rule_name = "http-lb-forward-rule-1"

}
