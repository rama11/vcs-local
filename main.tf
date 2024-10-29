terraform { 
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
    }
  }
  cloud { 
    
    organization = "ramacompany" 

    workspaces { 
      name = "test-workspace-2" 
    } 
  } 
}

provider "vsphere" {
  user                 = var.VSPHERE_USER
  password             = var.VSPHERE_PASSWORD
  vsphere_server       = var.VSPHERE_SERVER
  allow_unverified_ssl = true
  api_timeout          = 10
}

data "vsphere_datacenter" "datacenter" {
  name = "Inlingua"
}

data "vsphere_datastore" "datastore" {
  name          = "HX-VM-DS"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = "HX-CLS"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_distributed_virtual_switch" "vds" {
  name          = "HX-VDS-01"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
  name          = "SID-Segment-01"
  datacenter_id = data.vsphere_datacenter.datacenter.id
  distributed_virtual_switch_uuid= data.vsphere_distributed_virtual_switch.vds.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = "[LAB] Terraform Installed 3 - Rama"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus         = 1
  memory           = 1024
  guest_id         = "otherLinux64Guest"
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  
  wait_for_guest_net_timeout = 0
  wait_for_guest_ip_timeout  = 0

  disk {
    label = "disk0"
    size  = 20
  }
}
