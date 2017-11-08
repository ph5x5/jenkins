#!/bin/bash
echo "Jenkins Server Provisioning"

#Installing Java
echo "1.Installing prerequisites (JRE, JDK, Git, Environment)"
#JRE
yum -y install java
#JDK
wget -q --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
"http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.rpm"
yum -y install jdk-8u151-linux-x64.rpm
#Git
yum -y install git
#Environment
mkdir -p /opt/jenkins
mkdir /opt/jenkins/output
mkdir /opt/jenkins/backup

#Installing and running Jenkins
echo "2. Installing and running Jenkins"
#Jenkins itself
groupadd jenkins
useradd -g jenkins jenkins
wget -q "http://mirrors.jenkins.io/war-stable/latest/jenkins.war"
mv -f jenkins.war /opt/jenkins/jenkins.war
chown -R jenkins:jenkins /opt/jenkins
#Config restoration
#mkdir -p /home/jenkins/.jenkins
#cp -f /vagrant/jconf.tar.gz /home/jenkins/.jenkins/
#tar -zxvf /home/jenkins/.jenkins/jconf.tar.gz -C /home/jenkins/.jenkins/
#rm -f /home/jenkins/.jenkins/jconf.tar.gz
#chown -R jenkins:jenkins /home/jenkins
#Running Jenkins
su - jenkins -c "nohup bash -c 'java -jar /opt/jenkins/jenkins.war &' >> /opt/jenkins/jserver.log 2>&1 & < /dev/null"
#Scriptler download (commented because installed from backup)
#wget -q "https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/scriptler/2.9/scriptler-2.9.hpi"
#mv -f scriptler-2.9.hpi /vagrant/scriptler-2.9.hpi

#Installing and running Nginx
echo "3. Installing and running NginX"
yum -y install http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
yum -y install nginx
mkdir -p /etc/nginx/vhosts
cp -f /vagrant/nginx.conf /etc/nginx/nginx.conf
cp -f /vagrant/vhost.conf /etc/nginx/vhosts/vhost.conf
systemctl enable nginx
systemctl start nginx

#Installing debug tools
#echo "4. Installing debug tools (Net-Tools, Htop)"
#yum -y install net-tools htop
