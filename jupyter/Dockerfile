FROM jupyter/base-notebook
USER root
## 设置ubuntu镜像源是阿里
RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list && \
    apt-get clean && \ 
    apt-get update 
RUN apt install -y openssh-server && \
    sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config 
## 修改用户名密码
RUN echo "${NB_USER}:19940617" | chpasswd
# RUN echo "root:19940617" | chpasswd
# ## 安装go
# RUN apt-get install -y software-properties-common &&\
#     add-apt-repository ppa:longsleep/golang-backports &&\
#     apt-get update && \
#     apt-get install -y golang-go 
# ## 安装go环境的依赖
# RUN apt-get install -y git libzmq3-dev
# USER $NB_UID
# ## 设置jupyter 中的go环境
# RUN go get -u github.com/gopherdata/gophernotes 
# RUN mkdir -p ~/.local/share/jupyter/kernels/gophernotes &&\
#     cp $HOME/go/src/github.com/gopherdata/gophernotes/kernel/* ~/.local/share/jupyter/kernels/gophernotes
# USER root
# ## 全局加上ggophernotes命令
# RUN ln -s $HOME/go/bin/gophernotes /usr/bin/gophernotes



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
COPY ./start/ssh.sh /usr/local/bin/start-notebook.d/ssh.sh


## 修改用户名密码
# echo "用户名：密码" | chpasswd