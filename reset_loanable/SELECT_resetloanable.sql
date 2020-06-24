select 
	ITEM.WORK_ID,
	ITEM.BARCODE,
	ITEM.TYPE_ID,
	ITEM.STATUS_ID,
from
	ITEM
where 
        ITEM.STATUS_ID = 109 -- this status value should be the item status you want to target items with. In this case, we are targetting items with quaratine status. See TYPE_STATUS.SUB_TYPE = 6 for your institution-specific values.
		and ITEM.EDIT_DATE = dateadd(hour, -72, getdate()) -- set your period to check here.. ('minute, -20' = last 20minutes / 'day, -2' = last 2 days) - ensure this coincides with your cron frequency to avoid gaps.
		and ITEM.TYPE_ID = 10 -- these type references are your qualifying item types to target. see TYPE_STATUS.SUB_TYPE = 1 for your institution-specific values. For multiple values, replace '= value_a' with 'in (value_a, value_b)'.
go