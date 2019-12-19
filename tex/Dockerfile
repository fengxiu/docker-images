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
RUN apt-get -y install --no-install-recommends texlive texlive-lang-chinese texlive-xetex 

# ## 解决perl: warning: Setting locale failed.
# RUN apt-get -y install --no-install-recommends language-pack-zh-hans
# ## 更新tlmgr
# RUN tlmgr update --all

# RUN apt-get -y install --no-install-recommends texlive-latex-base
# RUN apt-get -y install --no-install-recommends texlive-latex-extra texlive-xetex texlive-publishers


