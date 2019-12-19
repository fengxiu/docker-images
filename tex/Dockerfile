FROM ubuntu:18.04

## 设置ubuntu镜像源是阿里
RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list && \
    apt-get clean && \ 
    apt-get update 

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

ENV HOME /home/latex

WORKDIR /home/latex/workdir

# Install latex packages
RUN tlmgr option repository https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/tlnet && \
    tlmgr update --self; \
    tlmgr install latexmk; \
    tlmgr install scheme-full;\
    tlmgr update --all

VOLUME ["/home/latex/workdir"]





