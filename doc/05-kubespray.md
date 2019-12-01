Kubespray
===

Projekt: [kubernetes-sigs/kubespray](https://github.com/kubernetes-sigs/kubespray)
```
ansible-playbook -i inventory/mycluster/inventory.ini --become --become-user=root cluster.yml --flush-cache
```

--flush_cache ist notwendig sobald man das Playbook mehr als einmal laufen lässt(known issue: https://github.com/kubernetes-sigs/kubespray/issues/2767)

```
ansible-playbook -i inventory/mycluster/inventory.ini ../playbooks/get_kube_config.yml
```

[zurück](https://github.com/JohnnyW74/DevOpsCon2019/blob/master/doc/04-terraform.md) [weiter](https://github.com/JohnnyW74/DevOpsCon2019/blob/master/doc/06-metallb.md)
