resource "kubernetes_namespace" "conduitApp" {
  metadata {
    name = "conduit-app"
  }
}

resource "helm_release" "conduitDb" {
  name       = "database"
  repository = "https://cloudnative-pg.github.io/charts"
  chart      = "cloudnative-pg"
  namespace  = "conduit-app"

  depends_on = [
    kubernetes_namespace.conduitApp
  ]
}

resource "kubernetes_namespace" "ingressNginx" {
  metadata {
    name = "ingress-nginx"
  }
}

resource "helm_release" "ingressNginxController" {
  name       = "ingress-nginx-controller"
  repository = "https://kubernetes.github.io/ingress-nginx/"
  chart      = "ingress-nginx"
  namespace  = "ingress-nginx"

  set {
    name  = "ingressClassResource.default"
    value = "true"
  }

  depends_on = [
    kubernetes_namespace.ingressNginx
  ]
}
