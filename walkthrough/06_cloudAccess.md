# Cloud Access
With the revealed secret, we can login to GCP

### Login to GCP
Use `gcloud` to authenticate via json File.

```bash
cd /root/demotalk/cloudAccess
gcloud auth activate-service-account --key-file=gcpSa.json
gcloud init --console-only
```

* use jenkins account
* project name thorsten-jakoby-tj-projekt

### Take a look around

```bash
gcloud container clusters list
gcloud storage buckets list
```

Found interesting things: `conduit-database-backup-test` or `conduit-k8s-prod`.