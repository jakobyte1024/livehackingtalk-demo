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
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"
  namespace  = "ingress-nginx"
  version = "9.7.2"

  set {
    name  = "ingressClassResource.name"
    value = "nginx"
  }
  set {
    name  = "service.loadBalancerIP"
    value = google_compute_address.ingressIp.address
  }

  depends_on = [
    kubernetes_namespace.ingressNginx
  ]
}

resource "helm_release" "tetragon" {
  name       = "tetragon"
  repository = "https://helm.cilium.io"
  chart      = "tetragon"
  namespace  = "kube-system"
}

