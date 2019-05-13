FROM jupyter/base-notebook
USER root
## 设置ubuntu镜像源是阿里
RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list && \
    apt-get clean && \ 
    apt-get update 
## 安装go
RUN apt-get install -y software-properties-common &&\
    add-apt-repository ppa:longsleep/golang-backports &&\
    apt-get update && \
    apt-get install -y golang-go 
## 安装go环境的依赖
RUN apt-get install -y git libzmq3-dev
USER $NB_UID
## 设置jupyter 中的go环境
RUN go get -u github.com/gopherdata/gophernotes 
RUN mkdir -p ~/.local/share/jupyter/kernels/gophernotes &&\
    cp $HOME/go/src/github.com/gopherdata/gophernotes/kernel/* ~/.local/share/jupyter/kernels/gophernotes
USER root
## 全局加上ggophernotes命令
RUN ln -s $HOME/go/bin/gophernotes /usr/bin/gophernotes
USER $NB_UID
## 设置pip镜像源是阿里源
RUN mkdir $HOME/.pip
COPY ./.pip $HOME/.pip
## 配置jupyter扩展
RUN pip install jupyter_contrib_nbextensions && \
    jupyter contrib nbextension install --user &&\
    pip install jupyter_nbextensions_configurator && \
    jupyter nbextensions_configurator enable --user 
## 设置jupyter
RUN rm -rf $HOME/.jupyter && mkdir $HOME/.jupyter
COPY .jupyter $HOME/.jupyter 