#!/usr/bin/env bash
# Selects First Wallpaper on wallhaven.cc search critera, downloads to path specified in "path" variable and sets wallpaper
# using either pywal or feh, uncomment as required.

# &sorting=random within URL will ensure you always get a different wallpaper each refresh, recommend going to wallhaven.cc
# to set your search criteria then copy url outputted from search to the "url" variable

# (DO NOT SET "PATH" TO A FOLDER WITH OTHER ITEMS, ITEMS ARE REMOVED/FORCED EACH RUN TO AVOID BLOAT OF OLD IMAGES)
# (IF YOU WISH TO KEEP ALL OLD WALLPAPERS IN FOLDER THEN REMOVE LINE "rm -rf $path*"

path=~/Pictures/WP
rm -rf $path*
url='https://wallhaven.cc/search?categories=010&purity=100&resolutions=1920x1080&sorting=random&order=desc'
html=$( curl -# -L "${url}" 2> '/dev/null' )
latest=$(
	<<< "${html}" \
	grep -P -o -e '(?<=wallhaven.cc\/w\/)(.*?)(?=")' |
	head -n 1
)
url=https://wallhaven.cc/w/$latest
html=$( curl -# -L "${url}" 2> '/dev/null' )
latest=$(
        <<< "${html}" \
        grep -P -o -e '(?<=\/\/w.wallhaven.cc\/full\/)(.*?)(?=")' |
        head -n 1
)
url=https://w.wallhaven.cc/full/$latest
filename=$(echo $url | rev | cut -d"/" -f1 | rev)
wget -O $path$filename $url

#Setting wallpaper, comment out either feh or pywal
#feh --bg-scale $path$filename
wal -i $path$filename --saturate 0.5 -a 90
