#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
myarr=($(xrandr | awk '/ connected/ && /[[:digit:]]x[[:digit:]].*+/{print $1}'))

for monitor in "${myarr[@]}"
do
    polybar -c ~/.config/polybar/config.ini "$monitor" &
done

echo "Bars launched..."
