FROM buildpack-deps:jessie-scm

# 签名
MAINTAINER saymagic "zhuxiaole@zhuxiaole.org"

#安装ssh服务
# Install packages
RUN apt-get update && apt-get -y install openssh-server pwgen && \
    mkdir -p /var/run/sshd && \
    sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
    sed -i "s/PermitRootLogin without-password/PermitRootLogin yes/g" /etc/ssh/sshd_config

ADD set_ssh_pw.sh /set_ssh_pw.sh
ADD ss_start.sh /ss_start.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

ENV AUTHORIZED_KEYS **None**

RUN apt-get update && \
    apt-get install -y --force-yes -m python-pip python-m2crypto &&\
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip install shadowsocks

ENV SS_SERVER_ADDR 0.0.0.0
ENV SS_SERVER_PORT 8388
ENV SS_PASSWORD password
ENV SS_METHOD aes-256-cfb
ENV SS_TIMEOUT 300

EXPOSE $SS_SERVER_PORT
EXPOSE 22

CMD ["/run.sh"]