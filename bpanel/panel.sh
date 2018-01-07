#!/bin/bash

color_fg="FFFFFF"
color_bg="000000"
cf_reset="%{F#${color_fg}}"
cb_reset="%{B#${color_bg}}"
focused_color="%{F#6f0012}"
strength_color="%{F#ffffff}"
value_color2="%{F#FFFF00}"
value_color="%{F#00CCFF}"

Battery(){
	BATPERC=$(acpi | cut -d ' ' -f4)
	echo -e "%{B#6f0012} Bat: ${value_color}${BATPERC}${cf_reset} ${cb_reset} "
}

Wifi(){
	SSID=$(iwconfig |& sed -rn 's/.*ESSID\:\"(.+)\".*/\1/p')
	WIFI_SIGNAL=$(iwconfig |& sed -rn 's/.*Signal level\=(.+)/\1/p' |& sed 's/\ dBm.*//')
	IP=$(ip addr show wls2 |& sed -rn 's/.*inet (.+)\/.*/\1/p')
	echo -n "%{B#6f0012} ${SSID}(${value_color}${WIFI_SIGNAL}${cf_reset}) ${value_color2}${IP}${cf_reset} ${cb_reset} "
}

Clock(){
	TIME=$(date +"%r")
	DAY=$(date +"%A")
	DATE=$(date +"%D")
	echo "%{B#6f0012} ${DAY} ${value_color2}${DATE} ${value_color}${TIME}${cf_reset} ${cb_reset}"
}

Workspaces(){
	FOCUSED=$(bspc query -D -d .focused --names)
	for i in $(bspc query -D --names); do
		if [[ $i = "web" ]]
		then
			if [[ $i = $FOCUSED ]]
			then
				echo -en "${focused_color}\uf269${cf_reset} "
			else
				echo -en "\uf269 "
			fi
		fi #web	
		if [[ $i = "code" ]]
		then
			if [[ $i = $FOCUSED ]]
			then
				echo -en " ${focused_color}\uf198${cf_reset} "
			else
				echo -en " \uf198 "
			fi
		fi #code
		if [[ $i = "vchat" ]]
		then
			if [[ $i = $FOCUSED ]]
			then
				echo -en "${focused_color}\uF086${cf_reset} "
			else
				echo -en "\uF086 "
			fi
		fi #vchat
		if [[ $i = "doc" ]]
		then
			if [[ $i = $FOCUSED ]]
			then
				echo -en "${focused_color}\uF1D1${cf_reset} "
			else
				echo -en "\uF1D1 "
			fi
		fi #doc
		if [[ $i = "music" ]]
		then
			if [[ $i = $FOCUSED ]]
			then
				echo -en "${focused_color}\uF3B5${cf_reset} "
			else
				echo -en "\uF3B5 "
			fi
		fi #music
		if [[ $i = "adm" ]]
		then
			if [[ $i = $FOCUSED ]]
			then
				echo -en "${focused_color}\uF26C${cf_reset} "
			else
				echo -en "\uF26C "
			fi
		fi #adm
		if [[ $i = "games" ]]
		then
			if [[ $i = $FOCUSED ]]
			then
				echo -en "${focused_color}\uF3DF${cf_reset} "
			else
				echo -en "\uF3DF"
			fi
		fi #games
	 done
}

seperator="%{B#000000}${cb_reset}"

while true; do
	#update stuff
	echo  "%{l}%{F#FFFFFF}%{B#000000}$(Workspaces)%{r}$(Wifi)$(Battery)${seperator}$(Clock)"
	sleep 1;
done
