helm repo add jenkinscharts https://charts.jenkins.io
helm install conduit-jenkins jenkinscharts/jenkins -n conduit --set controller.tag="2.240-centos"
