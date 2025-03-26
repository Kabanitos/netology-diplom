data "yandex_compute_image" "ubuntu" {
  family = var.image
}


resource "yandex_compute_instance" "cluster" {
  for_each    = var.cluster
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
      image_id = data.yandex_compute_image.ubuntu.id

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
    foo      = "bar"
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }
}
