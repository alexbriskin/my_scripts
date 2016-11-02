#!/bin/bash
SLEEP=0.2
LEDMASK=4
LEDNAME="Scroll Lock"

xmessage -timeout 1 "Switching..." &

STATE="$(( $(xset q | awk '/LED/ {print $10}') & LEDMASK ))"

test $STATE -eq $LEDMASK && xset -led named "$LEDNAME" && sleep $SLEEP
xset led named "$LEDNAME"  
sleep $SLEEP
xset -led named "$LEDNAME" 
sleep $SLEEP
xset led named "$LEDNAME"  
test $STATE -ne $LEDMASK && sleep $SLEEP && xset -led named "$LEDNAME"
