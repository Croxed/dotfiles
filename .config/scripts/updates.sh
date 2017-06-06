#!/bin/bash
pac=$(checkupdates | wc -l)
aur=$(cower -u | wc -l)

check=$((pac + aur))
if [[ "$check" != "0" ]]
then
    echo "$pac %{F#fae3bb}%{F-} $aur"
else
		echo "0 %{F#fae3bb}%{F-} 0"
fi
