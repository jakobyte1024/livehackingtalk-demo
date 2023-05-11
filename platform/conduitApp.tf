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

resource "kubernetes_manifest" "psqlInitCredentials" {
  manifest = {
    "apiVersion" = "v1"
    "kind"       = "Secret"
    "type"       = "kubernetes.io/basic-auth"
    "metadata" = {
      "name"      = "database-initcreds"
      "namespace" = "conduit-app"
    }

    "data" = {
        "username" = "YXBw" # must be "app"
        "password" = "Y29uZHVpN0RhN2FiYXMzUHIwZFVTM3JQYVNTdzByZA=="
    }
  }
}

resource "kubernetes_manifest" "psqlCluster" {
  manifest = {
    "apiVersion" = "postgresql.cnpg.io/v1"
    "kind"       = "Cluster"
    "metadata" = {
      "name"      = "database"
      "namespace" = "conduit-app"
    }

    "spec" = {
      "instances" = "1"
      "primaryUpdateStrategy" = "unsupervised"
      
      "storage" = {
        "size" = "4Gi"
      }

      "bootstrap" = {
        "initdb" = {
            "database" = "app"
            "owner" = "app"
            "secret" = {
                "name" = "database-initcreds"
            }
        }
      }

       "backup" = {
            "barmanObjectStore" = {
                "googleCredentials" = {
                    "gkeEnvironment" = true
                }
            "destinationPath" = google_storage_bucket.databaseBackupBucket.url
           } 
        }

       "serviceAccountTemplate" = {
           "metadata" = {
                "annotations" = {
                    "iam.gke.io/gcp-service-account" = google_service_account.conduit.email
                }
           }
       }
    }
  }

  depends_on = [
    kubernetes_namespace.conduitApp,
    google_storage_bucket.databaseBackupBucket,
    kubernetes_manifest.psqlInitCredentials,
    kubernetes_manifest.psqlInitSuperuserCredentials
  ]
}

resource "kubernetes_manifest" "psqlClusterBackup" {
  manifest = {
    "apiVersion" = "postgresql.cnpg.io/v1"
    "kind"       = "ScheduledBackup"
    "metadata" = {
      "name"      = "database-backup"
      "namespace" = "conduit-app"
    }

    "spec" = {
      "schedule" = "0 0 0 * * *"
      "backupOwnerReference" = "self"
      "immediate" = "true"
      
      "cluster" = {
        "name" = "database"
      }
    }
  }

  depends_on = [
    kubernetes_manifest.psqlCluster,
    google_storage_bucket_iam_member.bindingPsqlBucket
  ]
}

resource "google_storage_bucket" "databaseBackupBucket" {
  name          = "conduit-database-backup-${var.environment}"
  location      = "EU"
  force_destroy = true

  uniform_bucket_level_access = true
}

resource "google_storage_bucket_iam_member" "bindingPsqlBucket" {
  bucket = google_storage_bucket.databaseBackupBucket.name
  role = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.conduit.email}"
}
   