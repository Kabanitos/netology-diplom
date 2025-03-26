output "access_key_sa_bucket" {
  value = yandex_iam_service_account_static_access_key.sa-bucket-static-key.access_key
  description = "Access key for service account bucket"
  sensitive   = true
}

output "secret_key_sa_bucket" {
  value = yandex_iam_service_account_static_access_key.sa-bucket-static-key.secret_key
  description = "Secret key for service account bucket"
  sensitive   = true
} 

output "access_key_vmmanager" {
  value = yandex_iam_service_account_static_access_key.sa-vmmanager-static-key.access_key
  description = "Access key for service account vmmanager"
  sensitive   = true
}

output "secret_key_vmmanager" {
  value = yandex_iam_service_account_static_access_key.sa-vmmanager-static-key.secret_key
  description = "Secret key for service account vmmanager"
  sensitive   = true
} 
