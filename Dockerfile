## Ubuntu 16.04
FROM ubuntu:xenial

## Copy install file to docker image
COPY install.sh /tmp/
COPY run.sh /opt/
RUN bash /tmp/install.sh

## EXPOSE 8000 POR FOR EXTERNAL WEBSITE
EXPOSE 8000

## RUN SERVER
CMD bash /opt/run.sh
