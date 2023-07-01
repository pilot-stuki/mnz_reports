USE [FCDynamo_DS]
GO

/****** Object:  View [level].[contact_data]    Script Date: 26.06.2023 19:34:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





ALTER view [level].[contact_data]
as
select
	[contact_id]
 , [summ_by_current_level]
 , [full_calculation_summ]
 , [level_id]
 , [level_date]
 , [level_enddate]
 , [level_limit]
 , [level_keep_limit]
 , [new_level_id]
 , [new_level_date]
 , [new_level_enddate] 
 , [new_level_limit]
 , [new_level_keep_limit]
 , [summ_for_next_level]
 , [change_reason]
 , [old_level_limit]
from
	level.contact_data_internal with (nolock)
where spid = @@spid;
GO


