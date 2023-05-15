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
  name         = "jenkins.${var.environment}.${data.google_dns_managed_zone.env_dns_zone.dns_name}"
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
agent:
  enabled: false
controller:
  tag: 2.300-centos
  serviceType: LoadBalancer
  installLatestPlugins: false
  overwritePluginsFromImage: true
  initContainerEnv:
    - name: CURL_OPTIONS
      value: --insecure
  containerEnv:
    - name: CURL_OPTIONS
      value: --insecure
  loadBalancerIP: ${google_compute_address.jenkinsIp.address}
  installPlugins: 
    - git:4.0.0
    - git-client:3.11.2
    - configuration-as-code:1.54
    - kubernetes:1.30.5
    - workflow-cps:2.94
    - workflow-aggregator:2.7
  JCasC:
    securityRealm: |-
      local:
        allowsSignup: false
        enableCaptcha: false
        users:
          - id: "conduit-admin"
            name: "Jenkins Admin"
            password: "K0nDu17-4dm1n-p422W0rD"
          - id: "KMeyer"
            name: "Kay Meyer"
            password: "a842000zhd"
          - id: "RobertB"
            name: "Robert Bartsch"
            password: "^ZxCvBnM,"
          - id: "RicardoPope"
            name: "Ricardo Pope"
            password: "g3mm@;"
          - id: "SueLeach"
            name: "Sue Leach"
            password: "*7¡Vamos!"
          - id: "Lukasz_Newman"
            name: "Lukasz Newman"
            password: "cheater"
          - id: "Jeffrey_van_d_Linden"
            name: "Jeffrey van der Linden"
            password: "a6_123"
    authorizationStrategy: |-
      loggedInUsersCanDoAnything:
        allowAnonymousRead: false
EOF
  ]
}
  