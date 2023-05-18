# Pepare Environments
This document covers some manual steps that are needed to use this walkthrough.

## Backlog
* Access Logs must be showed in it's Container Logs.
* Jenkins_Enum login guesses too slow

## Valid environment names
Environments can be created via GitHub Actions pipeline or each step's [runLocally.sh](../platform/step1/runLocally.sh)
To ensure that the [gettingKnow](./02_gettingKnow.md) works, environments must have names that match the wordlist.
Valid names are for example:
* test
* staging
* preprod

## Prepare GCP

Terraform Service Account needs many permissions:

```
Roles:
* Editor
* Service Account Admin
* Project IAM Admin
```

[Cloud Resource Manager API](https://cloud.google.com/resource-manager/reference/rest) must be enabled to create `ServiceAccounts` proper rights in the setup.

## Prepare Kali VM
The Kali VM is used by the presenter.
It is not created via Terraform / Pipeline and must be deployed manually.
[Techlatest.net Kali Linux](https://console.cloud.google.com/compute/instancesAdd(cameo:product/techlatest-public/kali-linux-browser)) offers also HTTP VNC viewer.

[https://34.159.122.141/vnc.html](https://34.159.122.141/vnc.html) for example opens VNC.

Once logged in, you can change the password via
```bash
x11vnc -storepasswd
```
See [documentation](https://www.techlatest.net/support/kali_linux_browser_support/gcp_gettingstartedguide/index.html) for details.

### Run terminal Kali SSH
All commands in this walkthrough must be made directly into Kali container.
Open it via

```bash
sudo docker exec -it kali-linux /bin/bash
```

### Prepare Demo Workdir
Setting up demo's base dir

```bash
mkdir -p /root/demotalk
cd /root/demotalk
```

### install username-list-generator
Usernamelist generator is used during walkthrough.

```bash
cd /root/demotalk
git clone https://github.com/captain-noob/username-list-generator.git
```

### prepare wordlists
Rockyou-list and top1million wordlist are used and must be prepared.

```bash
gzip -d /usr/share/wordlists/rockyou.txt.gz /usr/share/wordlists/

mkdir -p /root/demotalk/dnsEnum
cd /root/demotalk/dnsEnum

wget -O /usr/share/wordlists/subdomains-top1million-5000.txt https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/DNS/subdomains-top1million-5000.txt
```

### install google-cloud-sdk
To gain cloud access, GCP SDK is needed.

```bash
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo tee /usr/share/keyrings/cloud.google.gpg

apt-get update && apt-get install google-cloud-cli google-cloud-sdk-gke-gcloud-auth-plugin
```

### Install Kubernetes Tools
Using K8s needs the client.

```bash
apt install kubernetes-client
```

Octant will be used to show details of the running architecture.

```bash
wget https://github.com/vmware-archive/octant/releases/download/v0.25.1/octant_0.25.1_Linux-64bit.deb

sudo dpkg -i octant_0.25.1_Linux-64bit.deb
```

## Prepare toolings
Some tools of the architecture must be prepared manually.

### prepare Jenkins
* start Jobs before the demo in order to get a job history
* remember the Script Approvals

### Run conduit-backend-setup
To generate data for database exfiltration, conduit-backend can be stressed.
Use appData script to do so.

[appData](../setup/1_appData.sh)


## Presenter tips
### ssh into Kali
```bash
gcloud compute ssh --zone "europe-west3-c" "tjpentest1-vm"
```
`CMD+i` to change color theme