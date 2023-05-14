FROM jenkins/jenkins:2.137
USER root
#RUN apt-get update
#RUN apt-get install -y --allow-unauthenticated ldap-utils curl wget vim nano sudo git
RUN adduser jenkins sudo
User jenkins

ENV CURL_OPTIONS --insecure
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
COPY plugins.sh /usr/local/bin/plugins.sh
COPY install-plugins.sh /usr/local/bin/install-plugins.sh
RUN  /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

RUN echo 2.137 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
RUN echo 2.137 > /usr/share/jenkins/ref/jenkins.install.InstallUtil.lastExecVersion
EXPOSE 8080