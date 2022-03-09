resource "google_compute_firewall" "firewall_ssh" {
  name        = "default-allow-ssh"
  network     = "default"
  description = "Allow SSH from anywhere"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = "${var.source_ranges}"
}

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

resource "google_compute_firewall" "firewall_prometheus" {
  name        = "default-allow-prometheus"
  network     = "default"
  description = "Allow Prometheus from anywhere"

  allow {
    protocol = "tcp"
    ports    = ["9090"]
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

resource "google_compute_firewall" "firewall_cadvisor" {
  name        = "default-allow-cadvisor"
  network     = "default"
  description = "Allow cAdvisor traffic from anywhere"

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_ranges = "${var.source_ranges}"
  target_tags   = ["docker"]
}

resource "google_compute_firewall" "firewall_mongo_exporter" {
  name        = "default-allow-mongo-exporter"
  network     = "default"
  description = "Allow mongodb exporter traffic from anywhere"

  allow {
    protocol = "tcp"
    ports    = ["9216"]
  }

  source_ranges = "${var.source_ranges}"
  target_tags   = ["docker"]
}

resource "google_compute_firewall" "firewall_grafana" {
  name        = "default-allow-grafana"
  network     = "default"
  description = "Allow grafana traffic from anywhere"

  allow {
    protocol = "tcp"
    ports    = ["3000"]
  }

  source_ranges = "${var.source_ranges}"
  target_tags   = ["docker"]
}

resource "google_compute_firewall" "firewall_post_metrics" {
  name        = "default-allow-post-metrics"
  network     = "default"
  description = "Allow post metrics gathering from anywhere"

  allow {
    protocol = "tcp"
    ports    = ["5000"]
  }

  source_ranges = "${var.source_ranges}"
  target_tags   = ["docker"]
}

resource "google_compute_firewall" "firewall_alertmanager" {
  name        = "default-allow-alertmanager"
  network     = "default"
  description = "Allow alertmanager posts from anywhere"

  allow {
    protocol = "tcp"
    ports    = ["9093"]
  }

  source_ranges = "${var.source_ranges}"
  target_tags   = ["docker"]
}

resource "google_compute_firewall" "firewall_docker_monitor" {
  name        = "default-allow-docker-monitor"
  network     = "default"
  description = "Allow docker monitor from anywhere"

  allow {
    protocol = "tcp"
    ports    = ["9323"]
  }

  source_ranges = "${var.source_ranges}"
  target_tags   = ["docker"]
}

resource "google_compute_firewall" "firewall_telegraf_mon" {
  name        = "default-allow-telegraf-mon"
  network     = "default"
  description = "Allow telegraf monitoring from anywhere"

  allow {
    protocol = "tcp"
    ports    = ["9273"]
  }

  source_ranges = "${var.source_ranges}"
  target_tags   = ["docker"]
}

# resource "google_compute_firewall" "firewall_stackdriver" {
#   name        = "default-allow-stackdriver"
#   network     = "default"
#   description = "Allow stackdriver monitoring from anywhere"

#   allow {
#     protocol = "tcp"
#     ports    = ["9255"]
#   }

#   source_ranges = "${var.source_ranges}"
#   target_tags   = ["docker"]
# }