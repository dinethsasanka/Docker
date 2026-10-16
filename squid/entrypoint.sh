#!/bin/sh
set -e

# remove a stale PID file left behind by an unclean stop
rm -f /run/squid.pid

if [ ! -d /var/spool/squid/00 ]; then
    squid -N -z -f /etc/squid/squid.conf
fi
exec squid -f /etc/squid/squid.conf -NYCd 1
