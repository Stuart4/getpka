#!/bin/bash
#Copyright © 2013 Jacob Stuart jake@spacejake.com
#This work is free. You can redistribute it and/or modify it under the
#terms of the Do What The Fuck You Want To Public License, Version 2,
#as published by Sam Hocevar. See the COPYING file for more details.

function createXML {


}

cd /var/www/pka
COUNT=$(for file in *.m4a;do echo $file; done |sed 's/\.m4a//')
rm $COUNT.m4a
COUNT=$((COUNT + 1))
URL="$(curl -silent "http://www.youtube.com/playlist?list=UUIPVJoHb_A5S3kcv3TJlyEg" |grep "Painkiller Already $COUNT "|grep -o 'href="[^"]*"'| grep -o '"[^"]*"' | sed 's/^.//' |sed '$s/.$//' |sed 's/^/http:\/\/www.youtube.com/g' |sed 's/\&amp;[^\&amp;]*$//' |sed 's/\&amp;[^\&amp;]*$//')"
echo $URL
youtube-dl -x -f 18 $URL
for file in *.m4a; do mv $file $COUNT.m4a; done
