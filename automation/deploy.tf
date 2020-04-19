provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = var.datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.DS
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.cluster_name
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "public" {
  name          = var.public_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.TEMPLATE
  datacenter_id = data.vsphere_datacenter.dc.id
}

resource "vsphere_virtual_machine" "vm" {
  count                      = var.vm_count
  name                       = "terraform-vm-${count.index}"
  resource_pool_id           = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id               = data.vsphere_datastore.datastore.id
  folder                     = var.vsphere_folder
  num_cpus                   = var.vm_cpu_count
  memory                     = var.vm_memory_count
  guest_id                   = var.guest_id
  wait_for_guest_net_timeout = 25

  network_interface {
    network_id = data.vsphere_network.public.id
  }

  disk {
    label = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    thin_provisioned = data.vsphere_virtual_machine.template.disks[0].thin_provisioned
    //  eagerly_scrub    = data.vsphere_virtual_machine.template.disks[0].eagerly_scrub
    unit_number      = 0
  }


  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = "terraform-vm-${count.index}"
        domain    = var.vm_domain
        }

      network_interface {
        ipv4_address =  var.vm_ip_address[count.index]
        ipv4_netmask =  var.vm_netmask
        dns_server_list = var.vm_dns_serverlist
      }
      ipv4_gateway  = var.vm_gw
    }
  }
}