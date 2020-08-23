variable "global_project" {
    description = "Google cloud platform project."
    type = string
    default = "default"
}

variable "global_credentials_file" {
    description = "JSON file with service account authentication credentials."
    type = string
    default = "default.json"
}

variable "global_region" {
    description = "GCP region in which to perform operations."
    type = string
    default = "default"
}

variable "ssh_user" {
    description = "SSH username for connecting to new instances"
    type = string
    default = "default"
}

variable "ssh_key" {
    description = "SSH public key for connecting to new instances"
    type = string
    default = "default"
}