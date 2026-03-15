#variable
variable "project" {
  default = "Enter ProjectID"
}


#Create compute instance
resource "google_compute_instance" "vm4" {
  project      = var.project
  name         = "windows"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  #Define extra disk resource

  attached_disk {
    source      = google_compute_disk.extra_disk.id
    device_name = "extra-disk"
    mode        = "READ_WRITE"

  }
  network_interface {
    network = "default"
  }

}

#Define extra disk resource
resource "google_compute_disk" "extra_disk" {
  project = var.project
  name    = "extra-disk"
  type    = "pd-ssd" # options: pd-standard, pd-balanced, pd-ssd
  zone    = "us-central1-a"
  size    = "50" # size in GB
}