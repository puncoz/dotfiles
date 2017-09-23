#!/bin/bash

function vpn(){
  # This function takes care of running an OpenVPN
  # connection, updating the resolv.conf and making
  # sure it gets reset correctly.

  RESOLV=/etc/resolv.conf
  TMP_RESOLV=/tmp/dnsresolv
  cat $RESOLV > $TMP_RESOLV

  sudo ip addr flush dev tun0

  BASE=$HOME/hacking/aptivate/vpn-stuff/lukem
  CONFIG=$BASE/aptivate.ovpn
  CA=$BASE/aptivate.ca.crt
  CERT=$BASE/lukem.crt
  KEY=$BASE/lukem.key
  AUTHKEY=$BASE/aptivate.ta.key

  sudo openvpn \
    --config "$CONFIG" \
    --ca "$CA" \
    --cert "$CERT" \
    --key "$KEY" \
    --tls-auth "$AUTHKEY"

  DIFF=$(diff $TMP_RESOLV $RESOLV)
  if [ "$DIFF" != "" ]
  then
    echo ""
    echo "-----------------------------------------"
    echo "The resolv.conf hasn't been changed back!"
    echo "-----------------------------------------"
    echo ""
  fi

  rm -rf $TMP_RESOLV
}
