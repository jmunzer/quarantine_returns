update ITEM
	set 	ITEM.STATUS_ID = 109, -- this status value should be the item status you want to set items to. See TYPE_STATUS.SUB_TYPE = 6 for your institution-specific values.
		ITEM.EDIT_DATE = getdate(),
		ITEM.EDIT_OP = 'YSJ_sort1' -- this value is your returns sorter operator name.
	from ITEM
		inner join LOAN
			on (ITEM.ITEM_ID = LOAN.ITEM_ID)
	where LOAN.CREATE_OPERATOR = 'YSJ_sort1' -- this value is your returns sorter operator name.
		and LOAN.STATE in (2,3) -- these state references should be for 'discharged' and 'discharged in issue' - see TYPE_STATUS.SUB_TYPE = 72 for your institution-specific values.
		and LOAN.CREATE_DATE >= dateadd(minute, -20, getdate()) -- set your period to check here.. ('minute, -20' = last 20minutes / 'day, -2' = last 2 days) - ensure this coincides with your cron frequency to avoid gaps.
		and ITEM.TYPE_ID = 10 -- these type references are your qualifying item types to select from. see TYPE_STATUS.SUB_TYPE = 1 for your institution-specific values. For multiple values, replace '= value_a' with 'in (value_a, value_b)'.
go
