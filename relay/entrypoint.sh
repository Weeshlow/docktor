#! /bin/sh
##
# FastRelay ported for Docker
# By LefsFlare / flare@torworld.org
##
# Parse arguments
##
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

if $SETCONFIG; then
    CONFIG="Nickname ${NICKNAME:-TorWorld}\n\
    DirPort ${DIRPORT:-80}\n\
    ORPort ${ORPORT:-443}\n\
    Exitpolicy reject *:*\n\
    ContactInfo ${CONTACTINFO:-none}\n\
    Exitpolicy reject *:*"
    echo -e "$CONFIG" >> /usr/local/etc/tor/torrc
fi

tor
