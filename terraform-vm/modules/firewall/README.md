## Module description

Terraform module for creating firewall allow rules.

### Variables:
- `rules` - map which defines firewall rules
- `network` - VPC network for which deploy firewall rules

### Outputs:
- no output variables

### Module usage example:

```terraform

module "firewall" {
  source = "./modules/firewall"
  network = module.vpc.network

  rules = {
    "allow-ssh" = {
        "priority" = "999",
        "proto" = "tcp",
        "ports" = ["22"]
    }
  }
}
```