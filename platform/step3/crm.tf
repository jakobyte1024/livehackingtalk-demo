resource "kubernetes_namespace" "crm" {
  metadata {
    name = "crm"
  }
}

resource "helm_release" "suiteCrm" {
  name       = "crm"
  repository = "oci://registry-1.docker.io/bitnamicharts/"
  chart      = "suitecrm"
  namespace  = "crm"

  depends_on = [
    kubernetes_namespace.crm
  ]
}
