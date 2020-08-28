## Module description

Terraform module for creating custom VPC network.

### Variables:
- `network` - name of custom network
- `subnetwork` - name of custom subnetwork
- `cidr` - subnet for custom subnetwork

### Outputs:
- `network` - name of custom network
- `subnetwork` - name of custom subnetwork

### Module usage example:

```terraform

module "vpc" {
  source = "./modules/vpc"

  network = "dev-vpc-1"
  subnetwork = "dev-vpc-1-subnet01"
  cidr = "10.0.20.0/24"

}
```