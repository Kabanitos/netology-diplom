resource "local_file" "inventory" {
  filename = "../kubesprey/inventory/sample/inventory"
  content  = templatefile("ansible-inventory.tpl", { master = yandex_compute_instance.master, worker = yandex_compute_instance.worker, username = var.username-init })
}

resource "local_file" "group_vars_file" {
  filename = "../kubesprey/ansible-kubsprey-vars.yaml"
  content  = templatefile("ansbile-kubsprey-config.tpl", { master = yandex_compute_instance.master}) 
}

variable "web_provision" {
  type        = bool
  default     = true
  description = "ansible provision switch variable"
}

resource "null_resource" "vars_kubesprey" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -i ../kubesprey/inventory/sample/inventory ../kubesprey/ansible-kubsprey-vars.yaml -b -v"
  }
  depends_on = [yandex_compute_instance.master, yandex_compute_instance.worker]
}

resource "null_resource" "deploy-k8s" {
 # count = var.web_provision == true ? 1 : 0
  #Ждем создания инстанса
 # depends_on = [null_resource.vars_kubesprey]  #Добавление ПРИВАТНОГО ssh ключа в ssh-agent
  
 # provisioner "local-exec" {
 #   command    = "eval $(ssh-agent) && cat ~/.ssh/id_ed25519.pub| ssh-add -"
 #   on_failure = continue #Продолжить выполнение terraform pipeline в случае ошибок

 # }

  #Запуск ansible-playbook
  provisioner "local-exec" {
    
    # without secrets
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -i ../kubesprey/inventory/sample/inventory  ../kubesprey/cluster.yml -b -v"
    # on_failure  = continue
    # environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
  }
  depends_on = [null_resource.vars_kubesprey]
#   triggers = {
#     always_run      = "${timestamp()}" #всегда т.к. дата и время постоянно изменяются
#     always_run_uuid = "${uuid()}"
#   }
 }

resource "null_resource" "kube-config" {
  provisioner "local-exec" {
    command = "ANSIBLE_FORCE_COLOR=1 ansible-playbook -i ../kubesprey/inventory/sample/inventory ./playbook-kubeconf.yaml -b -v"
  }
  depends_on = [null_resource.deploy-k8s]
}
