variable "project" {
  type = string
}

terraform {
  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "3.1.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "4.5.0"
    }
  }
}

provider "tls" {
  // no config needed
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "ssh_private_key_pem" {
  content         = tls_private_key.ssh.private_key_pem
  filename        = ".ssh/google_compute_engine"
  file_permission = "0600"
}

provider "google" {
  project = var.project
  region  = "europe-west1"
  zone    = "europe-west1-b"
}

resource "google_project_service" "cloud_resource_manager" {
  service            = "cloudresourcemanager.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "compute" {
  service            = "compute.googleapis.com"
  disable_on_destroy = false
}

resource "google_compute_network" "vpc_network" {
  name = "debian-vpc"
}

resource "google_compute_address" "static_ip" {
  name = "debian-vm"
}

resource "google_compute_firewall" "allow_ssh" {
  name          = "allow-ssh"
  network       = google_compute_network.vpc_network.name
  target_tags   = ["allow-ssh"] // this targets our tagged VM
  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}

data "google_client_openid_userinfo" "me" {}

resource "google_compute_instance" "debian_vm" {
  name         = "debian"
  machine_type = "f1-micro"
  tags         = ["allow-ssh"] // this receives the firewall rule

  metadata = {
    ssh-keys = "${split("@", data.google_client_openid_userinfo.me.email)[0]}:${tls_private_key.ssh.public_key_openssh}"
  }

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name

    access_config {
      nat_ip = google_compute_address.static_ip.address
    }
  }
}

output "public_ip" {
  value = google_compute_address.static_ip.address
}

