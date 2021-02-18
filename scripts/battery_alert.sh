#!/usr/bin/bash

BATTERY_DIR=/sys/class/power_supply/BAT0
UNIQUE_ID=134765
APP="A Battery-Low"

CURRENT=$(cat $BATTERY_DIR/charge_now)
TOTAL=$(cat $BATTERY_DIR/charge_full_design)
STATUS=$(cat $BATTERY_DIR/status)

LEVEL=$((CURRENT*100/TOTAL))

if [[ LEVEL -le 20 && $STATUS == Discharging ]]; then
	dunstify "Battery level $LEVEL%" -r $UNIQUE_ID -a $APP
fi
