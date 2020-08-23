variable "network" {
  type = string
  description = "The VPC network to host the cluster in."
}

variable "subnetwork" {
  type = string
  description = "The subnetwork to host the cluster in."
}

variable "cidr" {
  type = string
  description = "The subnetwork CIDR for cluster"
}
