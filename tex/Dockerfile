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
RUN apt-get -y install --no-install-recommends texlive 
# RUN apt-get -y install --no-install-recommends texlive-lang-chinese  
# RUN apt-get -y install --no-install-recommends texlive-xetex 

## 解决perl: warning: Setting locale failed.
ENV LC_ALL=C
RUN apt-get install xzdec
# RUN  tlmgr install framed
RUN tlmgr init-usertree
RUN tlmgr update  --usermode --self 
# RUN tlmgr update --all




ARG USERNAME=tex
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG PASSWORD=123456
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get install -y sudo
RUN useradd --create-home --no-log-init --shell /bin/bash $USERNAME
RUN adduser $USERNAME sudo 
RUN echo "$USERNAME:$PASSWORD" | chpasswd
USER $USERNAME
WORKDIR /home/$USERNAME


#     && echo node ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
#     && chmod 0440 /etc/sudoers.d/$USERNAME


# ## 更新tlmgr
# RUN tlmgr update --all

# RUN apt-get -y install --no-install-recommends texlive-latex-base
# RUN apt-get -y install --no-install-recommends texlive-latex-extra texlive-xetex texlive-publishers


