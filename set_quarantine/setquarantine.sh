#! /bin/sh

file_name=UPDATE_setquarantine

current_time=$(date "+%d-%H.%M")
echo "Current Time : $current_time"

new_fileName=$file_name.$current_time'.log'

echo "New FileName: " "$new_fileName"

cd /usr/opt/blcmp/local/utils/bin/set_quarantine

isql -U"sa" -D"prod_talis" -b < SELECT_setquarantine.sql > logs/UPDATE_setquarantine

sleep 10s

isql -U"sa" -D"prod_talis" -b < UPDATE_setquarantine.sql >> logs/UPDATE_setquarantine

cp logs/$file_name logs/$new_fileName

sleep 10s

echo -e "CAPITA_LMS: setquarantine - set quarantine status \n last 20mins of returned items changed to quarantine status \n \n  $(cat \/usr/opt/blcmp/local/utils/bin/set_quarantine/logs/$new_fileName)" | mailx -s "CAPITA_LMS setquarantine log" -r "LIBSYS<email@address.com>" email@address.com
