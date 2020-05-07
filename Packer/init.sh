#!/bin/bash
installdependencies()
{
echo “Install script for Jenkins Server on Centos 7”;
echo “Installing Dependencies”;
yum install -y epel-release
firewall-cmd — add-port=8080/tcp — permanent — zone=public
firewall-cmd — reload
setenforce 0
sed -i ‘s/SELINUX=enforcing/SELINUX-disabled/g’ /etc/selinux/config
yum install -y wget
yum install -y java-1.8.0-openjdk-devel
}
installJenkins()
{
echo “Dependencies installed now Jenkins will be installed”
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
yum -y install jenkins
echo “starting and enabling jenkins”
service jenkins start
systemctl enable jenkins
}
installdependencies
installJenkins
echo “Jenkins installed now open your browser and navigate to http://your_ip_or_domain:8080”
cat /var/lib/jenkins/secrets/initialAdminPassword
echo “copy the initial password to unlock and start accessing jenkins”