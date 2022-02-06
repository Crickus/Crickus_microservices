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

resource "google_compute_instance" "docker" {
  count        = "${var.number_of_instances}"
  name         = "docker-${count.index}"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["docker"]

  boot_disk {
    initialize_params {
      image = "docker"
    }
  }

  network_interface {
    network = "default"

    access_config = {
      nat_ip = "${element(google_compute_address.docker_ip.*.address, count.index) }"
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

    # provisioner "remote-exec" {
    #   inline = [
    #   "/bin/chmod +x /tmp/set_env.sh",
    #   "/tmp/set_env.sh ${var.database_url}"
    #   ]
    # }

    # provisioner "file" {
    #   source      = "${path.module}/files/puma.service"
    #   destination = "/tmp/puma.service"
    # }

    # provisioner "remote-exec" {
    #   script = "${path.module}/files/deploy.sh"
    # }
}

resource "google_compute_address" "docker_ip" {
  count  = "${var.number_of_instances}"
  name = "remote-docker-ip-${count.index}"
  region = "${var.region}"
}

module "vpc" {
  source        = "./modules/vpc"
  source_ranges = ["0.0.0.0/0"]
}

