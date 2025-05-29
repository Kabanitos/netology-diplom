resource "yandex_storage_bucket" "my-bucket" {
  access_key = yandex_iam_service_account_static_access_key.sa-bucket-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-bucket-static-key.secret_key
  folder_id  = var.cloud_provider.folder_id
  bucket     = var.storage.name
  max_size   = var.storage.max_size
  ##acl        = var.storage.acl
}
