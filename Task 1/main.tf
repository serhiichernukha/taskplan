provider "google" {
  credentials = file("gcptask-256312-3eebb97a033e")
  project     = var.project
  region      = var.region
  zone        = var.zone
}


resource "google_compute_instance" "appserver" {
  name         = var.servername
  machine_type = var.mtype
  tags         = ["http-server", "https-server"]

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  service_account {
    scopes = ["cloud-platform"]
  }
  network_interface {
    network = "default"
    access_config {      #this block gives our instance external ip adress
          }
  }
  metadata_startup_script = file("./metadata.sh")
}
