#! /bin/sh

file_name=UPDATE_resetloanable

current_time=$(date "+%d-%H.%M")
echo "Current Time : $current_time"

new_fileName=$file_name.$current_time'.log'

echo "New FileName: " "$new_fileName"

cd /usr/opt/blcmp/local/utils/bin/reset_loanable

isql -U"sa" -D"prod_talis" -b < SELECT_resetloanable.sql > logs/UPDATE_resetloanable

sleep 10s

isql -U"sa" -D"prod_talis" -b < UPDATE_resetloanable.sql >> logs/UPDATE_resetloanable

cp logs/$file_name logs/$new_fileName

sleep 10s

echo -e "CAPITA_LMS: resetloanable - reset loanable status \n stock quarantined for 72 hours, set to loanable status \n \n  $(cat \/usr/opt/blcmp/local/utils/bin/reset_loanable/logs/$new_fileName)" | mailx -s "CAPITA_LMS resetloanable log" -r "LIBSYS<email@address.com>" email@address.com
