resource "google_compute_network" "dev_vpc" {
  name = var.network
  auto_create_subnetworks = "false"
  routing_mode = "REGIONAL"
}

resource "google_compute_subnetwork" "dev_vpc_subnet" {
  name = var.subnetwork
  network = google_compute_network.dev_vpc.self_link
  ip_cidr_range = var.cidr

}
