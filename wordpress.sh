#!/bin/bash
sudo yum update -y 
sudo yum install docker -y
sudo systemctl restart docker
sudo systemctl enable docker
sudo docker pull wordpress
sudo docker run --name wordpress -p 80:80 -e WORDPRESS_DB_HOST=192.168.1.84 -e WORDPRESS_DB_USER=root -e WORDPRESS_DB_PASSWORD=root -e WORDPRESS_DB_NAME=wordpressdb -d wordpress


