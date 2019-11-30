module "node1" {
  source = "./modules/node"
  cpu = 2
  mem = 3072
  name = "node1"
}

module "node2" {
  source = "./modules/node"
  cpu = 2
  mem = 3072
  name = "node2"
}

module "node3" {
  source = "./modules/node"
  cpu = 2
  mem = 3072
  name = "node3"
}

output "child_ip" {
  value = "\ndeclare -a IPS=(${module.node1.ip} ${module.node2.ip} ${module.node3.ip})"
}
