resource "kubernetes_namespace" "toolchainNamespace" {
  metadata {
    name = "toolchain"
  }
}

data "google_compute_address" "ingressIp" {
  name          = "ingressip${var.environment}"
  region        = "europe-west3"
}

resource "google_dns_record_set" "jenkins" {
  name         = "jenkins.${var.environment}.${data.google_dns_managed_zone.env_dns_zone.dns_name}"
  managed_zone = data.google_dns_managed_zone.env_dns_zone.name
  type         = "A"
  ttl          = 10

  rrdatas = [data.google_compute_address.ingressIp.address]
}

resource "google_service_account" "jenkins" {
  account_id   = "jenkins-sa-${var.environment}"
  display_name = "jenkins-sa-${var.environment}t"
}

resource "google_service_account_key" "jenkins" {
  service_account_id = google_service_account.jenkins.name
}

resource "google_service_account_iam_member" "jenkins" {
  service_account_id = google_service_account.jenkins.name
  role               = "roles/iam.serviceAccountUser"
  member = "serviceAccount:${google_service_account.jenkins.email}"
}

resource "google_service_account_iam_member" "jenkinsMember" {
  service_account_id = google_service_account.jenkins.name
  role               = "roles/editor"
  member             = "serviceAccount:${google_service_account.jenkins.email}"
}

resource "google_project_iam_member" "project" {
  project = "thorsten-jakoby-tj-projekt"
  role    = "roles/editor"
  member = "serviceAccount:${google_service_account.jenkins.email}"
}

resource "helm_release" "jenkins" {
  name       = "conduit-jenkins"
  repository = "https://charts.jenkins.io"
  chart      = "jenkins"
  namespace  = "toolchain"

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
  serviceType: ClusterIP
  installLatestPlugins: false
  overwritePluginsFromImage: true
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
                - string:
                    id: "kubernetes-config-${var.environment}"
                    secret: "{AQAAABAAAAAQ1/JHKggxIlBcuVqegoa2AdyVaNvjWIFk430/vI4jEBM=}"
                    description: "Kubeconfig for deploy jobs"
                    scope: GLOBAL
                - string:
                    id: "keycloak-client-id"
                    secret: "{AQAAABAAAAAQ1/JHKggxIlBcuVqegoa2AdyVaNvjWIFk430/vI4jEBM=}"
                    description: "socialweb stage client id"
                    scope: GLOBAL
                - string:
                    id: "keycloak-client-secret"
                    secret: "{AQAAABAAAAAQ1/JHKggxIlBcuVqegoa2AdyVaNvjWIFk430/vI4jEBM=}"
                    description: "socialweb stage client secret"
                    scope: GLOBAL
                - string:
                    id: "gcp-${var.environment}"
                    secret: "${google_service_account_key.jenkins.private_key}"
                    description: "Service account infrastructure pipeline for stage ${var.environment}"
                    scope: GLOBAL
                - string:
                    id: "redis username"
                    secret: "{AQAAABAAAAAQ1/JHKggxIlBcuVqegoa2AdyVaNvjWIFk430/vI4jEBM=}"
                    description: "socialweb redis username"
                    scope: GLOBAL
                - string:
                    id: "redis password"
                    secret: "{AQAAABAAAAAQ1/JHKggxIlBcuVqegoa2AdyVaNvjWIFk430/vI4jEBM=}"
                    description: "socialweb redis password"
                    scope: GLOBAL
      jobs: |-
        jobs:
          - script: >
              pipelineJob('socialweb-api-ci') {
                definition {
                  cps {
                    script("""\
                      pipeline {
                        agent any
                        triggers {
                          cron('H/15 * * * *')
                        }
                        stages {
                          stage ('prepare') {
                            steps {
                              git branch: 'main',
                              url: 'https://github.com/jakobyte1024/livehackingdemo-app.git'
                              sh "ls -lat"
                            }
                          }
                          stage ('run') {
                            steps {
                              echo "building container"
                            }
                          }
                        }
                      }""".stripIndent())
                    }
                  }
                }
          - script: >
              pipelineJob('socialweb-api-deploy') {
                definition {
                  cps {
                    script("""\
                      pipeline {
                        agent any
                        triggers {
                          cron('H/15 * * * *')
                        }
                        stages {
                          stage ('prepare') {
                            steps {
                              git branch: 'main',
                              url: 'https://github.com/jakobyte1024/livehackingdemo-app.git'
                              sh "ls -lat"
                            }
                          }
                          stage ('run') {
                            steps {
                              echo "deploy built container"
                            }
                          }
                        }
                      }""".stripIndent())
                    }
                  }
                }
          - script: >
              pipelineJob('socialweb-api-stresstest') {
                definition {
                  cps {
                    script("""\
                      pipeline {
                        agent any
                        triggers {
                          cron('H/15 * * * *')
                        }
                        stages {
                          stage ('prepare') {
                            steps {
                              git branch: 'main',
                              url: 'https://github.com/jakobyte1024/livehackingdemo-app.git'
                              sh "ls -lat"
                            }
                          }
                          stage ('run') {
                            steps {
                              echo "stresstesting"
                            }
                          }
                        }
                      }""".stripIndent())
                    }
                  }
                }
          - script: >
              pipelineJob('socialweb-api-debugbox') {
                definition {
                  cps {
                    script("""\
                      pipeline {
                        agent any
                        triggers {
                          cron('H/15 * * * *')
                        }
                        stages {
                          stage ('prepare') {
                            steps {
                              git branch: 'main',
                              url: 'https://github.com/jakobyte1024/livehackingdemo-app.git'
                              sh "ls -lat"
                            }
                          }
                          stage ('run') {
                            steps {
                              echo "deploy debugbox"
                            }
                          }
                        }
                      }""".stripIndent())
                    }
                  }
                }
          - script: >
              pipelineJob('socialweb-api-infrastructure') {
                definition {
                  cps {
                    script("""\
                      pipeline {
                        agent any
                        triggers {
                          cron('H/15 * * * *')
                        }
                        stages {
                          stage ('prepare') {
                            steps {
                              git branch: 'main',
                              url: 'https://github.com/jakobyte1024/livehackingdemo-app.git'
                              sh "ls -lat"
                            }
                          }
                          stage ('run') {
                            steps {
                              echo "provisioning infrastructure"
                            }
                          }
                        }
                      }""".stripIndent())
                    }
                  }
                }
          - script: >
              pipelineJob('socialweb-api-databasebox') {
                definition {
                  cps {
                    script("""\
                      pipeline {
                        agent any
                        triggers {
                          cron('H/15 * * * *')
                        }
                        stages {
                          stage ('prepare') {
                            steps {
                              git branch: 'main',
                              url: 'https://github.com/jakobyte1024/livehackingdemo-app.git'
                              sh "ls -lat"
                            }
                          }
                          stage ('run') {
                            steps {
                              echo "create db box"
                            }
                          }
                        }
                      }""".stripIndent())
                    }
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

data "kubernetes_service_v1" "jenkinsService" {
  metadata {
    name = helm_release.jenkins.name
    namespace = helm_release.jenkins.namespace
  }

  depends_on = [
    helm_release.jenkins
  ]
}

resource "kubernetes_manifest" "jenkinsIngress" {
  manifest = {
    "apiVersion" = "networking.k8s.io/v1"
    "kind"       = "Ingress"
    "metadata" = {
      "name"      = "jenkins-ingress"
      "namespace" = "toolchain"

    }

    "spec" = {
      "ingressClassName" = "nginx"
      "rules" = [{
        "host" =  trimsuffix(google_dns_record_set.jenkins.name, ".")
        "http" = {
          "paths"  = [{
            "path" = "/"
            "pathType" = "Prefix"
            "backend" = {
              "service" = {
                "name" = data.kubernetes_service_v1.jenkinsService.metadata.0.name
                "port" = {
                  "number" = data.kubernetes_service_v1.jenkinsService.spec.0.port.0.port
                }
              }
            }


          }]
        }
      }]
    }
  }

  depends_on = [
    kubernetes_namespace.toolchainNamespace,
    google_dns_record_set.jenkins,
    helm_release.jenkins,
    data.kubernetes_service_v1.jenkinsService
  ]
}
