# Version: 0.0.1

FROM centos:7

MAINTAINER MNicholas "475807132@qq.com"

RUN apt-get update && apt-get install -y nginx

RUN echo 'Hi, I am in you container'  >/usr/share/nginx/html/index.html