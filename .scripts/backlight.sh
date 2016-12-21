#!/usr/bin/env bash
light "$@"
pkill -RTMIN+2 i3blocks
