FROM ubuntu:16.04

## 设置ubuntu镜像源是阿里
RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list && \
    apt-get clean && \ 
    apt-get update 

# 安装openssh
RUN apt install -y openssh-server && \
    sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config 
# 需要使用下面指令启动sshd服务
# service ssh restart