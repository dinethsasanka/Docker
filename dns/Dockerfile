FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends bind9 bind9-utils dnsutils && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /etc/bind/zones /var/cache/bind /run/named && \
    chown -R bind:bind /var/cache/bind /run/named

COPY named.conf /etc/bind/named.conf
COPY db.csne2026.test /etc/bind/zones/db.csne2026.test

EXPOSE 53/udp 53/tcp

CMD ["named", "-g", "-u", "bind", "-c", "/etc/bind/named.conf"]
