# quarantine_returns

This tool is to allow library system managers to automate quarantining stock once it has been returned to stock.

In brief, the process looks for items returned via the returns sorter in the last 20 minutes. When it finds these items, it updates the status from 'Loanable' to 'Quarantined'. A second script is triggered every hour, looking for items which are of quarantine status, and have a last-edited date of 72 hours ago. If it finds any items matching this criteria, it changes their status back to loanable.

If your LMS is hosted on Linux, follow the below steps:

 1) Add a 'quarantine' status in alto config.
 2) change user with to 'sudo su - talis'
 3) place the following folders in /usr/opt/blcmp/local/utils/bin/..
    - ./set_quarantine
    - ./reset_loanable
 4) navigate to the respective .sh files - setquarantine.sh and resetloanable.sh and update institution-specific values following comments in code.
 5) update the 'report to' email addresses on the final line of each .sh file.
 6) open the cron and add lines similar to below:
 
 ``` # ================================================
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
     ```
