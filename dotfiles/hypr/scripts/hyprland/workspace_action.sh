#!/usr/bin/env bash
cmd="$1"
opt="$2"
val="$3"

shift 3

args=""
while [ $# -ge 2 ]; do
  args+=", $1 = $2"
  shift 2
done

hyprctl dispatch "hl.dsp.$cmd({ $opt = $(((($(hyprctl activeworkspace -j | jq -r .id) - 1) / 10) * 10 + $val))${args} })"
