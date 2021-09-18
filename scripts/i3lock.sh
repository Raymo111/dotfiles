#!/bin/bash
if ! pgrep -x "i3lock" > /dev/null
then
# 	sed -i 's/^GLCore=false/GLCore=true/g' $XDG_CONFIG_HOME/kwinrc
# 	sed -i 's/^OpenGLIsUnsafe=true/OpenGLIsUnsafe=false/g' $XDG_CONFIG_HOME/kwinrc
	screen=$(xdpyinfo | grep dimensions | sed -r 's/^[^0-9]*([0-9]+x[0-9]+).*$/\1/')
	if [ "$1" == "p" ]
	then
		convert /home/raymo/raymocloud/Pictures/i3/i3wlockscaled.png -resize $screen RGB:- | i3lock -eukfp win --raw $screen:rgb -i /dev/stdin --time-color=ffffffff --date-color=ffffffff --time-str="%H:%M:%S" --date-str="%d/%m/%y" --time-pos="1557:876" --date-pos="1557:895" --time-size=16 --date-size=15 --time-font=Nunito\ sans --date-font=Nunito\ sans --time-align=0 #--no-verify
	elif [ "$1" == "i" ]
	then
		convert '/home/raymo/raymocloud/Pictures/Arch/Arch.png' -resize $screen RGB:- | i3lock --raw $screen:rgb -efi /dev/stdin -c 000000FF --indicator --ringver-color=ffae42ff --insidever-color=ffae42ff --inside-color=00000000 --line-uses-inside --verif-text="Verifying..." --wrong-text="Access Denied" --ring-width 20 --radius 120 #--no-verify
	elif [ "$1" == "t" ]
	then
		i3lock -efkc 00000077 --indicator --ringver-color=ffae42ff --insidever-color=ffae42aa --inside-color=00000000 --line-uses-inside --verif-text="Verifying..." --wrong-text="Access Denied" --verif-size=20 --wrong-size=20 --time-color=ffffff --time-font=DS --time-align=1 --date-color=ffffff --date-font="Nunito Sans" #--no-verify --date-size=150 --date-str="%A, %d %B %Y" --greetertext="" --greetercolor=ffffff --greeter-font="Nunito Sans" --refresh-rate=0.5 --greetersize=300 --date-pos="x+w/2:600" --time-size=400  --time-pos="725:400" --greeterpos="x+w/2:1150"
	else
		i3lock -efkB 7 --indicator --ringver-color=ffae42ff --insidever-color=ffae42aa --inside-color=00000099 --line-uses-inside --verif-text="Verifying..." --wrong-text="Access Denied" --{verif,wrong}-size=20 --{time,date}-color=ffffffff --time-str="%-I:%M:%S" --date-str="%a, %d %b" --time-pos="ix:iy" --date-pos="tx:ty+30" --time-size=35 --date-size=20 --time-font=Consolas --date-font=Nunito\ sans --time-align=0 --pass-{media,screen,power,volume}-keys --special-passthrough #--no-verify
	fi
fi
