#!/usr/bin/with-contenv bashio

ulimit -n 1048576

until [ -e /var/run/avahi-daemon/socket ]; do
  sleep 1s
done

bashio::log.info "Preparing directories"

if [ ! -e /data/cups/cupsd.conf ]; then
    cp -v -R /etc/cups /data
    bashio::log.info "File cupsd.conf not exist"  
fi 

rm -v -fR /etc/cups

ln -v -s /data/cups /etc/cups

bashio::log.info "Starting CUPS server as CMD from S6"

cupsd -f
