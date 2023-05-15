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
  tag: 2.387.3-lts
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
    - git:5.0.0
    - git-client:4.0
    - configuration-as-code:1569.vb_72405b_80249
    - kubernetes:1.30.5
    - workflow-cps:2.94
    - workflow-aggregator:2.7
    - job-dsl:1.81
    - lockable-resources:2.18
  JCasC:
    credentials: |-
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
    jobs: |-
      - script: >
          multibranchPipelineJob('configuration-as-code') {
              branchSources {
                  git {
                      id = 'configuration-as-code'
                      remote('https://github.com/jenkinsci/configuration-as-code-plugin.git')
                  }
              }
          }
      - script: |- >
        job('testJob1') {
            scm {
                git('git://github.com/quidryan/aws-sdk-test.git')
            }
            triggers {
                scm('H/15 * * * *')
            }
            steps {
                maven('-e clean test')
            }
        }
      - script: |- >
          job('testJob2') {
              scm {
                  git('git://github.com/quidryan/aws-sdk-test.git')
              }
              triggers {
                  scm('H/15 * * * *')
              }
              steps {
                  maven('-e clean test')
              }
          }
EOF
  ]
}
  