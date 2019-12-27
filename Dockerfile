From ubuntu:16.04

# The URL to download the MQ installer from in tar.gz format
# ARG MQ_URL=https://public.dhe.ibm.com/ibmdl/export/pub/software/websphere/messaging/mqadv/mqadv_dev904_ubuntu_x86-64.tar.gz
# Package from above MQ_URL was downloaded and unzipped to folder MQServer
# Yes, better is to ADD a tar.gz file to reduce the amount of bytes sent to docker deamon and time required to to ADD or . COPY the files
# Docker image.

ADD MQServer/ /tmp/mq/

RUN apt-get update -y \
&& apt-get install -y --no-install-recommends \
bash \
tar \
util-linux \
curl \
gcc \
rpm


RUN  cd tmp/mq \
  && ls \
  && ./mqlicense.sh -text_only -accept \
  && rpm -ivh --force-debian MQSeriesRuntime-*.rpm MQSeriesClient-*.rpm MQSeriesSDK-*.rpm

  RUN apt-get install -y software-properties-common \
    && apt-get update \
    && apt-get install -y python3 python3-dev \
    && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python3 get-pip.py \
    && pip install py3mqi
