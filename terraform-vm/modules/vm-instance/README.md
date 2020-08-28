## Module description

Terraform module for creating GCE instances.

### Variables:
- `instances` - map with instance description. See usage example to address what options currently supported


### Outputs:
- `instance-info` - array of maps. Each map contains GCE instance name, external ip address and labels


### Module usage example:

```terraform

module "vm-instance" {
  source = "./modules/vm-instance"

  instances = {
    "solr-dev" = {
        "machine_type" = "n1-standard-1",
        "image" = "ubuntu-1804-bionic-v20200807",
        "network" = module.vpc.network,
        "subnetwork" = module.vpc.subnetwork,
        "zone" = "us-central1-a",
        "label_assigned_products" = "product",
        "ssh_user" = "user",
        "ssh_key" = var.ssh_key
    }
  }
}

```