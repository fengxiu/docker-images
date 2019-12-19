# FROM ubuntu:18.04

# ## 设置ubuntu镜像源是阿里
# RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list && \
#     apt-get clean && \ 
#     apt-get update 

# # 安装openssh
# RUN apt install -y openssh-server && \
#     sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config 
# # 需要使用下面指令启动sshd服务
# # service ssh restart
# ARG USERNAME=tex
# ARG USER_UID=1000
# ARG USER_GID=$USER_UID
# ARG PASSWORD=123456
# ENV DEBIAN_FRONTEND=noninteractive

# RUN apt-get install -y sudo
# RUN useradd --create-home --no-log-init --shell /bin/bash $USERNAME
# ## sudo 不需要密码
# RUN echo "$USERNAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
# RUN echo "$USERNAME:$PASSWORD" | chpasswd
# USER $USERNAME
# WORKDIR /home/$USERNAME

# RUN wget https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz && \
#     tar -xzf install-tl-unx.tar.gz 
# RUN cd install-tl*  && \
#     sudo ./install-tl -no-gui -repository https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/tlnet/

# RUN echo 'export PATH=/usr/local/texlive/2019/bin/x86_64-linux:$PATH' >>/etc/profile &&\
#     echo 'export MANPATH=/usr/local/texlive/2019/texmf-dist/doc/man:$MANPATH' >>/etc/profile&&\
#     echo 'export INFOPATH=/usr/local/texlive/2019/texmf-dist/doc/info:$INFOPATH' >>/etc/profile

# RUN tex --version && tlmgr --version
# # RUN apt-get -y install --no-install-recommends texlive 
# # RUN apt-get -y install --no-install-recommends texlive-lang-chinese  
# # RUN apt-get -y install --no-install-recommends texlive-xetex 

# ## 解决perl: warning: Setting locale failed.
# # ENV LC_ALL=C
# # RUN apt-get install xzdec
# # RUN tlmgr option repository https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/tlnet
# # # RUN  tlmgr install framed
# # RUN tlmgr init-usertree
# # RUN tlmgr update  --usermode --self 
# # RUN tlmgr update --all


FROM debian:testing

ARG USER_NAME=latex
ARG USER_HOME=/home/latex
ARG USER_ID=1000
ARG USER_GECOS=LaTeX

RUN adduser \
    --home "$USER_HOME" \
    --uid $USER_ID \
    --gecos "$USER_GECOS" \
    --disabled-password \
    "$USER_NAME"

ARG WGET=wget
ARG GIT=git
ARG MAKE=make
ARG PANDOC=pandoc
ARG PCITEPROC=pandoc-citeproc
ARG PYGMENTS=python3-pygments
ARG FIG2DEV=fig2dev

RUN apt-get update -q && apt-get install -qy \
    # some auxiliary tools
    "$WGET" \
    "$GIT" \
    "$MAKE" \
    # markup format conversion tool
    "$PANDOC" \
    "$PCITEPROC" \
    # XFig utilities
    "$FIG2DEV" \
    # syntax highlighting package
    "$PYGMENTS" && \
    # Removing documentation packages *after* installing them is kind of hacky,
    # but it only adds some overhead while building the image.
    apt-get --purge remove -y .\*-doc$ && \
    # Remove more unnecessary stuff
    apt-get clean -y && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

# Install TexLive with scheme-basic

RUN wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz; \
    mkdir /install-tl-unx; \
    tar -xf install-tl-unx.tar.gz -C /install-tl-unx --strip-components=1; \
    echo "selected_scheme scheme-basic" >> /install-tl-unx/texlive.profile; \
    /install-tl-unx/install-tl -profile /install-tl-unx/texlive.profile; \
    rm -r /install-tl-unx; \
    rm install-tl-unx.tar.gz

ENV PATH="/usr/local/texlive/2019/bin/x86_64-linux:${PATH}"

ENV HOME /data

WORKDIR /data

# Install latex packages

RUN tlmgr update --self; \
    tlmgr install latexmk; \
    tlmgr update --all

VOLUME ["/data"]





