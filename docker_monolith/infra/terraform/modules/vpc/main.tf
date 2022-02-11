# resource "google_compute_firewall" "firewall_ssh" {
#   name        = "default-allow-ssh"
#   network     = "default"
#   description = "Allow SSH from anywhere"

#   allow {
#     protocol = "tcp"
#     ports    = ["22"]
#   }

#   source_ranges = "${var.source_ranges}"
# }

resource "google_compute_firewall" "firewall_puma" {
  name        = "default-allow-puma"
  network     = "default"
  description = "Allow Puma from anywhere"

  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }

  source_ranges = "${var.source_ranges}"
  target_tags   = ["docker"]
}

resource "google_compute_firewall" "firewall_sw_cluster" {
  name        = "default-allow-sw-cluster"
  network     = "default"
  description = "Allow Swarm cluster conrtol from anywhere"

  allow {
    protocol = "tcp"
    ports    = ["2377"]
  }

  source_ranges = "${var.source_ranges}"
  target_tags   = ["docker"]
}

resource "google_compute_firewall" "firewall_sw_nodes_tcp" {
  name        = "default-allow-sw-nodes-tcp"
  network     = "default"
  description = "Allow Swarm nodes TCP traffic from anywhere"

  allow {
    protocol = "tcp"
    ports    = ["7946"]
  }

  source_ranges = "${var.source_ranges}"
  target_tags   = ["docker"]
}

resource "google_compute_firewall" "firewall_sw_nodes_udp" {
  name        = "default-allow-sw-nodes-udp"
  network     = "default"
  description = "Allow Swarm nodes UDP traffic from anywhere"

  allow {
    protocol = "tcp"
    ports    = ["7946"]
  }

  source_ranges = "${var.source_ranges}"
  target_tags   = ["docker"]
}

resource "google_compute_firewall" "firewall_sw_overlay" {
  name        = "default-allow-sw-overlay"
  network     = "default"
  description = "Allow Swarm overlay traffic from anywhere"

  allow {
    protocol = "tcp"
    ports    = ["4789"]
  }

  source_ranges = "${var.source_ranges}"
  target_tags   = ["docker"]
}