resource "yandex_vpc_network" "diplom" {
  name = "diplom"
}
#
resource "yandex_vpc_subnet" "subnet" {
  for_each       = var.subnet
  name           = each.value.name
  v4_cidr_blocks = [each.value.v4_cidr_blocks]
  zone           = each.value.zone
  network_id     = yandex_vpc_network.diplom.id
  description    = each.value.description
}


