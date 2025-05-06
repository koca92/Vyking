terraform {
  required_providers {
    virtualbox = {
      source  = "terra-farm/virtualbox"
      version = "0.2.2-alpha.1"
    }
  }
}
resource "virtualbox_vm" "control_plane" {
  name   = "k8s-master"
  image  = var.vm_image
  cpus   = var.vm_cpus
  memory = var.vm_memory

  network_adapter {
    type            = "bridged"
    host_interface  = var.network_device
  }
}

resource "null_resource" "install_k3s" {
  depends_on = [virtualbox_vm.control_plane]

  provisioner "remote-exec" {
    inline = [
      "sudo hostname ${virtualbox_vm.control_plane.name} | curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC='server --node-taint CriticalAddonsOnly=true:NoExecute' sh -",
    ]

    connection {
      type        = "ssh"
      user        = "vagrant"
      #password = "vagrant"
      private_key = file(var.private_key_path)
      host        = virtualbox_vm.control_plane.network_adapter[0].ipv4_address
    }
  }
}
resource "time_sleep" "vm_launch_delay" {
  create_duration = "30s"

  depends_on = [virtualbox_vm.control_plane]
}
data "external" "token" {
  depends_on = [virtualbox_vm.control_plane,time_sleep.vm_launch_delay]
  program=["powershell","./scripts/getToken.ps1 ${virtualbox_vm.control_plane.network_adapter[0].ipv4_address}"]  
}

