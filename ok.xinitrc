#!/bin/bash
export DISPLAY=:0
unclutter &
/usr/bin/chromium --window-size=1920,1080 --kiosk --window-position=0,0 http://www.google.com http://www.globo.com &
while (true) do
	xdotool keydown ctrl+Tab; xdotool keyup ctrl+Tab;
	sleep 2020
done
