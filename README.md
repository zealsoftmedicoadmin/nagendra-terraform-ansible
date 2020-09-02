# Initial setup

1. Create new GCP project and enable Compute Engine API in it.
1. Create GCP service account, assign to them the following roles: Editor, Security Admin
2. Create Key for service account and download key JSON file
3. Copy key JSON file into `terraform-glb` and `terraform-vm` folders and rename it to `gcloud_terraform.json`
4. Specify project ID, region and JSON file in `terraform.tfvars` files in folders `terraform-glb` and `terraform-vm`
5. Install latest Terraform
6. Install latest Ansible
7. Run `terraform init` in folders `terraform-glb` and `terraform-vm` to initialize Terraform plugins
8. To create GCP Storage Bucket and Google Load Balancer with that bucket as backend:
    - customize bucket and balancer options in `terraform-glb/main.tf` file
    - run the following command:
        `ansible-playbook -i hosts.yml -v main.yml --tags "terraform-glb"`
9. To create dev VMs run:
    - customize VMs parameters in `terraform-glb/hosts.yml` file (at least ssh user)
    - run the following command:
        `ansible-playbook -i hosts.yml -v main.yml --skip-tags "terraform-glb"`


# Folder structure

* [docker-compose/](docker-compose) - Docker Compose files for local deployment Zookeeper+Solr and Zookeeper+Kafka services
* [files/](files) - contains single file `sources.list`. Used by Ansible to install original Ubuntu repositories before install Java packages
* [roles/](roles) - number of Ansible roles for deployment
* [tasks/](tasks) - number of Ansible tasks included in the `main.yml` playbook
    * `gcp-bucket-lb.yml` - Ansible tasks for creating GCP Storage Bucket with public access and setup GCP Load Balancer with that bucket as backend. Uses Terraform files in `terraform-glb` folder
    * `gcp-ce-vm.yml` - Ansible tasks for creating: custom VPC network, firewall rules, number of GCE instances. Uses Terraform files in `terraform-vm` folder
* [templates/](templates) - contains single file `main.tf.j2`. Used by tasks in `gcp-ce-vm.yml` to create Terraform `terraform-vm/main.tf` file and populate it with hosts parameters from `hosts.yml`
* [terraform-glb/](terraform-glb) - Terraform manifest files for creating GCP Storage Bucket with public access and setup GCP Load Balancer with that bucket as backend. Outputs GCP storage bucket name as variable `storage_bucket_name`. You need to specify GCP project ID, region and JSON credentials file in `terraform.tfvars` file. For different customizations, see `README.md` files in the module root folder.
* [terraform-vm/](terraform-vm) - Terraform manifest files for creating: custom VPC network, firewall rules, number of GCE instances. Outputs some VM parameters as array variable `vminfo`. You need to specify GCP project ID, region and JSON credentials file in `terraform.tfvars` file. For different customizations, see `README.md` files in the module root folder.
* [ansible.cfg](ansible.cfg) - custom Ansible configuration file
* [hosts.yml](hosts.yml) - Ansible inventory file. See below detailed description.
* [main.yml](main.yml) - main Ansible playbook file
* [README.md](README.md) - this file


# Inventory file: `hosts.yml`

The main file which contains almost all parameters for customizations.  
Simplest form of this file:

```yaml
all:
  vars:
    # user, used for connect to deployed GCE VM instance, will be created with ssh private key and 
    # assigned into VMs metadata. Later you can use this user and generated private key for login 
    # to VM.
    gcp_ssh_user: 
  hosts:
    # here host variables for Terraform, Ansible use it to populate terraform-vm/main.tf 
    # Terraform file
    hostname-of-gce-instance:
      gcp_terraform_machine_type: # type of GCE VM instance
      gcp_terraform_image: # Boot image for GCE VM instance
      gcp_terraform_zone: # Zone in which will deploy GCE VM instance
      gcp_terraform_label_assigned_products: # Labels for GCE VM instance
      ansible_python_interpreter: # Ansible interpreter
  children:
    java:
    # group [java] - Java will be installed on hosts assigned to it
      children:
        zookeeper:
        # group [zookeeper] - Zookeeper will be installed on hosts assigned to it
          hosts:
          # host names to assign in this group
          vars:
          # group variables to customize zookeeper deployment used by zookeeper role
          # vars description in role README.md file
        solr:
        # group [solr] - Solr will be installed on hosts assigned to it
          hosts:
          # host names to assign in this group
          vars:
          # group variables to customize solr deployment used by solr role
          # vars description in role README.md file
        kafka:
        # group [kafka] - Kafka will be installed on hosts assigned to it
          hosts:
          # host names to assign in this group
          vars:
          # group variables to customize kafka deployment used by kafka role
          # vars description in role README.md file
    sftp:
    # group [sftp] - SFTP will be configured on hosts assigned to it
      hosts:
      # host names to assign in this group
      vars:
      # vars description in role README.md file
```
See actual `hosts.yml` file for full example.

# High level operation scheme
1. Generate SSH key-pair  
2. Generate `terraform-vm/main.tf` file using variables with prefix `gcp_` from `hosts.yml`  
3. Creating GCE VMs with Terraform. Assign to the VM metadata `gcp_ssh_user` defined in `hosts.yml` and generated SSH public key  
4. Use external IP address provided by Terraform, `gcp_ssh_user` and generated SSH private key for connect to the VMs and perform Ansible deployment operations.

# Other notes
1. If you need to run the full deployment process. You will define in `hosts.yml`: gcp_terraform... variables, differentiate hosts into inventory groups and customize software deployments with roles variables. Take a note, that inventory does not contain ip addresses of hosts. IP addresses included in inventory dynamically by special Ansible task. It takes IP addresses from Terraform.
2. If you need to run part of deployment process. You must run Ansible playbook with specifying tags (see tags on tasks in `main.yml` file), but you need to specify connection variables (IP, ssh key etc.) in host of group blocks of inventory `hosts.yml` file.