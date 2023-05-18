# Kubernetes Lookaround
Analyse what is running on `test` and `prod` clusters

## Connect to Kubernetes
Let's access K8s and then start some shells

```bash
gcloud container clusters get-credentials --region=europe-west3 conduit-k8s-prod
gcloud container clusters get-credentials --region=europe-west3 conduit-k8s-test

octant
```