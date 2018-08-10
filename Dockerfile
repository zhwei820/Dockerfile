FROM daocloud.io/library/python:3.6
RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

# 1. 安装基本依赖
RUN apt update -y && apt update -y && apt install wget unzip nginx supervisor -y
WORKDIR /opt/

# 2. 准备python

# 3. 下载包并解压
Add src/jumpserver /opt/jumpserver
Add src/coco /opt/coco
Add src/luna /opt/luna

# 4. 安装apt依赖
RUN apt -y install $(cat /opt/jumpserver/requirements/deb_requirements.txt) 
RUN apt -y install $(cat /opt/coco/requirements/deb_requirements.txt)

# 5. 安装pip依赖
RUN pip install -r /opt/jumpserver/requirements/requirements.txt  -i https://pypi.mirrors.ustc.edu.cn/simple
RUN pip install -r /opt/coco/requirements/requirements.txt  -i https://pypi.mirrors.ustc.edu.cn/simple

VOLUME /opt/coco/keys
VOLUME /opt/jumpserver/data

# 7. 准备文件
COPY nginx.conf /etc/nginx/nginx.conf
COPY supervisord.conf /etc/supervisord.conf
COPY jumpserver_conf.py /opt/jumpserver/config.py
COPY coco_conf.py /opt/coco/conf.py
COPY entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

ENV REDIS_HOST=127.0.0.1 REDIS_PORT=6379

EXPOSE 2222 80
# ENTRYPOINT ["entrypoint.sh"]
