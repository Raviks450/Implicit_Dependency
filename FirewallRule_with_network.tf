#variable
variable "project" {
  default = "qwiklabs-gcp-03-e0068463750f"
}

#Create vpc network
resource "google_compute_network" "vpc-network" {
  project = var.project
  name    = "vpc-network"
}

#Create Firewall rule

resource "google_compute_firewall" "allow-http" {
  project       = var.project
  name          = "allow-http"
  network       = google_compute_network.vpc-network.name
  source_tags   = ["public"]
  source_ranges = ["10.1.0.0/24"]

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
}