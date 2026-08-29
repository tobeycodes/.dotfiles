#!/bin/sh

BLUETOOTH=󰂯

INTERFACE=$(route -n get default 2>/dev/null | awk '/interface:/{print $2; exit}')
WIFI_INTERFACE=$(networksetup -listallhardwareports | awk '/Hardware Port: Wi-Fi/{getline; print $2; exit}')
if [ -z "$INTERFACE" ]; then
  NETWORK=󰤮
elif [ "$INTERFACE" = "$WIFI_INTERFACE" ]; then
  NETWORK=󰖩
else
  NETWORK=󰈀
fi

VOLUME=$(osascript -e 'output volume of (get volume settings)')
if [ "${VOLUME:-0}" -eq 0 ]; then
  AUDIO=󰖁
else
  AUDIO=󰕾
fi

BATTERY_STATE=$(pmset -g batt)
PERCENTAGE=$(printf '%s' "$BATTERY_STATE" | grep -Eo '[0-9]+%' | cut -d% -f1)
BATTERY=""
if [ -n "$PERCENTAGE" ]; then
  if printf '%s' "$BATTERY_STATE" | grep -q 'AC Power'; then
    set -- 󰢜 󰂆 󰂇 󰂈 󰢝 󰂉 󰢞 󰂊 󰂋 󰂅
  else
    set -- 󰁺 󰁻 󰁼 󰁽 󰁾 󰁿 󰂀 󰂁 󰂂 󰁹
  fi
  INDEX=$((PERCENTAGE / 10))
  if [ "$INDEX" -gt 9 ]; then
    INDEX=9
  fi
  eval "BATTERY=\${$((INDEX + 1))}"
fi

sketchybar --set status.bluetooth icon="$BLUETOOTH" \
           --set status.network icon="$NETWORK" \
           --set status.volume icon="$AUDIO"

if [ -n "$BATTERY" ]; then
  sketchybar --set status.battery drawing=on icon="$BATTERY"
else
  sketchybar --set status.battery drawing=off
fi
