#!/bin/bash

function brt-all () {
  local brightness=${1:-50}
  local monitors=$( ddcutil detect | grep -Po "Display \d" | wc -l )
  for i in $(seq 1 $monitors );do
    ddcutil --display $i setvcp 10 $brightness >/dev/null
  done
}

display_value=$( ddcutil --display 2 getvcp 10 | grep -Po "current\svalue\s+\=\s*\d+" | grep -Po "\d+" )

# echo "Current Val $display_value"

brt-all $display_value

