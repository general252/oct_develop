# Version: 0.0.1

FROM centos:7

MAINTAINER MNicholas "475807132@qq.com"

RUN yum update && yum install -y nginx

RUN echo 'Hi, I am in you container test'  >/usr/share/nginx/html/index.html
