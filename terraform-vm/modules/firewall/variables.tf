variable "rules" {
    description = "Rule spec"
    type = map
    default = {}
}

variable "network" {
    description = "GCP Network"
    type = string
    default = "default"
}