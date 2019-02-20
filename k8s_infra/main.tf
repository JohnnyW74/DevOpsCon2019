module "master1" {
  source = "./modules/worker_node"
  cpu = 2
  mem = 2048
  name = "master1"
}

module "worker1" {
  source = "./modules/worker_node"
  cpu = 1
  mem = 1024
  name = "worker1"
}

module "worker2" {
  source = "./modules/worker_node"
  cpu = 1
  mem = 1024
  name = "worker2"
}

module "worker3" {
  source = "./modules/worker_node"
  cpu = 1
  mem = 1024
  name = "worker3"
}

output "child_ip" {
  value = "${module.master1.ip} ${module.worker1.ip} ${module.worker2.ip} ${module.worker3.ip}"
}
