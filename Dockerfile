# Ubuntu20.04(focal)
# Dockerhubで一番上にあったものをコピペしたもの。よりよいものがある可能性はある。
FROM nvidia/cuda:11.3.1-devel-ubuntu20.04

#いらない?
USER root

RUN apt-get update \
  && apt-get -y upgrade

#init, openssh-serverのインストール時にタイムゾーンを効かれないためのコピー
COPY ./configure/timezoneconf /etc/localtime

RUN apt-get install -y vim init openssh-server git
RUN apt-get install -y python3 python3-pip
RUN pip3 install torch torchvision

RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
 
RUN sed -i 's/#Port 22/Port 8888/' /etc/ssh/sshd_config

ENTRYPOINT [ "/usr/sbin/sshd", "-D" ]

COPY ./configure/id_rsa.pub /root/.ssh/authorized_keys
COPY ./configure/key /key

EXPOSE 8888
