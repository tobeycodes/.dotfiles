#!/bin/sh

FG=0xffa9b1d6
DIM=0xff62667e
ACTIVE=󱓻
ICON_FONT="JetBrainsMono Nerd Font Mono:Regular:14.0"
ACTIVE_FONT="JetBrainsMono Nerd Font Mono:Regular:21.67"

focused=${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}
occupied_workspaces=$(aerospace list-windows --all --format '%{workspace}')

for workspace in 1 2 3 4 5 6 7 8 9 A B C D E F G H I J K L M N O P Q R S T U V W X Y Z; do
  item="space.$workspace"
  occupied=false
  if printf '%s\n' "$occupied_workspaces" | grep -Fxq "$workspace"; then
    occupied=true
  fi

  visible=$occupied
  case "$workspace" in
    [1-9]) visible=true
    ;;
  esac

  if [ "$visible" = false ]; then
    sketchybar --set "$item" drawing=off
  elif [ "$focused" = "$workspace" ]; then
    sketchybar --set "$item" drawing=on icon="$ACTIVE" icon.color="$FG" icon.font="$ACTIVE_FONT"
  else
    color=$DIM
    if [ "$occupied" = true ]; then
      color=$FG
    fi
    sketchybar --set "$item" drawing=on icon="$workspace" icon.color="$color" icon.font="$ICON_FONT"
  fi
done
