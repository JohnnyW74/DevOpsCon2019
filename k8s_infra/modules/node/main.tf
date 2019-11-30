provider "libvirt" {
  uri = "qemu:///system"
}

variable "cpu" {}
variable "mem" {}
variable "name" {}

resource "libvirt_volume" "os_default" {
  name   = "os_${var.name}"
  pool   = "default"
  source = "/home/swalker/workspace/DevOpsCon2018/playbooks/roles/downloadNodeIso/files/ubuntu-18.04-server-cloudimg-amd64.img"
}

resource "libvirt_volume" "disk_default" {
  name           = "disk_${var.name}"
  base_volume_id = libvirt_volume.os_default.id
  pool           = "default"
  size           = 10000000000
}

# Use CloudInit to add our ssh-key to the instance
resource "libvirt_cloudinit_disk" "cloudinit_default" {
  name = "cloudinit_${var.name}"
  pool = "default"

  user_data = <<EOF
#cloud-config
disable_root: 0
ssh_pwauth: 1
users:
  - name: root
    ssh-authorized-keys:
      - ${file("${path.module}/id_rsa.pub")}
growpart:
  mode: auto
  devices: ['/']
EOF
}

resource "libvirt_domain" "node_default" {
  name   = "node_${var.name}"
  memory = var.mem
  vcpu   = var.cpu

  cloudinit = libvirt_cloudinit_disk.cloudinit_default.id

  network_interface {
    network_name   = "default"
    wait_for_lease = true
  }

  # IMPORTANT
  # Ubuntu can hang if an isa-serial is not present at boot time.
  # If you find your CPU 100% and never is available this is why
  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  disk {
    volume_id = libvirt_volume.disk_default.id
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}

output "ip" {
  value = "${libvirt_domain.node_default.network_interface.0.addresses.0}"
}
