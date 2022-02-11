terraform {
  # Terraform version
  required_version = "0.11.11"
}

provider "google" {
  # Provider version
  version = "2.0.0"

  # Project ID
  project = "${var.project}"
  region  = "${var.region}"
}

resource "google_compute_instance" "gitlab" {
  count        = "${var.number_of_instances}"
  name         = "gitlab-${count.index}"
  machine_type = "e2-medium"
  zone         = "${var.zone}"
  tags         = ["gitlab"]

  boot_disk {
    initialize_params {
      image = "docker-compose"
    }
  }

  network_interface {
    network = "default"

    access_config = {
      nat_ip = "${element(google_compute_address.gitlab_ip.*.address, count.index) }"
    }
  }

  metadata = {
    "ssh-keys" = "appuser:${file(var.public_key_path)}"
  }

    connection {
      type        = "ssh"
      user        = "appuser"
      agent       = false
      private_key = "${file(var.private_key_path)}"
    }

    # provisioner "file" {
    #   source      = "${path.module}/files/set_env.sh"
    #   destination = "/tmp/set_env.sh"
    # }

    provisioner "file" {
        source      = "./files/script.sh"
        destination = "/tmp/script.sh"
      }

    provisioner "file" {
      source      = "./files/docker-compose.yml"
      destination = "/tmp/docker-compose.yml"
    }

    provisioner "file" {
      source      = "./files/.env"
      destination = "/tmp/.env"
    }

    provisioner "remote-exec" {
      inline = [
      "export MY_IP=http://$(curl ifconfig.me)"
      # "export MY_IP=\"${google_compute_instance.gitlab.*.network_interface.0.access_config.0.nat_ip}\""
      ]
    }

    provisioner "remote-exec" {
      inline = [
        "chmod +x /tmp/script.sh",
        "sudo /tmp/script.sh args",
      ]
    }


    # provisioner "remote-exec" {
    #   inline = [
    #   "sudo mkdir -p /srv/gitlab/config /srv/gitlab/data /srv/gitlab/logs",
    #   "cd /srv/gitlab/" 
    #   ]
    # }

    # provisioner "file" {
    #   source      = "./files/docker-compose.yml"
    #   destination = "/srv/gitlab/doker-compose.yml"
    # }

    # provisioner "remote-exec" {
    #   inline = [
    #   "export MY_IP=\"$(curl ifconfig.me)\""
    #   # "export MY_IP=\"${google_compute_instance.gitlab.*.network_interface.0.access_config.0.nat_ip}\""
    #   ]
    # }

    # provisioner "remote-exec" {
    #   script = "${path.module}/files/deploy.sh"
    # }
}

resource "google_compute_firewall" "firewall_http" {
  name        = "default-allow-http"
  network     = "default"
  description = "Allow HTTP from anywhere"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = "${var.source_ranges}"
}

resource "google_compute_address" "gitlab_ip" {
  count  = "${var.number_of_instances}"
  name = "remote-gitlab-${count.index}"
  region = "${var.region}"
}

resource "google_compute_firewall" "firewall_https" {
  name        = "default-allow-https"
  network     = "default"
  description = "Allow HTTPS from anywhere"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = "${var.source_ranges}"
}

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
}

resource "google_compute_firewall" "firewall_docker" {
  name        = "default-allow-puma"
  network     = "default"
  description = "Allow Puma from anywhere"

  allow {
    protocol = "tcp"
    ports    = ["2375"]
  }

  source_ranges = "${var.source_ranges}"
}