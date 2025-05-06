output "worker_ips" {
  value = [for vm in virtualbox_vm.worker_nodes : vm.network_adapter[0].ipv4_address]
}

output "name" {
  value = "curl -sfL https://get.k3s.io | K3S_URL=https://${var.master_ip}:6443 K3S_TOKEN=${var.master_node_token} sh -"
}



