# Gain data
We want to get some more information about nevervictim's structure.

## DNS Enumeration
We already know the company's domain. Let's analyse it.

### Basic Enumeration

```bash
dnsenum nevervictimconsult.xyz
```
shows
```
Name Servers:
______________

ns-cloud-a3.googledomains.com.           4283     IN    A        216.239.36.106

Trying Zone Transfer for nevervictimconsult.xyz on ns-cloud-a3.googledomains.com ... 
AXFR record query failed: REFUSED
```

### Brute Force DNS Enumeration

We now know, that the domain and the company is using Google Cloud Platform.
Unfortunately, GCP Cloud DNS does not allow DNS zone transfers.
So we need to brute force to gain more information.
To do so, we use a nice wordlist with often used domain names (around 5000 names)

```bash
dnsrecon -t brt -d nevervictimconsult.xyz --threads 25 -D /usr/share/wordlists/subdomains-top1million-5000.txt

```

We see, there are at least 17 records. 
A bit of interpretation shows that there are something like stages.
One may be called "test".
Let's check that by enumerating the subdomain.

```bash
dnsrecon -t brt -d test.nevervictimconsult.xyz --threads 25 -D /usr/share/wordlists/subdomains-top1million-5000.txt
```

There's more!
We found that there may be a Jenkins instance.

```bash
[+]      A jenkins.test.nevervictimconsult.xyz 34.159.77.191
[+] 15 Records Found
```