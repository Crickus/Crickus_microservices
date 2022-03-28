terraform {
  required_version = ">=0.11"
}

provider "google" {
#   version = "4.15.0"
  project = "${var.project}"
  region  = "${var.region}"
  zone = "${var.zone}"
}

resource "google_container_cluster" "cluster" {
  name               = "${var.cluster_name}"
#   zone               = "${var.zone}"
  initial_node_count = "${var.initial_node_count}"
  node_config {
  
    machine_type = "e2-small"
  }

#   addons_config {
#     kubernetes_dashboard {
#       disabled = false
#     }
#   }
}

resource "google_compute_firewall" "firewall_kuber" {
  name        = "default-allow-kuber"
  network     = "default"
  description = "Allow Kuber from anywhere"

  allow {
    protocol = "tcp"
    ports    = ["30000-32767"]
  }

  source_ranges = "${var.source_ranges}"
}