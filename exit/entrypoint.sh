#!/bin/bash -
#===============================================================================================================================================
# (C) Copyright 2016 TorWorld (https://torworld.org) a project under the CryptoWorld Foundation (https://cryptoworld.is).
#
# Licensed under the GNU AFFERO GENERAL PUBLIC LICENSE, Version 3 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.gnu.org/licenses/agpl-3.0.en.html
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
# date             :11-6-2016
# version          :0.0.2 Alpha
# os               :Docker
# usage            :docker run -dt —name fastexit -p 80:80 -p 9030:9030 -p 9001:9001 torworld/fastexit -c "abuse [AT] yoursite.com" -d 9030 -o 9001 -n Exitname
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
cat <<-EOF | tee -a /usr/local/etc/tor/torrc
Nickname ${NICKNAME:-TorWorld}
ORPort ${ORPORT:-9001}
DirPort ${DIRPORT:-9030}
ContactInfo ${CONTACTINFO:-none}
EOF

# Overwrite original script file to prevent duplicate configuration
cat <<-EOF > $0
#! /bin/sh
##
nginx -g 'pid /nginx.pid; daemon off;' &
tor
EOF

nginx -g 'pid /nginx.pid; daemon off;' &
tor
