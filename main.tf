# main.tf
terraform {
  required_providers {
    virtualbox = {
      source  = "terra-farm/virtualbox"
      version = "0.2.2-alpha.1"
    }
  }
}

provider "virtualbox" {
  
}

module "k8s_master" {
  source = "./modules/k8s_master"

  vm_image           = var.vm_image
  private_key_path   = var.private_key_path
  network_device = var.network_device
}

module "k8s_workers" {
  depends_on = [ module.k8s_master ]
  source = "./modules/k8s_workers"

  private_key_path   = var.private_key_path
  network_device = var.network_device
  master_ip          = module.k8s_master.master_ip
  master_node_token  = module.k8s_master.masterToken
  WorkerCount = 2
}