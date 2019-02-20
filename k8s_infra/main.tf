module "master1" {
  source = "./modules/worker_node"
  cpu = 4
  mem = 4096
  name = "master1"
}

module "worker1" {
  source = "./modules/worker_node"
  cpu = 2
  mem = 2048
  name = "worker1"
}

module "worker2" {
  source = "./modules/worker_node"
  cpu = 2
  mem = 2048
  name = "worker2"
}

output "child_ip" {
  value = "\n            ${module.master1.ip}:\n            ${module.worker1.ip}:\n            ${module.worker2.ip}:"
}
