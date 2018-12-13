# version: 0.0.1

FROM centos:7

RUN cd /home \
    && echo root:"123456" | chpasswd \
    && \
    && yum install -y openssh-server \
    && ssh-keygen -q -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N '' \
    && ssh-keygen -q -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N '' \
    && ssh-keygen -t dsa -f /etc/ssh/ssh_host_ed25519_key -N '' \
    && \
    && yum -y install gcc \
    && yum -y install gcc-c++ \
    && yum -y install gdb-gdbserver \
    && yum -y groupinstall development \
    && \
    && yum -y install zlib-devel zlib \
    && yum -y install openssl openssl-devel \
    && yum -y install wget \
    && yum -y install autoconf automake libtool \
    && \
    && yum clean all \
    && rm -rf /var/cache/yum

RUN wget https://github.com/libuv/libuv/archive/v1.23.2.tar.gz \
    && tar zxf v1.23.2.tar.gz \
    && cd libuv-1.23.2 \
    && sh autogen.sh \
    && ./configure \
    && make -j4 \
    && make check \
    && make install \
    && cd .. \
    && rm -rf libuv-1.23.2 \
    && rm -f v1.23.2.tar.gz \
    && \
    && wget https://github.com/zeromq/libzmq/archive/v4.2.5.tar.gz \
    && tar zxf v4.2.5.tar.gz \
    && cd libzmq-4.2.5 \
    && sh autogen.sh \
    && ./configure \
    && make -j4 \
    && make install \
    && cd .. \
    && rm -rf libzmq-4.2.5 \
    && rm -f libzmq-4.2.5 \
    && \
    && openssl genrsa -out server_key.pem 2048 \
    && openssl req -new -x509 -key key.pem -out server_cert.pem -days 36500 \
    && \
    && yum clean all \
    && rm -rf /var/cache/yum

WORKDIR /home

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
