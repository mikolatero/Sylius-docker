## Ubuntu 16.04
FROM ubuntu:xenial

## Copy install file to docker image
COPY install.sh /tmp/
RUN bash /tmp/install.sh

## EXPOSE 8000 POR FOR EXTERNAL WEBSITE
EXPOSE 8000

## RUN SERVER
CMD php /opt/sylius/app/console server:run 0.0.0.0:8000
