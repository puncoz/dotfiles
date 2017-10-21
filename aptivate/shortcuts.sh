#!/bin/bash

BASE="$HOME/hacking/aptivate"
PROJECTBASE="$BASE/projects"

##############################################################################
# APTIVATE
##############################################################################
function vpn(){
  # This function takes care of running an OpenVPN
  # connection, updating the resolv.conf and making
  # sure it gets reset correctly.

  RESOLV=/etc/resolv.conf
  TMP_RESOLV=/tmp/dnsresolv
  cat $RESOLV > $TMP_RESOLV

  sudo ip addr flush dev tun0

  VPNBASE=$BASE/vpn-stuff/lukem
  CONFIG=$VPNBASE/aptivate.ovpn
  CA=$VPNBASE/aptivate.ca.crt
  CERT=$VPNBASE/lukem.crt
  KEY=$VPNBASE/lukem.key
  AUTHKEY=$VPNBASE/aptivate.ta.key

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

function aptivatesshmonitor(){
  ssh lin-monitor.aptivate.org
}

function aptivatesshweb(){
  ssh lin-aptivateweb.aptivate.org
}

##############################################################################

##############################################################################
# PULA PHONES
##############################################################################
DEPLOYFAB="$PROJECTBASE/PULA/pulaphones/deploy/fab.py"

function pulasshmalawi(){
  ssh lin-pulaphones-malawi.aptivate.org
}

function pulasshzambia(){
  ssh lin-pulaphones-zambia.aptivate.org
}

function pulasshstage(){
  ssh fen-vz-pulaphones-stage.fen.aptivate.org
}

function puladeploymalawi(){
  python "$DEPLOYFAB" malawi deploy
}

function puladeploystage(){
  python "$DEPLOYFAB" staging deploy
}

function puladeployzambia(){
  python "$DEPLOYFAB" zambia deploy
}
##############################################################################
