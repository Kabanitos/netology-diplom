terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.138.0"
    }
  }
  backend "s3" {
    endpoints = {
      s3 = "https://storage.yandexcloud.net"
    }
    bucket = var.storage.name
    region = var.cloud_provider.zone
    key    = "./terraform.tfstate"

    access_key = yandex_iam_service_account_static_access_key.sa-bucket-static-key.access_key
    secret_key = yandex_iam_service_account_static_access_key.sa-bucket-static-key.secret_key

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}


provider "yandex" {
  cloud_id                 = var.cloud_provider.cloud_id
  folder_id                = var.cloud_provider.folder_id
  zone                     = var.cloud_provider.zone
  service_account_key_file = file("~/authorized_key.json")
}
