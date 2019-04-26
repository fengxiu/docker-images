#!/bin/bash
# 构建脚本
echo $#
if [ $# -lt 2 ]
then
    echo "输入命令如下: build.sh imageName version"
    exit 0
fi
imageName=$1
version=$2
docker build -f $imageName/Dockerfile -t $imageName . && \

## 登陆阿里云镜像
docker login --username=398757724@qq.com -p=zhangke19940617 registry.cn-hangzhou.aliyuncs.com  &&\
# ## 拉取镜像
# docker pull registry.cn-hangzhou.aliyuncs.com/fengxiu/jupyter

## 标记镜像
docker tag $imageName registry.cn-hangzhou.aliyuncs.com/fengxiu/$imageName && \
docker push registry.cn-hangzhou.aliyuncs.com/fengxiu/$imageName

# 标记为latest
docker tag $imageName registry.cn-hangzhou.aliyuncs.com/fengxiu/$imageName && \
docker push registry.cn-hangzhou.aliyuncs.com/fengxiu/$imageName
