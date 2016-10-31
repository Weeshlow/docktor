#!/bin/bash -
#===============================================================================================================================================
# (C) Copyright 2016 TorWorld (https://torworld.org) a project under the CryptoWorld Foundation (https://cryptoworld.is).
#
# Licensed under the GNU GENERAL PUBLIC LICENSE, Version 3.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.gnu.org/licenses/gpl-3.0.en.html
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#===============================================================================================================================================
# title            :Docker port FastRelay
# description      :This script will make it super easy to run a Tor Relay Node on Docker.
# author           :TorWorld A Project Under The CryptoWorld Foundation.
# contributors     :LefsFlare
# date             :10-31-2016
# version          :0.0.1 Alpha
# os               :Docker
# usage            :docker run -it --rm -p 80:80 -p 9030:9030 -p 9001:9001 torworld/fastexit -c "abuse [AT] yoursite.com" -d 9030 -o 9001 -n Exitname
# notes            :If you have any problems feel free to email us: security[at]torworld.org
#===============================================================================================================================================

if [[ "$#" -gt 1 ]]; then
    SETCONFIG=true
else
    SETCONFIG=false
fi

while [[ "$#" -gt 1 ]]; do
    argument="$1"

    case $argument in
        -n|--nickname)
            NICKNAME="$2"
            echo "Setting nickname to $NICKNAME"
            shift
            ;;
        -d|--dirport)
            DIRPORT="$2"
            echo "Setting DIRPORT to $DIRPORT"
            shift
            ;;
        -o|--orport)
            ORPORT="$2"
            echo "SETTING ORPORT to $ORPORT"
            shift
            ;;
        -c|--contact)
            CONTACT="$2"
            echo "SETTING CONTACT TO $CONTACT"
            shift
            ;;
        *)
            shift
            ;;
    esac
done

# Write configuration into configuration file
CONFIG="Nickname ${NICKNAME:-TorWorld}\n\
ORPort ${ORPORT:-9001}\n\
DirPort ${DIRPORT:-9030}\n\
ContactInfo ${CONTACTINFO:-none}\n"
echo -e "$CONFIG" | tee -a /usr/local/etc/tor/torrc

# Advanced ExitPolicy Tor Exit Setup
curl -s 'https://raw.githubusercontent.com/torworld/fastexit/master/exitpolicy.txt' | tee -a /usr/local/etc/tor/torrc

# Tor Exit html page
curl -s4L 'https://github.com/torworld/fastexit-website-template/archive/master.zip' -o master.zip
unzip master.zip
mv fastexit-website-template-master/* /var/lib/nginx/html/

# Overwrite original script file to prevent duplicate configuration
echo -e "#! /usr/bin/sh\n\
##\n\
nginx -g 'pid /nginx.pid; daemon off;' &\n\
tor\n" > $0

nginx -g 'pid /nginx.pid; daemon off;' &
tor
