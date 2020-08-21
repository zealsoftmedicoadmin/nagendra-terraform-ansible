output "network" {
  description = ""
  value = google_compute_network.dev_vpc.name
}

output "subnetwork" {
  description = ""
  value = google_compute_subnetwork.dev_vpc_subnet.name
}
