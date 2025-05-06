variable "vm_image" {
  type = string
  default = "focal-server-cloudimg-amd64-vagrant.box"
}

variable "private_key_path" {
  type = string
  default = ".\\key\\insecure_private_key.pem"
}

variable "network_device" {
  type = string
  default = "Killer E2500 Gigabit Ethernet Controller"
}
