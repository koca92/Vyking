output "master_ip" {
  value = virtualbox_vm.control_plane.network_adapter[0].ipv4_address
}

output "masterToken" {
  value = data.external.token.result["token"]
}