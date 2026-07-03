--declare
 i integer;
begin
select count(*) into i from user_tables  t where t.TABLE_NAME='PM_XMBZCS';
  if i=1 then

	execute immediate '
	CREATE OR REPLACE VIEW v_perf_T_fundcalindexview AS	
	select 	t.guid as fundguid,
			t.xmlx,	--项目类型
			t.xmlb,	--明细项目类别
			t.xmmxnr,	--项目明细内容
			t.bzy,	--标准
			t.bzjs,	--标准解释
			t.csyj1,	--标准依据1
			t.csyj2,	--标准依据2
			t.jldw1,	--计量单位1
			t.sl1,	--数量1
			t.jldw2,	--计量单位2
			t.sl2,	--数量2
			t.zjlywy,	--资金来源（万元）
			t.pro_code as procode,
			t2.*
	from V_PM_XMBZCS t 
		 LEFT JOIN v_perf_t_fundcalindex t1 ON t.guid = t1.fundguid AND t.pro_code = t1.procode
		 LEFT JOIN ( SELECT * FROM v_pm_perf_indicator WHERE yearflag = ''0'') t2 
		 ON t1.indexguid = t2.guid AND t1.procode = t2.pro_code
	  WHERE EXISTS (SELECT 1 FROM v_pm_project_info t2_1 WHERE t2_1.pro_code = t.pro_code) AND t.is_deleted = ''2''
	';  

 end if;
 
--end; 