variable "cloud_provider" {
  type = object({
    cloud_id  = string
    folder_id = string
    zone      = string
  })
}

variable "subnet" {
  type = map(object({
    name           = string
    v4_cidr_blocks = string
    zone           = string
    description    = string
  }))

  default = {
    "zone-a" = {
      name           = "zone-a"
      v4_cidr_blocks = "192.168.1.0/24"
      zone           = "ru-central1-a"
      description    = "Subnet zone ru-central1-a"
    }
    "zone-b" = {
      name           = "zone-b"
      v4_cidr_blocks = "192.168.2.0/24"
      zone           = "ru-central1-b"
      description    = "Subnet zone ru-central1-b"
    }

    "zone-d" = {
      name           = "zone-d"
      v4_cidr_blocks = "192.168.3.0/24"
      zone           = "ru-central1-d"
      description    = "Subnet zone ru-central1-d"
    }
  }
}

variable "image" {
  type    = string
  default = "fedora-37"

}


variable "master-node" {
  type = map(object({
    subnet_key    = string
    platform_id   = string
    zone          = string
    core          = number
    memory        = number
    core_fraction = number
  }))
  default = {
    "master" = {
      subnet_key    = "zone-a"
      platform_id   = "standard-v2"
      zone          = "ru-central1-a"
      core          = 2
      memory        = 4
      core_fraction = 20
    }
  }
  
}
variable "worker-node" {
  type = map(object({
    subnet_key    = string
    platform_id   = string
    zone          = string
    core          = number
    memory        = number
    core_fraction = number
  }))
  default = {
    "worker1" = {
      subnet_key    = "zone-b"
      platform_id   = "standard-v2"
      zone          = "ru-central1-b"
      core          = 2
      memory        = 4
      core_fraction = 20
    }
    "worker2" = {
      subnet_key    = "zone-d"
      platform_id   = "standard-v2"
      zone          = "ru-central1-d"
      core          = 2
      memory        = 4
      core_fraction = 20
    }
  }

}

variable "username-init" {
  type = string
  default = "admin"
}
