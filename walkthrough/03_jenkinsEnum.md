# Analyse Jenkins
This section aims to login to the company's Jenkins instance.
To do so, we'll prepare a list of usernames and check login with rockyou list.
Before login can be bruteforced, the login URL must be identified via BurpSuite.

## Enum Module
Let's get some details of Jenkins

```bash
msfconsole

use auxiliary/scanner/http/jenkins_enum
set RHOSTS jenkins.test.nevervictimconsult.xyz
set RPORT 80
set TARGETURI /
exploit
```
We detect that theres a pretty modern version of Jenkins running.
```bash
[+] 34.159.77.191:80    - Jenkins Version 2.387.3
[*] /script restricted (403)
[*] /view/All/newJob restricted (403)
[*] /asynchPeople/ restricted (403)
[*] /systemInfo restricted (403)
```
There are no easy-to-use exploits available for this version
```bash
searchsploit Jenkins 2.3
```
So there are at least two options left:
* attack the host
* get access to Jenkins
