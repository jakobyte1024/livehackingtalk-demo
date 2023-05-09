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

resource "kubernetes_manifest" "psqlCluster" {
  manifest = {
    "apiVersion" = "postgresql.cnpg.io/v1"
    "kind"       = "Cluster"
    "metadata" = {
      "name"      = "database"
      "namespace" = "conduit-app"
    }

    "spec" = {
      "instances" = "2"
      "primaryUpdateStrategy" = "supervised"
      
      "storage" = {
        "size" = "4Gi"
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
    google_storage_bucket.databaseBackupBucket
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

# resource "google_storage_bucket_iam_binding" "bindingPsqlBucket" {
#   bucket = google_storage_bucket.databaseBackupBucket.name
#   role = "roles/storage.objectCreator"
#   members = [
#     "serviceAccount:${google_service_account.conduit.email}"
#   ]
# }

resource "google_storage_bucket_iam_member" "bindingPsqlBucket" {
  bucket = google_storage_bucket.databaseBackupBucket.name
  role = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.conduit.email}"
}
