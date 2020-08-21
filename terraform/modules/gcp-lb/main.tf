resource "google_compute_global_address" "extip" {
  name = var.extip_name
  ip_version = "IPV4"
}

resource "google_compute_backend_bucket" "backend_bucket" {
  name = var.backend_bucket_name
  bucket_name = var.bucket_name
  enable_cdn  = true
}

resource "google_compute_url_map" "default" {
  name = var.urlmap_name
  default_service = google_compute_backend_bucket.backend_bucket.self_link
}

resource "google_compute_target_http_proxy" "default" {
  name = var.http_proxy_name # "http-lb-proxy"
  url_map = google_compute_url_map.default.self_link
}

resource "google_compute_global_forwarding_rule" "http" {
  name       = var.forward_rule_name
  target     = google_compute_target_http_proxy.default.self_link
  ip_address = google_compute_global_address.extip.address
  port_range = "80"
}
