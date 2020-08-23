resource "google_compute_firewall" "gke-firewall" {

  network = var.network
  for_each = var.rules

  name = each.key
  
  allow {
    protocol = each.value.proto
    ports = each.value.ports
  }

  priority = each.value.priority
}
