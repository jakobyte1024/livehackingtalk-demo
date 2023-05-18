resource "kubernetes_namespace" "wordpress" {
  metadata {
    name = "wordpress"
  }
}

resource "helm_release" "suitewordpress" {
  name       = "wordpress"
  repository = "oci://registry-1.docker.io/bitnamicharts/"
  chart      = "wordpress"
  namespace  = "wordpress"

  depends_on = [
    kubernetes_namespace.wordpress
  ]
}
