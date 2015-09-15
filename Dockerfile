FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y --no-install-recommends tinyproxy

RUN mkdir /var/run/tinyproxy && \
    chown nobody /var/run/tinyproxy

RUN touch /var/log/tinyproxy/tinyproxy.log && \
    chown nobody /var/log/tinyproxy/tinyproxy.log

ADD start.sh /
RUN chown nobody /start.sh && chmod +x /start.sh

EXPOSE 8888

ENTRYPOINT [ "/start.sh" ]
