## Module description

Terraform module for creating external HTTP Google Load Balancer with GCP storage bucket as backend.

### Variables:
- `extip_name` - name of reserved external ip address (frontend)
- `backend_bucket_name` - Google load balancer backend storage bucket name
- `bucket_name` - GCP storage bucket name
- `urlmap_name` - URL map name
- `http_proxy_name` - name of http proxy to create
- `forward_rule_name` - name of global forwarding rule (binds together external ip address and http proxy)

### Outputs:
- no output variables

### Module usage example:

```terraform

module "gcp-lb" {
  
  source = "./modules/gcp-lb"

  extip_name = "http-lb-address"
  backend_bucket_name = "backend-bucket-1"
  bucket_name = module.gcp-bucket.bucket_name

  urlmap_name = "url-map-1"
  http_proxy_name = "http-lb-proxy"
  forward_rule_name = "http-lb-forward-rule-1"

}

```