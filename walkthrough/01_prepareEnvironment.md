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

### install username-list-generator
```bash
cd /root/demotalk
git clone https://github.com/captain-noob/username-list-generator.git
```
### prepare wordlists
```bash
gzip -d /usr/share/wordlists/rockyou.txt.gz /usr/share/wordlists/

mkdir -p /root/demotalk/dnsEnum
cd /root/demotalk/dnsEnum
wget -O /usr/share/wordlists/subdomains-top1million-5000.txt https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/DNS/subdomains-top1million-5000.txt
```


### install google-cloud-sdk

```bash
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo tee /usr/share/keyrings/cloud.google.gpg

apt-get update && apt-get install google-cloud-cli google-cloud-sdk-gke-gcloud-auth-plugin
```


### ssh into Kali
```bash
gcloud compute ssh --zone "europe-west3-c" "tjpentest1-vm"
```
`CMD+i` to change color theme

# Noch offen
Jenkins Access Logs in Container Log bringen
login guesses deutlich schneller

# Valid environment names
* test
* staging
* preprod
