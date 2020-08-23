variable "extip_name" {
    description = "Name of reserved external ip address (frontend)"
    type = string
}

variable "backend_bucket_name" {
    description = "Google load balancer backend storage bucket name"
    type = string
}

variable "bucket_name" {
    description = "GCP storage bucket name"
    type = string
}

variable "urlmap_name" {
    description = "URL map name"
    type = string
}

variable "http_proxy_name" {
    description = "Name of http proxy to create"
    type = string
}

variable "forward_rule_name" {
    description = "Name of global forwarding rule (binds together external ip address and http proxy)"
    type = string
}