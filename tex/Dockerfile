FROM ubuntu:18.04

## 设置ubuntu镜像源是阿里
RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list && \
    apt-get clean && \ 
    apt-get update 

# 安装openssh
RUN apt install -y openssh-server && \
    sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config 
# 需要使用下面指令启动sshd服务
# service ssh restart

ARG USERNAME=tex
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG PASSWORD=123456
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get install -y sudo
RUN useradd --create-home --no-log-init --shell /bin/bash $USERNAME
## sudo 不需要密码
RUN echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN echo "$USERNAME:$PASSWORD" | chpasswd
USER $USERNAME
WORKDIR /home/$USERNAME


RUN wget https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    tar -xzf install-tl-unx.tar.gz && cd install-tl* && \
    sudo ./install-tl -repository https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/tlnet/

RUN echo 'export PATH=/usr/local/texlive/2019/bin/x86_64-linux:$PATH' >>~/.bashrc &&\
    echo 'export MANPATH=/usr/local/texlive/2019/texmf-dist/doc/man:$MANPATH' >> ~/.bashrc &&\
    echo 'export INFOPATH=/usr/local/texlive/2019/texmf-dist/doc/info:$INFOPATH' >> ~/.bashrc

RUN tex --version && tlmgr --version
# RUN apt-get -y install --no-install-recommends texlive 
# RUN apt-get -y install --no-install-recommends texlive-lang-chinese  
# RUN apt-get -y install --no-install-recommends texlive-xetex 

## 解决perl: warning: Setting locale failed.
# ENV LC_ALL=C
# RUN apt-get install xzdec
# RUN tlmgr option repository https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/tlnet
# # RUN  tlmgr install framed
# RUN tlmgr init-usertree
# RUN tlmgr update  --usermode --self 
# RUN tlmgr update --all





