#!/usr/bin/env bash
hyprctl dispatch "hl.dsp.$1({ $2 = $(((($(hyprctl activeworkspace -j | jq -r .id) - 1)  / 10) * 10 + $3))
})"
