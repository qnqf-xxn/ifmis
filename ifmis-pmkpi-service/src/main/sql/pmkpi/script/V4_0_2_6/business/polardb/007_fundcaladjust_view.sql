i number;
begin
  --添加字段
  select count(*) into i from user_tab_cols t where t.TABLE_NAME = 'PERF_T_FUNDCALINDEX'  and t.COLUMN_NAME = 'STATUS';
  if i = 0 then
     execute immediate 'alter table PERF_T_FUNDCALINDEX add STATUS VARCHAR2(30)';
  end if;
  
  --重构视图
  execute immediate' create or replace view V_PERF_T_FUNDCALINDEX as
     select t.* from PERF_T_FUNDCALINDEX t
     where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and
     PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
	 
  execute immediate'
  CREATE OR REPLACE VIEW v_perf_t_fundcaladjustindexview as
	select t.guid AS fundguid,
    t.xmlx,
    t.xmlb,
    t.xmmxnr,
    t.bzy,
    t.bzjs,
    t.csyj1,
    t.csyj2,
    t.jldw1,
    t.sl1,
    t.jldw2,
    t.sl2,
    t.zj AS zjlywy,
	t2.* from v_pm_xmbzcs t left join  (select * from V_PERF_T_FUNDCALINDEX where status = ''adjust'') t1 on t.guid = t1.fundguid
	left join v_PERF_T_ADJUSTINDEX t2 on t1.indexguid = t2.guid';	 
	 
