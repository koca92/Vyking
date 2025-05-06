variable "vm_image" {
  type = string
  default = "focal-server-cloudimg-amd64-vagrant.box"
  #default = "package.box"
}

variable "vm_cpus" {
  type = number
  default = 2
}

variable "vm_memory" {
  type = string
  default = "2048 mib"
}

variable "private_key_path" {
  type = string
}

variable "network_device" {
  type = string
}

variable "master_ip" {
  type = string
}

variable "master_node_token" {
  type = string
}
variable "WorkerCount" {
  type = number
}