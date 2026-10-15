FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends isc-dhcp-server && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/lib/dhcp && \
    touch /var/lib/dhcp/dhcpd.leases

COPY dhcpd.conf /etc/dhcp/dhcpd.conf

EXPOSE 67/udp

CMD ["dhcpd", "-4", "-f", "-d", "-cf", "/etc/dhcp/dhcpd.conf", "-lf", "/var/lib/dhcp/dhcpd.leases", "eth0"]
