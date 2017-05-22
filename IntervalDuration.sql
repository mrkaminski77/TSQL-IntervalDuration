
-- =============================================
-- Author:		David Leyden
-- Create date: {d'2017-01-13'}
-- Description:	
-- =============================================
CREATE FUNCTION [dbo].[IntervalDuration]
(	
	-- Add the parameters for the function here
	@start TIME, 
	@end TIME,
	@intervalStart TIME,
	@intervalEnd Time
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
	SELECT [Duration] = 
	  CASE WHEN @start BETWEEN @intervalStart AND @intervalEnd OR @end BETWEEN @intervalStart AND @intervalEnd 
	  THEN CASE WHEN @start BETWEEN @intervalStart AND @intervalEnd AND @end BETWEEN @intervalStart AND @intervalEnd 
	  THEN DATEDIFF(minute, @start, @end) WHEN @start BETWEEN @intervalStart AND @intervalEnd AND @end > @intervalEnd 
	  THEN DATEDIFF(minute, @start, @intervalEnd) WHEN @end BETWEEN @intervalStart AND @intervalEnd AND @start < @intervalStart 
	  THEN DATEDIFF(minute, @intervalStart, @end) END 
	  ELSE
	  CASE WHEN @start <= @intervalStart AND @end >= @intervalEnd THEN 60 END
	  END
)
