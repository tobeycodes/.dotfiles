#!/bin/sh

WEATHER=$(curl --fail --silent --show-error --max-time 8 'https://wttr.in/?format=%C|%t&m' 2>/dev/null)

if [ -z "$WEATHER" ]; then
  exit 0
fi

CONDITION=${WEATHER%%|*}
TEMPERATURE=${WEATHER#*|}
CONDITION=$(printf '%s' "$CONDITION" | tr '[:upper:]' '[:lower:]')

case "$CONDITION" in
  *thunder*) ICON=󰙾
  ;;
  *snow*|*sleet*|*blizzard*) ICON=󰼶
  ;;
  *rain*|*drizzle*|*shower*) ICON=󰖗
  ;;
  *fog*|*mist*) ICON=󰖑
  ;;
  *sunny*|*clear*) ICON=󰖙
  ;;
  *partly*) ICON=󰖕
  ;;
  *) ICON=󰖐
esac

sketchybar --set "$NAME" icon="$ICON" label="$TEMPERATURE"
