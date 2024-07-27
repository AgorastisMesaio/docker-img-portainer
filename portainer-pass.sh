#!/usr/bin/env bash
# Simple script to create the initial admin's password for Portainer
#

if [ -z "$1" ]; then
    echo -e "\nPlease call '$0 <password>' to run this command!\n"
    exit 1
fi

htpasswd -nb -B admin $1 | cut -d ":" -f 2

