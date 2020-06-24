select 
	ITEM.WORK_ID,
	ITEM.BARCODE,
	ITEM.TYPE_ID,
	ITEM.STATUS_ID,
	LOAN.CREATE_DATE,
	LOAN.CREATE_OPERATOR
from
	ITEM
		right join LOAN
		on (ITEM.ITEM_ID = LOAN.ITEM_ID)
where 
	LOAN.CREATE_OPERATOR = 'YSJ_sort1' -- this value is your returns sorter operator name.
	and LOAN.STATE in (2,3) -- these state references should be for 'discharged' and 'discharged in issue' - see TYPE_STATUS.SUB_TYPE = 72 for your institution-specific values.
        and LOAN.CREATE_DATE >= dateadd(minute, -20, getdate()) -- set your period to check here.. ('minute, -20' = last 20minutes / 'day, -2' = last 2 days) - ensure this coincides with your cron frequency to avoid gaps.
		and ITEM.TYPE_ID in (10) -- these type references are your qualifying item types to select from. see TYPE_STATUS.SUB_TYPE = 1 for your institution-specific values.		
go