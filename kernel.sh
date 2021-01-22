#!/usr/bin/env bash
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
