#!/bin/bash
MON="$1"

for i in {1..10}; do
	hyprctl dispatch workspace "$i"
	hyprctl dispatch moveworkspacetomonitor "$i" "$MON"
done

# hyprctl dispatch workspace 1
