resource "yandex_iam_service_account" "vmmanager" {
  name        = var.svc-name-vmmanager
  description = "service account to manage VMs"
  folder_id   = var.cloud_provider.folder_id
}

resource "yandex_resourcemanager_folder_iam_member" "adm_compute_cloud" {
  folder_id = var.cloud_provider.folder_id
  role      = var.compute_role
  member    = "serviceAccount:${yandex_iam_service_account.vmmanager.id}"
}

resource "yandex_iam_service_account_static_access_key" "sa-vmmanager-static-key" {
  service_account_id = yandex_iam_service_account.vmmanager.id
  description        = "static access key for object storage"
}




resource "yandex_iam_service_account" "sa-bucket" {
  name        = var.svc-name-storage
  description = "service account for storage yandex cloud"
  folder_id   = var.cloud_provider.folder_id
}

resource "yandex_resourcemanager_folder_iam_member" "sa-bucket-editor" {
  folder_id = var.cloud_provider.folder_id
  role      = var.storage_role
  member    = "serviceAccount:${yandex_iam_service_account.sa-bucket.id}"
}

resource "yandex_iam_service_account_static_access_key" "sa-bucket-static-key" {
  service_account_id = yandex_iam_service_account.sa-bucket.id
  description        = "static access key for object storage"
}
