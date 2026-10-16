FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends squid && \
    rm -rf /var/lib/apt/lists/*

COPY squid.conf /etc/squid/squid.conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh && \
    mkdir -p /var/spool/squid /var/log/squid && \
    chown -R proxy:proxy /var/spool/squid /var/log/squid

EXPOSE 3128

ENTRYPOINT ["/entrypoint.sh"]
