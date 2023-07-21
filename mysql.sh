#!/bin/bash
sudo yum update
sudo yum install docker -y
sudo systemctl restart docker
sudo systemctl enable docker
sudo docker pull mysql
sudo docker run --name mysql1 -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=wordpressdb -p 3306:3306 -d mysql:5.7