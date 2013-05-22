#!/bin/bash
cd /var/www/pka
COUNT=$(for file in *.m4a;do echo $file; done |sed 's/\.m4a//')
rm $COUNT.m4a
COUNT=$((COUNT + 1))
URL="$(curl -silent "http://www.youtube.com/playlist?list=UUIPVJoHb_A5S3kcv3TJlyEg" |grep "Painkiller Already $COUNT "|grep -o 'href="[^"]*"'| grep -o '"[^"]*"' | sed 's/^.//' |sed '$s/.$//' |sed 's/^/http:\/\/www.youtube.com/g' |sed 's/\&amp;[^\&amp;]*$//' |sed 's/\&amp;[^\&amp;]*$//')"
echo $URL
youtube-dl -x -f 18 $URL
for file in *.m4a; do mv $file $COUNT.m4a; done
sed 's/<item>.*<\/item>/<item>\n<title>135<\/title>\n<description> A description of your podcast episode <\/description>\n<pubDate>$(date +"%a, %d %b %Y %T PST")<\/pubDate>\n<enclosure url="http:\/\/spacejake.com\/pka\/$($COUNT).m4a" length="184413287" type="audio/mpeg" \/> <\/item>' 
