FROM centos:7


# Install Python3.6.5 & pip & uwsgi
RUN yum update -y && yum install -y \
    gcc \
    make \
    zlib-devel \
    openssl-devel

WORKDIR /tmp
RUN curl -O https://www.python.org/ftp/python/3.6.5/Python-3.6.5.tar.xz && \
    tar Jxf Python-3.6.5.tar.xz
WORKDIR Python-3.6.5
RUN ./configure --prefix=/usr/local --with-ensurepip && \
    make && \
    make install && \
    pip3 install --upgrade pip && \
    pip install uwsgi


# Install nginx

# Add nginx repository and install
WORKDIR /tmp
RUN curl https://yoshiken.github.io/nginx.repo-api/centos.html > /etc/yum.repos.d/nginx.repo &&\
    yum install -y \
    nginx 

# Setting nginx
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
RUN usermod -u 1000 nginx
EXPOSE 80
COPY nginx/nginx-container.service /etc/systemd/system/redis-container.service
RUN systemctl enable nginx

COPY nginx/start.sh /tmp/start.sh
CMD /bin/sh /tmp/start.sh
