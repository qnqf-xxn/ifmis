begin

--监控全年度表  
execute immediate'
create or replace view perf_v_promonitor_allyear as
select
    t.*
    ,case
        when to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') > to_date(b.enddate, ''yyyymmdd'') then ''000''
        when to_number(to_date(b.enddate, ''yyyymmdd'') - to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')) > to_number(b.warndays) then ''black''
        when to_number(to_date(b.enddate, ''yyyymmdd'') - to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')) <= to_number(b.warndays) then ''red''
    end warn,
    case
     when to_date(b.enddate, ''yyyymmdd'') < to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') then 0
     else to_date(b.enddate, ''yyyymmdd'') - to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')
    end as warndays,
    t.update_time as updatetime,
    b.taskstage,
    b.startdate,
    b.enddate,
    b.tasktype,
    b.bustype,
    b.name as taskname,
	t1.ele_code||''-''||t1.ele_name as agencyname,t2.ele_name as finintorgname,t3.ele_name as manage_mof_dep_codename,t4.code||''-''||t4.name as projectkindname,
	case when t.depttask = ''1'' then ''是'' when t.depttask =''2'' then ''否'' else '''' end as depttaskname,
	case when t.provincetask = ''1'' then ''是'' when t.provincetask =''2'' then ''否'' else '''' end as provincetaskname
from perf_t_promonitor t
left join perf_t_taskset b on b.guid = t.taskguid and b.province = t.province and b.year = t.year
left join ELE_VD00010 t1 on t.agencyguid = t1.ele_code and t1.mof_div_code = t.province and t1.fiscal_year = t.year
left join ELE_DEPARTMENT t2 on t.finintorgguid = t2.ele_code and t2.mof_div_code = t.province and t2.fiscal_year = t.year
left join ELE_DEPARTMENT t3 on t.manage_mof_dep_code = t3.ele_code and t3.mof_div_code = t.province and t3.fiscal_year = t.year
left join PM_T_PROJECTKIND t4 on t.projectkind = t4.code and t4.province = t.province and t4.year =t.year
where t.wfstatus is not null
and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

--整改全年度表
execute immediate'
create or replace view perf_v_rectify_allyear as
select t.pro_code as procode,t.proguid,t.taskguid,province,year,max(isrectify) as isrectify, max(rectifyend) as rectifyend
    from  perf_t_rectify t where t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') group by proguid,pro_code,taskguid,province,year';