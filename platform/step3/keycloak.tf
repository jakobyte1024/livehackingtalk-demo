resource "kubernetes_namespace" "keycloak" {
  metadata {
    name = "keycloak"
  }
}

resource "helm_release" "keycloak" {
  name       = "keycloak"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "keycloak"
  namespace  = "keycloak"

  depends_on = [
    kubernetes_namespace.keycloak
  ]
}
