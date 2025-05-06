output "master_ip" {
  description = "IP address of the Kubernetes control plane node"
  value       = module.k8s_master.master_ip
}

output "worker_ips" {
  description = "IP addresses of the Kubernetes worker nodes"
  value       = module.k8s_workers.worker_ips
}

output "kubeconfig_instructions" {
  description = "Instructions for fetching the kubeconfig file"
  value = <<EOT
After apply, to configure kubectl:
Run: ./get-kubeconfig.ps1 ${module.k8s_master.master_ip} ${var.private_key_path}
EOT
}

output "token1" {
  value = module.k8s_master.masterToken
}