FROM frolvlad/alpine-glibc

MAINTAINER yamasakih

ENV PATH=/opt/anaconda/bin:$PATH \
    TZ=Asia/Tokyo \
    ROOT_PASSWORD=root

RUN apk --no-cache --update add bash ca-certificates wget libxext libxrender libstdc++ \
    openssh supervisor && \
    update-ca-certificates && \
    apk --update add tzdata && \
    cp /usr/share/zoneinfo/$TZ /etc/localtime && \
    apk del tzdata

RUN echo 'export PATH=/opt/anaconda/bin:$PATH' > /etc/profile.d/anaconda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/anaconda && \
    rm ~/anaconda.sh

RUN conda install -y -c rdkit rdkit 

RUN echo -e "https://mirror.tuna.tsinghua.edu.cn/alpine/latest-stable/main\n" > /etc/apk/repositories

RUN sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
	&& echo "root:${ROOT_PASSWORD}" | chpasswd \
	&& mkdir -p /var/logs/supervisor \
	&& mkdir -p /var/run/supervisor \
	&& rm -rf /var/cache/apk/* /tmp/*

RUN ssh-keygen -A

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]


