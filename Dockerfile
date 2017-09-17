FROM ubuntu:xenial

RUN apt-get -y update \
&& apt-get -y install sudo curl software-properties-common python-software-properties \
&& curl http://nginx.org/keys/nginx_signing.key | apt-key add \
&& add-apt-repository "deb http://nginx.org/packages/mainline/ubuntu/ xenial nginx" \
&& apt-get -y update && apt-get -y dist-upgrade \
&& apt-get -y install unit \
&& useradd -m docker \
&& echo "docker:docker" | chpasswd && adduser docker sudo

EXPOSE 8000 8000

USER root

STOPSIGNAL SIGTERM

CMD ["/usr/sbin/unitd", "--no-daemon", "--control", "0.0.0.0:8000", "--pid", "/run/unitd.pid", "--log", "/var/log/unitd.log"]
