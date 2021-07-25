#!/usr/bin/env bash

if type -p checkupdates >/dev/null 2>&1; then
	UPDATES=$(checkupdates | wc -l)
elif type -p apt-show-versions >/dev/null 2>&1; then
	UPDATES=$(apt-show-versions -u | wc -l)
else
	UPDATES=0
fi
[[ "${UPDATES}" = "0" ]] && exit 0

echo "   ${UPDATES} "
exit 0
