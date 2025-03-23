variable "cloud_provider" {
  type = object({
    cloud_id  = string
    folder_id = string
    zone      = string
  })
}

variable "compute_role" {
  type        = string
  description = "Role service account in Compute cloud"
  default     = "compute.admin"
}

variable "storage_role" {
  type        = string
  description = "Role for  create storage bucket in YC"
  default     = "storage.editor"
}

variable "storage" {
  type = object({
    name     = string
    max_size = number
    acl      = string
  })
  default = {
    name     = "mybucket"
    max_size = "1073741824" # 1Gb
    acl      = "private"
  }

}
