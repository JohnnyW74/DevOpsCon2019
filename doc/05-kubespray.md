Kubespray
===

cp -rfp inventory/sample inventory/mycluster

declare -a IPS=(192.168.122.213 192.168.122.118 192.168.122.28)

ansible-playbook -i inventory/mycluster/inventory.ini --become --become-user=root cluster.yml --flush-cache

flush_cahe wegen https://github.com/kubernetes-sigs/kubespray/issues/2767

ansible-playbook -i inventory/mycluster/inventory.ini ../playbooks/get_kube_config.yml


[zurück](https://github.com/JohnnyW74/DevOpsCon2019/blob/master/doc/04-terraform.md) [weiter](https://github.com/JohnnyW74/DevOpsCon2019/blob/master/doc/06-metallb.md)
