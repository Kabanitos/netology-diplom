terraform {
  required_providers {
    helm = {
      source = "hashicorp/helm"
      version = "3.0.0-pre2"
    }
  }
 backend "s3" {
    endpoints = {
      s3 = "http://storage.yandexcloud.net"
    }
    bucket = "amishanin-26032025"
    region = "ru-central1"
    key    = "monitoring.tfstate"

    access_key = ""
    secret_key = ""

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }

}
provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}