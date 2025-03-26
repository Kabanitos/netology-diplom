variable "cloud_provider" {
  type = object({
    cloud_id  = string
    folder_id = string
    zone      = string
  })
}


variable "storage" {
  type = object({
    name     = string
    max_size = number
    acl      = string
  })
  default = {
    name     = "amishanin-26032025"
    max_size = "1073741824" # 1Gb
    acl      = "private"
  }

}

variable "svc-name-storage" {
  type = string
  description = "Name service account storage bucket"
  default = "sa-bucket"
}

variable "svc-name-vmmanager" {
  type = string
  description = "Name service account vmmanger"
  default = "vmmanager"
}