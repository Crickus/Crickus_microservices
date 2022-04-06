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
    preemptible  = "true"
    machine_type = "n1-standard-1"
  }

  addons_config {
    network_policy_config {
      disabled = false
    }
    # kubernetes_dashboard {
    #   disabled = false
    # }
  }
  network_policy {
    enabled = true
  }
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