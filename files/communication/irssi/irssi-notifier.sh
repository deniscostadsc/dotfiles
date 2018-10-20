#!/bin/bash
beep

NLPID=$(pgrep -u $UID notify-listener)
if [ ! -z "$NLPID" ]; then
    DSBA=$(tr '\0' '\n' < "/proc/$NLPID/environ" | grep DBUS_SESSION_BUS_ADDRESS | cut -d '=' -f2-)
    DBUS_SESSION_BUS_ADDRESS=$DSBA exec "$@"
fi
