# ************************************** 
#
# OMO Proxy
#
# ENV: DEV
# VERSION: 1.0.0
#
# *************************************

FROM alpine:3.5

MAINTAINER Easlee Liu "liu@easlee.me"

ENV container docker

VOLUME /root
EXPOSE 22
EXPOSE 80
EXPOSE 443

###############################
# install applications
###############################
RUN apk add --no-cache openssh
RUN apk add --no-cache nginx

###############################
# generate ssh key
###############################
RUN ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key

###############################
# allow root login
###############################
RUN sed -i 's/#PermitRootLogin[ ]prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN mkdir -p /omo

COPY ./dep/entry.sh /usr/local/bin/
COPY ./dep/init.sh /root/.init.sh
COPY ./dep/startup.sh /root/.startup.sh
COPY ./dep/passwd /root/
COPY ./dep/nginx.conf /root/
COPY ./dep/ssl.crt /root/
COPY ./dep/ssl.csr /root/
COPY ./dep/ssl.key /root/
COPY ./dep/ssl.pfx /root/

ENTRYPOINT ["entry.sh"]
