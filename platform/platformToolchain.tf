resource "kubernetes_namespace" "toolchainNamespace" {
  metadata {
    name = "conduit-toolchain"
  }
}

resource "google_compute_address" "jenkinsIp" {
  name          = "jenkinsip"
  region        = "europe-west3"
  address_type  = "EXTERNAL"
}

resource "google_dns_record_set" "jenkins" {
  name         = "jenkins.${data.google_dns_managed_zone.env_dns_zone.dns_name}"
  managed_zone = data.google_dns_managed_zone.env_dns_zone.name
  type         = "A"
  ttl          = 10

  rrdatas = [google_compute_address.jenkinsIp.address]
}

resource "helm_release" "jenkins" {
  name       = "conduit-jenkins"
  repository = "https://charts.jenkins.io"
  chart      = "jenkins"
  namespace  = "conduit-toolchain"

  depends_on = [
    kubernetes_namespace.toolchainNamespace
  ]

  values = [<<EOF
controller:
  tag: 2.299
  serviceType: LoadBalancer
  installLatestPlugins: false
  overwritePluginsFromImage: true
  loadBalancerIP: ${google_compute_address.jenkinsIp.address}
  installPlugins: 
    - git:4.0.0
  JCasC:
    securityRealm: |-
      local:
        allowsSignup: false
        enableCaptcha: false
        users:
        - id: "conduit-admin"
          name: "Jenkins Admin"
          password: "conduit-admin-password"
    authorizationStrategy: |-
      loggedInUsersCanDoAnything:
        allowAnonymousRead: false
EOF
  ]
}
