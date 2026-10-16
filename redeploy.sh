#!/bin/bash
# Redeploy the lab services from Docker Hub images
set -e
DH_USER=cptsparrow2002
TAG=2026

# networks (created only if missing)
docker network inspect lab_macvlan >/dev/null 2>&1 || \
  docker network create -d macvlan --subnet=192.168.26.0/24 -o parent=enp0s8 lab_macvlan
docker network inspect upstream_net >/dev/null 2>&1 || \
  docker network create upstream_net

# DNS
docker run -d --name dns-server \
  --network lab_macvlan --ip 192.168.26.10 \
  --restart unless-stopped \
  $DH_USER/dns-server:$TAG

# DHCP
docker run -d --name dhcp-server \
  --network lab_macvlan --ip 192.168.26.5 \
  -v dhcp-leases:/var/lib/dhcp \
  --restart unless-stopped \
  $DH_USER/dhcp-server:$TAG

# Squid
docker run -d --name squid-proxy \
  --cpus=1 --memory=512m \
  --network name=lab_macvlan,ip=192.168.26.20 \
  --network name=upstream_net,gw-priority=100 \
  --restart unless-stopped \
  $DH_USER/squid-proxy:$TAG

