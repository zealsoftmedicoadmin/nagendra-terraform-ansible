/**************************************************************************

    Empty file to set input variables values
    To use it with terraform use "-var-file" option. 
    Example:
        ./terraform apply -var-file="./gcloud/terraform.tfvars" ./gcloud

**************************************************************************/

global_project = "default"
global_region = "us-central1"
global_credentials_file = "gcloud_terraform.json"
