variable "project" {
  description = "Project unic ID"
  default = "gcptask-256312"
}

variable "region" {
  default = "us-central1"
}

variable "zone" {
  default = "us-central1-a"
}

variable "default_network" {
  description = "Default VPC network"
  type = string
  default = "projects/gcptask-256312/global/networks/default"
}

variable "image" {
  default = "centos-7-v20191014"
}

variable "mtype" {
  default = "n1-standard-1"
}

variable "servername" {
  default = "dockerserver"
}
