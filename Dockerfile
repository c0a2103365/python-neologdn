# 参考サイト
## https://qiita.com/Takayoshi_Makabe/items/18cefa4b4572d12b5aa9
## https://qiita.com/kado_u/items/e736600f8d295afb8bd9

FROM python:3.9

# mecabの導入
RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get install -y mecab && \
    apt-get install -y libmecab-dev && \
    apt-get install -y mecab-ipadic-utf8 && \
    apt-get install -y git && \
    apt-get install -y make && \
    apt-get install -y curl && \
    apt-get install -y xz-utils && \
    apt-get install -y file && \
    apt-get install -y sudo && \
    apt-get install -y swig && \
    apt-get install -y python3-pip

# mecab-ipadic-NEologdのインストール
RUN git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git && \
    cd mecab-ipadic-neologd && \
    ./bin/install-mecab-ipadic-neologd -n -y && \
    echo dicdir = `mecab-config --dicdir`"/mecab-ipadic-neologd">/etc/mecabrc && \
    sudo cp /etc/mecabrc /usr/local/etc && \
    cd

RUN mkdir workspace
WORKDIR /
COPY requirements.txt /

RUN pip install --upgrade pip --no-cache-dir && \
    pip install -r requirements.txt --no-cache-dir

WORKDIR /workspace