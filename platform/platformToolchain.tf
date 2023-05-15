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
  enabled: true
rbac:
  create: true
controller:
  tag: 2.387.3-lts-jdk11
  serviceType: LoadBalancer
  #installLatestPlugins: true
  #overwritePluginsFromImage: false
  loadBalancerIP: ${google_compute_address.jenkinsIp.address}
  installPlugins: 
    - git:5.0.0
    - configuration-as-code:1625.v27444588cc3d
    - kubernetes:3900.va_dce992317b_4
    - workflow-aggregator:596.v8c21c963d92d
    - job-dsl:1.82
  sidecars:
    configAutoReload:
      enabled: true
  JCasC:
    configScripts:
      log-recorder: |-
        jenkins:
          log:
            recorders:
            - name: "useraccesslog"
              loggers:
                - level: "FINEST"
                  name: "jenkins.security.SecurityListener"
      credentials: |-
        credentials:
          system:
            domainCredentials:
              - credentials:
                - usernamePassword:
                    id: "exampleuser-creds-id"
                    username: "exampleuser"
                    password: "{AQAAABAAAAAQ1/JHKggxIlBcuVqegoa2AdyVaNvjWIFk430/vI4jEBM=}"
                    description: "Sample credentials of exampleuser"
                    scope: GLOBAL
                - usernamePassword:
                    id: "exampleuser-creds-id2"
                    username: "exampleuser2"
                    password: "{AQAAABAAAAAQ1/JHKggxIlBcuVqegoa2AdyVaNvjWIFk430/vI4jEBM=}"
                    description: "Sample credentials of exampleuser"
                    scope: GLOBAL
      jobs: |-
        jobs:
          - script: >
              job('socialweb-api-deploy') {
                scm {
                  git('https://github.com/jakobyte1024/livehackingdemo-app.git')
                }
                triggers {
                  scm('H/15 * * * *')
                }
                steps {
                    sh "ls -lat"
                    echo 'Deploy backend container'
                }
              }
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
          - id: "Robert.Bartsch"
            name: "Robert Bartsch"
            password: "!@#$%1234pacr1234!@#$%"
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
            password: "!@#$%67890QAZwsxh"
    authorizationStrategy: |-
      loggedInUsersCanDoAnything:
        allowAnonymousRead: false
  
EOF
  ]
}
  