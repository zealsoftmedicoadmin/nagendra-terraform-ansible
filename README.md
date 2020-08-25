# Initial run

1. Create GCP service account, assign to them the following roles: Editor, Security Admin
2. Create Key for service account and download key JSON file
3. Copy key JSON file into `terraform-glb` and `terraform-vm` folders and rename it to `gcloud_terraform.json`
4. Install latest Terraform
5. Install latest Ansible
6. Run `terraform init` in folders `terraform-glb` and `terraform-vm` to initiate terraform plugins
7. To create GCP Storage Bucket and Google Load Balancer with that bucket as backend:
    - customize bucket and balancer options in `terraform-glb/main.tf` file
    - run the following command:
8. To create dev VMs run:
    - customize VMs parameters in `terraform-glb/hosts.yml` file (at least ssh user)
    - run the following command:
