output "instance-ip" {
  description = "The IP address of the VM"
  value = [
    for key, val in var.instances :
    map("name", key, "ip", google_compute_instance.vm-instance[key].network_interface.0.access_config.0.nat_ip)
  ]
}
