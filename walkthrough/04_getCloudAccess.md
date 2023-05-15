# Get Cloud Access
Now that we're in Jenkins, we'll look a bit around

## Secrets
There are predefined secrets.
Some maybe used for Terraform
Lets decrypt them
Open 
```
    http://jenkins.test.nevervictimconsult.xyz:8080/script
```
and start following script
```java
println( hudson.util.Secret.decrypt("${ENCRYPTED_PASSPHRASE_OR_PASSWORD}") )
```
where `${ENCRYPTED_PASSPHRASE_OR_PASSWORD}` is the encrypted content of the `<password>` or `<passphrase>` XML element that you are looking for.
And in order to get the password value of `${ENCRYPTED_PASSPHRASE_OR_PASSWORD}` go to credentials, update, in the browser "See source code" and you will get the encrypted password in the data field for password. Then use that function.
