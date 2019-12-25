FROM ubuntu:18.04

## 设置ubuntu镜像源是阿里
RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list && \
    apt-get clean && \ 
    apt-get update -q
 
# ARG USER_NAME=latex
# ARG USER_HOME=/home/latex
# ARG USER_ID=1000
# ARG USER_GECOS=LaTeX

# RUN adduser \
#     --home "$USER_HOME" \
#     --uid $USER_ID \
#     --gecos "$USER_GECOS" \
#     --disabled-password \
#     "$USER_NAME"

# ## 安装工具
# ARG WGET=wget
# ARG GIT=git
# ARG MAKE=make
# ARG PANDOC=pandoc
# ARG PCITEPROC=pandoc-citeproc
# ARG PYGMENTS=python3-pygments
# ARG FIG2DEV=fig2dev

# RUN  apt-get install -qy \
#     # some auxiliary tools
#     "$WGET" \
#     "$GIT" \
#     "$MAKE" \
#     # markup format conversion tool
#     "$PANDOC" \
#     "$PCITEPROC" \
#     # XFig utilities
#     "$FIG2DEV" \
#     # syntax highlighting package
#     "$PYGMENTS" && \
#     # Removing documentation packages *after* installing them is kind of hacky,
#     # but it only adds some overhead while building the image.
#     apt-get --purge remove -y .\*-doc$ && \
#     # Remove more unnecessary stuff
#     apt-get clean -y && \
#     apt-get autoremove && \
#     rm -rf /var/lib/apt/lists/*

# # Install TexLive with scheme-basic
# RUN wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz; \
#     mkdir /install-tl-unx; \
#     tar -xf install-tl-unx.tar.gz -C /install-tl-unx --strip-components=1; \
#     echo "selected_scheme scheme-basic" >> /install-tl-unx/texlive.profile; \
#     /install-tl-unx/install-tl -profile /install-tl-unx/texlive.profile \
#     --location https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/tlnet ; \
#     rm -r /install-tl-unx; \
#     rm install-tl-unx.tar.gz



# ENV PATH="/usr/local/texlive/2019/bin/x86_64-linux:${PATH}"
# ENV MANPATH=/usr/local/texlive/2019/texmf-dist/doc/man:$MANPATH
# ENV INFOPATH=/usr/local/texlive/2019/texmf-dist/doc/info:$INFOPATH



# ENV LC_ALL=C
# ENV HOME=${USER_HOME}

# RUN apt-get install sudo &&\
#    echo "latex ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
# USER latex

# # Install latex packages
# # RUN  tlmgr init-usertree && tlmgr option repository https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/tlnet &&\
# #      tlmgr update --self && \
# #     tlmgr install latexmk  collection-xetex && \
# #     tlmgr update --all
# RUN  sudo tlmgr init-usertree && tlmgr option repository https://mirrors.tuna.tsinghua.edu.cn/CTAN/systems/texlive/tlnet &&\
#      sudo tlmgr update --self && \
#     sudo tlmgr install latexmk  collection-xetex && \
#     sudo tlmgr update --all

# WORKDIR /home/latex/workdir
# VOLUME ["/home/latex/workdir"]





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
ENV MANPATH="/usr/local/texlive/2019/texmf-dist/doc/man:$MANPATH"
ENV INFOPATH="/usr/local/texlive/2019/texmf-dist/doc/info:$INFOPATH"
RUN apt-get update && apt-get install sudo &&\
     echo "latex ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

ENV LC_ALL=C
ENV HOME /home/latex
WORKDIR /home/latex


# Install latex packages
RUN  tlmgr update --self &&  \
    tlmgr install latexmk collection-xetex &&  \
    ## 更新宏包索引
    texhash && mktexlsr

## 安装windows字体 
RUN apt-get install -qy fontconfig unzip
RUN wget https://github.com/fengxiutianya/font/archive/master.zip && \
    ls -al && unzip master.zip &&ls -al|| cd master &&\
    mkdir -p /usr/share/fonts/windows && mv windows /usr/lshare/fonts/windows &&\
    fc-cache -fv


## 安装中文环境
# collection-latexrecommended collection-latexextra
VOLUME ["/home/latex"]
