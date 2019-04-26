FROM jupyter/base-notebook
USER root
RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list && \
    apt-get clean && \ 
    apt-get update 
RUN apt-get install -y software-properties-common &&\
    add-apt-repository ppa:longsleep/golang-backports &&\
    apt-get update && \
    apt-get install -y golang-go 
RUN apt-get install -y git libzmq3-dev
USER $NB_UID
RUN go get -u github.com/gopherdata/gophernotes 
RUN mkdir -p ~/.local/share/jupyter/kernels/gophernotes &&\
    cp $HOME/go/src/github.com/gopherdata/gophernotes/kernel/* ~/.local/share/jupyter/kernels/gophernotes
USER root
RUN ln -s $HOME/go/bin/gophernotes /usr/bin/gophernotes
USER $NB_UID