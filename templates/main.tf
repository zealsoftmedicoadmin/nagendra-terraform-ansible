resource "google_compute_instance" "vm-instance" {

  for_each = var.instances

  name = each.key
  machine_type = each.value.machine_type
  zone = each.value.zone

  boot_disk {
    initialize_params {
      image = each.value.image
    }
  }

  network_interface {
    network = each.value.network
    subnetwork = each.value.subnetwork

    access_config {
      // Ephemeral IP
    }
  }

  labels = {
    "assigned_products": each.value.label_assigned_products
  }

  metadata = {
   ssh-keys = "${each.value.ssh_user}:${each.value.ssh_key}"
 }

  
}
