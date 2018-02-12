FROM eugenes1/python-sshd  

MAINTAINER yamasakih

RUN apk update && \
    apk --no-cache add bash ca-certificates wget libxext libxrender libstdc++ && \
    update-ca-certificates && \
    apk --update add tzdata && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    apk del tzdata

RUN echo 'export PATH=/opt/anaconda/bin:$PATH' > /etc/profile.d/anaconda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/anaconda && \
    rm ~/anaconda.sh

ENV PATH /opt/anaconda/bin:$PATH

RUN conda install -y -c rdkit rdkit 

EXPOSE 22
