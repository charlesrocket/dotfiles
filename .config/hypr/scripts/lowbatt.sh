#!/bin/sh

L2=30
L1=10

notifyStart() {
    NOTIFY=true
}

checkStatus() {
    POWER=$(apm -a)

    if [ "$POWER" -eq 0 ]
    then
        NOTIFY=true
    else
        NOTIFY=false
    fi
}

notifySend() {
    CHARGE=$(acpiconf -i 0 | head -n 18 | tail -n 1 | tr -d -c 0-9)

    if [ "$CHARGE" -le "$L1" ] && [ "$NOTIFY" = true ]
    then
        /usr/local/bin/notify-send "LOW BATTERY" --urgency=CRITICAL
        NOTIFY=false
    fi

    if [ "$CHARGE" -le "$L2" ] && [ "$NOTIFY" = true ]
    then
        /usr/local/bin/notify-send "Low battery ($CHARGE%)"
    fi
}

notifyStart

while true
do
    checkStatus
    notifySend
    sleep 500
done
