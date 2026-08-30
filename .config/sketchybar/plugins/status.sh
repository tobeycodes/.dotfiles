#!/bin/sh

FG=0xffa9b1d6
DIM=0xff62667e

INTERFACE=$(route -n get default 2>/dev/null | awk '/interface:/{print $2; exit}')
WIFI_INTERFACE=$(networksetup -listallhardwareports | awk '/Hardware Port: Wi-Fi/{getline; print $2; exit}')
if [ -z "$INTERFACE" ]; then
  NETWORK=󰤮
  NETWORK_FONT="JetBrainsMono Nerd Font Mono:Regular:25.1"
  NETWORK_PAD_LEFT=3
  NETWORK_PAD_RIGHT=3
elif [ "$INTERFACE" = "$WIFI_INTERFACE" ]; then
  NETWORK=󰖩
  NETWORK_FONT="JetBrainsMono Nerd Font Mono:Regular:25.9"
  NETWORK_PAD_LEFT=4
  NETWORK_PAD_RIGHT=2
else
  NETWORK=󰈀
  NETWORK_FONT="JetBrainsMono Nerd Font Mono:Regular:22.73"
  NETWORK_PAD_LEFT=4
  NETWORK_PAD_RIGHT=2
fi

VOLUME=$(osascript -e 'output volume of (get volume settings)')
MUTED=$(osascript -e 'output muted of (get volume settings)')
if [ "$MUTED" = true ] || [ "${VOLUME:-0}" -eq 0 ]; then
  AUDIO=󰖁
  AUDIO_FONT="JetBrainsMono Nerd Font Mono:Regular:21.67"
  AUDIO_PAD_LEFT=3
  AUDIO_PAD_RIGHT=3
elif [ "$VOLUME" -le 33 ]; then
  AUDIO=󰕿
  AUDIO_FONT="JetBrainsMono Nerd Font Mono:Regular:14.01"
  AUDIO_PAD_LEFT=3
  AUDIO_PAD_RIGHT=3
elif [ "$VOLUME" -le 66 ]; then
  AUDIO=󰖀
  AUDIO_FONT="JetBrainsMono Nerd Font Mono:Regular:18.21"
  AUDIO_PAD_LEFT=4
  AUDIO_PAD_RIGHT=2
else
  AUDIO=󰕾
  AUDIO_FONT="JetBrainsMono Nerd Font Mono:Regular:22.26"
  AUDIO_PAD_LEFT=3
  AUDIO_PAD_RIGHT=3
fi

BLUETOOTH_ICON=󰂯
BLUETOOTH_FONT="JetBrainsMono Nerd Font Mono:Regular:14.01"
BLUETOOTH_PAD_LEFT=4
BLUETOOTH_PAD_RIGHT=2
BLUETOOTH_COLOR=$FG
BLUETOOTH_ON=true
BLUETOOTH_CONNECTED=false
if command -v blueutil >/dev/null 2>&1; then
  if [ "$(blueutil --power 2>/dev/null)" != "1" ]; then
    BLUETOOTH_ON=false
  fi
  if [ "$(blueutil --connected 2>/dev/null)" = "1" ]; then
    BLUETOOTH_CONNECTED=true
  fi
else
  BLUETOOTH_INFO=$(system_profiler SPBluetoothDataType 2>/dev/null)
  BLUETOOTH_POWER=$(printf '%s\n' "$BLUETOOTH_INFO" | awk -F': ' '/State:/{print $2; exit}')
  if printf '%s\n' "$BLUETOOTH_INFO" | grep -q '^[[:space:]]*Connected:'; then
    BLUETOOTH_CONNECTED=true
  fi
  if [ "$BLUETOOTH_POWER" = "Off" ]; then
    BLUETOOTH_ON=false
  fi
fi
if [ "$BLUETOOTH_CONNECTED" = true ]; then
  BLUETOOTH_ICON=󰂱
  BLUETOOTH_FONT="JetBrainsMono Nerd Font Mono:Regular:19.52"
fi
if [ "$BLUETOOTH_ON" = false ]; then
  BLUETOOTH_COLOR=$DIM
fi

BATTERY_STATE=$(pmset -g batt)
PERCENTAGE=$(printf '%s' "$BATTERY_STATE" | grep -Eo '[0-9]+%' | cut -d% -f1)
BATTERY=""
BATTERY_FONT="JetBrainsMono Nerd Font Mono:Regular:14.01"
if [ -n "$PERCENTAGE" ]; then
  if printf '%s' "$BATTERY_STATE" | grep -q 'AC Power'; then
    BATTERY_FONT="JetBrainsMono Nerd Font Mono:Regular:22.81"
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

sketchybar --set status.bluetooth icon="$BLUETOOTH_ICON" icon.font="$BLUETOOTH_FONT" icon.color="$BLUETOOTH_COLOR" icon.padding_left=$BLUETOOTH_PAD_LEFT icon.padding_right=$BLUETOOTH_PAD_RIGHT \
           --set status.network icon="$NETWORK" icon.font="$NETWORK_FONT" icon.padding_left=$NETWORK_PAD_LEFT icon.padding_right=$NETWORK_PAD_RIGHT \
           --set status.volume icon="$AUDIO" icon.font="$AUDIO_FONT" icon.padding_left=$AUDIO_PAD_LEFT icon.padding_right=$AUDIO_PAD_RIGHT

if [ -n "$BATTERY" ]; then
  sketchybar --set status.battery drawing=on icon="$BATTERY" icon.font="$BATTERY_FONT" icon.padding_left=4 icon.padding_right=2
else
  sketchybar --set status.battery drawing=off
fi
