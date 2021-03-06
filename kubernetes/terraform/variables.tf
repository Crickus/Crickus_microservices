variable "project" {
  description = "Project ID"
}

variable "region" {
  description = "Region"
  default     = "europe-west-1"
}

variable "cluster_name" {
  default = "default-cluster-1"
}

variable "zone" {
  description = "Zone"
  default     = "europe-west1-b"
}

variable "initial_node_count" {
  default = 2
}

variable "disk_size" {
  default = 20
}

variable "machine_type" {
  default = "small"
}

variable source_ranges {
  description = "Allowed IP addresses"
  default     = ["0.0.0.0/0"]
}