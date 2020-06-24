# quarantine_returns

This tool is to allow library system managers to automate quarantining stock once it has been returned to stock.

If your LMS is hosted on Linux, follow the below steps:

 1) change user with to 'sudo su - talis'
 2) place the following folders in /usr/opt/blcmp/local/utils/bin/..
    - ./set_quarantine
    - ./reset_loanable
3) navigate to the respective .sh files - setquarantine.sh and resetloanable.sh and update institution-specific values following comments in code.
4) update the 'report to' email addresses on the final line of each .sh file.
5) open the cron and add lines similar to below:


       # ================================================
       # Bespoke script to update item status to 'quarantined'
       # ================================================
       0,20,40 * * * * talis . ~talis/.bash_profile; /usr/opt/blcmp/local/utils/bin/set_quarantine/setquarantine.sh 1>/var/tmp/setquarantine.cron 2>&1
       #
       # ================================================
       # Bespoke script to restore item status post-quarantine
       # ================================================
       0 * * * * talis . ~talis/.bash_profile; /usr/opt/blcmp/local/utils/bin/reset_loanable/resetloanable.sh 1>/var/tmp/resetloanable.cron 2>&1
       #
       #
