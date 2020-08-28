// Use this data provider to expose an access token for communicating with the GKE cluster.
data "google_client_config" "client" {}


/***********
  Providers
***********/

provider "google" {
  /* Used with credentials JSON file of service account key
    If not use it don't forget run "gcloud auth application-default login" 
    command to get default credentials 
  */
  credentials = file(var.global_credentials_file)
  project = var.global_project
  region = var.global_region
}

/***********
  Modules
***********/

module "vpc" {
  source = "./modules/vpc"

  network = "dev-vpc-1"
  subnetwork = "dev-vpc-1-subnet01"
  cidr = "10.0.20.0/24"

}

module "firewall" {
  source = "./modules/firewall"
  network = module.vpc.network

/************
  Rules spec. Created only allow rules.

  rules = {
    "rule-name" = {
        "priority" = "rule_priority",
        "proto" = "L4 protocol",
        "ports" = ["port1","portN"]
    }
  }
***********/

  rules = {
    "allow-ssh" = {
        "priority" = "999",
        "proto" = "tcp",
        "ports" = ["22"]
    }
    "allow-zookeeper" = {
        "priority" = "1000",
        "proto" = "tcp",
        "ports" = ["2181","2182","2183"]
    }
    "allow-solr" = {
        "priority" = "1001",
        "proto" = "tcp",
        "ports" = ["8983","8984","8985"]
    }
    "allow-kafka" = {
        "priority" = "1002",
        "proto" = "tcp",
        "ports" = ["9093","9094","9095"]
    }
    "allow-confluence-schema" = {
        "priority" = "1003",
        "proto" = "tcp",
        "ports" = ["8081"]
    }
  }

}

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
    "kafka-dev" = {
        "machine_type" = "n1-standard-1",
        "image" = "ubuntu-1804-bionic-v20200807",
        "network" = module.vpc.network,
        "subnetwork" = module.vpc.subnetwork,
        "zone" = "us-central1-a",
        "label_assigned_products" = "product",
        "ssh_user" = "user",
        "ssh_key" = var.ssh_key
    }
    "sftp-dev" = {
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

