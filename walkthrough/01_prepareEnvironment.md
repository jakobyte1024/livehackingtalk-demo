### Intro

## Prepare GCP

Terraform Service Account needs many permissions:

```
Roles:
* Editor
* Service Account Admin
* Project IAM Admin
```

Cloud Resource Manager API enabled

## Prepare Kali SSH

```bash
sudo docker exec -it kali-linux /bin/bash
```

```bash
apt install kubernetes-client
```
### Prepare Demo Workdir

```bash
mkdir -p /root/demotalk
cd /root/demotalk
```

### install google-cloud-sdk

```bash
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo tee /usr/share/keyrings/cloud.google.gpg

apt-get update && apt-get install google-cloud-cli google-cloud-sdk-gke-gcloud-auth-plugin
```

# Noch offen

Kali access ohne WebGui
Kali Deployment
Kali Info VNC

Jenkins Access Logs in Container Log bringen
