output "instance-info" {
  description = "The IP address of the VM"
  value = [
    for key, val in google_compute_instance.vm-instance :
    {
        "name": key, 
        "ip": val.network_interface.0.access_config.0.nat_ip,
        "labels": val.labels
    }
  ]
}
