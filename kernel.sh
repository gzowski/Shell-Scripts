#!/usr/bin/env bash
#For arch users using Polybar,
#Requirements: FontAwesome 5 Free, Polybar
#Checks kernel version against latest version available on archlinux.org packages page
#If outdated, updates icon alongside kernel version on polybar.

#Add to polybar config
#[module/kernel]
#type = custom/script
#exec = "Script location"/kernel.sh
#interval = 600
#format = "<label>"
#label = %output%

url='https://archlinux.org/packages/core/x86_64/linux/'
html=$( curl -# -L "${url}" 2> '/dev/null' )
latest=$(
<<< "${html}" \
grep -P -o -e '(?<=<h2>linux )(.*?)(?=.arch)' |
head -n 1
)
current=$(uname -r | cut -d '-' -f1)
if [ $current == $latest ]; then
echo  $current
else
echo  $current
fi
