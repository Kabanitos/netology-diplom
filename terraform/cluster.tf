data "yandex_compute_image" "os" {
  family = var.image
}

resource "local_file" "cloud-init" {
  filename = "./cloud-init.yaml"
  content  = templatefile("cloud-init.tpl", {username = var.username-init, ssh_key = local.ssh_key})
}
resource "yandex_compute_instance" "master" {
  for_each    = var.master-node
  name        = each.key
  platform_id = each.value.platform_id
  zone        = each.value.zone
  hostname    = each.key

  allow_stopping_for_update = true

  resources {
    cores         = each.value.core
    memory        = each.value.memory
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.os.id

    }
  }

  network_interface {
    index     = 1
    subnet_id = yandex_vpc_subnet.subnet[each.value.subnet_key].id
    nat       = true
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    serial-port-enable = 1
    user-data = local_file.cloud-init.content

  }
}


resource "yandex_compute_instance" "worker" {
  for_each    = var.worker-node
  name        = each.key
  platform_id = each.value.platform_id
  zone        = each.value.zone
  hostname    = each.key

  allow_stopping_for_update = true

  resources {
    cores         = each.value.core
    memory        = each.value.memory
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.os.id

    }
  }

  network_interface {
    index     = 1
    subnet_id = yandex_vpc_subnet.subnet[each.value.subnet_key].id
    nat       = true
  }

  scheduling_policy {
    preemptible = true
  }

  metadata = {
    serial-port-enable = 1
    user-data = local_file.cloud-init.content
 } 
}