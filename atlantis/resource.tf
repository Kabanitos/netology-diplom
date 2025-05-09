resource "helm_release" "atlantis" {
    name = "atlantis"
    repository = "https://runatlantis.github.io/helm-charts"
    chart = "atlantis"

    values = [file("values.yaml")]
}