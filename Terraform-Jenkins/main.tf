provider "google" {
  project = "terrafrom-jenkins"
  region  = "us-central1"
  zone    = "us-central1-a"
}

resource "google_compute_instance" "terraform-jenkins" {
  name         = "terraform-jenkins"
  machine_type = "n1-standard-1"
  #zone         =   "${element(var.var_zones, count.index)}"
  zone = "us-central1-a"
  tags = ["ssh", "http"]
  boot_disk {
    initialize_params {
      image = "jenkins-demo"
    }
  }
  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }
  labels = {
    jenkins = "true"
  }
  metadata_startup_script = "sudo service jenkins start"
}
resource "google_compute_firewall" "terraform-jenkins" {
  name    = "jenkins-app-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }
}