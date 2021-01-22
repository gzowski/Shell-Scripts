#!/bin/bash
limit=30
curl -s https://www.reddit.com/r/politics+worldnews/new/.json?limit=${limit} -A Mozilla | 
jq -r '.data .children[] .data | if(.score <= 700) then "\(.created_utc|strflocaltime("%H:%M:%S")) \(.score) \(.title)","  https://redd.it/\(.id) \(.domain)" else empty end' |
sed -E "s/\?utm_campaign.*//;s/&amp;.*//;s/^(..:..:..) ([0-9]{1,3}) (.*)$/\x1b[1m\1\x1b[0m \x1b[35m\2\x1b[0m\t\x1b[0;40;33m\3\x1b[0m/"
#sed -E "s/\?utm_campaign.*//;s/&amp;.*//;s/^(..:..:..) ([0-9]{1,3}) (.*)$/\1 \x1b[35m\2\x1b[0m\t\x1b[1m\3\x1b[0m/"
#watch -n15 -c -x "${com}"
