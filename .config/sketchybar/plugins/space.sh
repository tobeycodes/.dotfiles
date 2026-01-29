#!/bin/sh

if [ -z "$FOCUSED_WORKSPACE" ]; then
    FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)
fi

sketchybar --set aerospace_workspace icon="$FOCUSED_WORKSPACE"
