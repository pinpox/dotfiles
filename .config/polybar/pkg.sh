#!/bin/bash
pac=$(checkupdates | wc -l)
aur=$(cower -u | wc -l)

check=$((pac + aur))
if [[ "$check" != "0" ]]
then
	echo "$pac %{F#$(xrdb -query | grep color5 | cut -d'#' -f2)}%{F-} $aur"
fi
