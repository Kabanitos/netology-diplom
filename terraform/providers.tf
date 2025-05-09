terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.139.0"
    }
  }
  backend "s3" {
    endpoints = {
      s3 = "http://storage.yandexcloud.net"
    }
    bucket = "amishanin-26032025"
    region = "ru-central1"
    key    = "terraform.tfstate"

    access_key = ""
    secret_key = ""

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
