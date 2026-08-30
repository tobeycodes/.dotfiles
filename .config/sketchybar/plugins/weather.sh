#!/bin/sh

WEATHER=$(curl --fail --silent --show-error --max-time 8 'https://wttr.in/?format=%C|%t&m' 2>/dev/null)

if [ -z "$WEATHER" ]; then
  exit 0
fi

CONDITION=${WEATHER%%|*}
TEMPERATURE=${WEATHER#*|}
CONDITION=$(printf '%s' "$CONDITION" | tr '[:upper:]' '[:lower:]')

case "$CONDITION" in
  *thunder*) ICON=󰙾 ICON_FONT="JetBrainsMono Nerd Font Mono:Regular:23.9"
  ;;
  *snow*|*sleet*|*blizzard*) ICON=󰼶 ICON_FONT="JetBrainsMono Nerd Font Mono:Regular:21.59"
  ;;
  *rain*|*drizzle*|*shower*) ICON=󰖗 ICON_FONT="JetBrainsMono Nerd Font Mono:Regular:23.9"
  ;;
  *fog*|*mist*) ICON=󰖑 ICON_FONT="JetBrainsMono Nerd Font Mono:Regular:26.53"
  ;;
  *sunny*|*clear*) ICON=󰖙 ICON_FONT="JetBrainsMono Nerd Font Mono:Regular:18.79"
  ;;
  *partly*) ICON=󰖕 ICON_FONT="JetBrainsMono Nerd Font Mono:Regular:22.49"
  ;;
  *) ICON=󰖐 ICON_FONT="JetBrainsMono Nerd Font Mono:Regular:34.21"
esac

sketchybar --set "$NAME" icon="$ICON" icon.font="$ICON_FONT" label="$TEMPERATURE"
