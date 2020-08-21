variable "global_project" {
    description = "Google cloud platform project."
    type = string
    default = "default"
}

variable "global_credentials_file" {
    description = "JSON file with service account authentication credentials."
    type = string
    default = "./gcloud/gcloud_terraform.json"
}

variable "global_region" {
    description = "GCP region in which to perform operations."
    type = string
    default = "default"
}
