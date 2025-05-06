terraform {
  required_providers {
    virtualbox = {
      source  = "terra-farm/virtualbox"
      version = "0.2.2-alpha.1"
    }
  }
}

resource "virtualbox_vm" "worker_nodes" {
  count  = var.WorkerCount
  name   = "k8s-worker-${count.index + 1}"
  image  = var.vm_image
  cpus   = var.vm_cpus
  memory = var.vm_memory

  network_adapter {
    type            = "bridged"
    host_interface  = var.network_device
  }
}
resource "time_sleep" "vm_launch_delay" {
  create_duration = "30s"

  depends_on = [virtualbox_vm.worker_nodes]
}
resource "null_resource" "install_k3s_agents" {
  depends_on = [ time_sleep.vm_launch_delay ]
  count = length(virtualbox_vm.worker_nodes)

  

  provisioner "remote-exec" {
  inline = [
    "sudo hostname worker${count.index + 1}",
    "curl -sfL https://get.k3s.io | K3S_URL=https://${var.master_ip}:6443 K3S_TOKEN=${var.master_node_token} sh -"
  ]

    connection {
      type        = "ssh"
      user        = "vagrant"
      #password = "vagrant"
      #timeout = 10
      private_key = file(var.private_key_path)
      host        = virtualbox_vm.worker_nodes[count.index].network_adapter[0].ipv4_address
    }
  }
}
