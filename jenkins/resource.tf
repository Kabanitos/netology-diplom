
resource "helm_release" "jenkins" {
    name = "my-jenkins"
    chart = "jenkins"

    values = [file("./jenkins/values.yaml")]
}