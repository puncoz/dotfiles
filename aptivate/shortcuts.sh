#!/bin/bash

function sshv(){
  # An SSH that knows Aptivate DNS provider IPs
  # FIXME: Dynamically configure the DNS when in VPN
  IP=$(dig @ns1.linode.com "$1" +short)
  ssh lukem@"$IP"
}
