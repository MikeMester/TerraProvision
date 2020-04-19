variable "vsphere_user" { // If left blank will prompt
}

variable "vsphere_password" { //If left blank will prompt
}

variable "datacenter" {
  default = "Mester"
}

variable "DS" {
  type        = string
  default     = "Mercury-NFS"
  description = "Datastore"
}

variable "thin_provision" {
  default = "true"
}

variable "cluster_name" {
  type    = string
  default = "Blades"
}

variable "public_network" {
  type    = string
  default = "VLAN90"
}

variable "vsphere_server" {
  type    = string
  default = "10.75.1.210"
}

variable "vsphere_folder" {
  type    = string
  default = "Terraform"
}

variable "guest_id" {
  type    = string
  default = "centos7_64Guest"
}

variable "TEMPLATE" {
  type    = string
  default = "Centos7"
}

// Datanode Variables

variable "vm_count" {
  default = "3"
}

variable "vm_ip_address" {
  default = ["10.90.1.240","10.90.1.241","10.90.1.242"]
}

variable "vm_dns_serverlist"{
  default = ["10.75.1.250"]
}

variable "vm_domain" {
  default = "lab.mester.io"
}
variable "vm_netmask"{
  default = "24"
}
variable "vm_gw" {
  default = "10.90.1.1"
}
variable "vm_cpu_count" {
  default     = "8"
  description = "Number of CPUs for each VM"
}

variable "vm_memory_count" {
  default     = "16000"
  description = "Amount of Memory for each VM in MB"
}

