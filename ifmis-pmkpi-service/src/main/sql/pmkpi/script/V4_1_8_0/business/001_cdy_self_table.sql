
i number;
begin
  
execute immediate '
create or replace view v_perf_selfparentproject_check as
select t.*,100 as bgtamt
  from v_perf_project_info t
 where t.pro_lev=''1''
 --填报过总体绩效目标才可进行自评价
 and exists(select 1 from pm_perf_goal_info a where a.is_deleted=2 and a.is_backup=2 and a.yearflag=''1'' and a.mainguid=t.pro_id and a.province=t.province)
';

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_PROFUND' and t.column_name='PARENT_PRO_CODE';
if i=0 then
   execute immediate 'alter table PERF_T_PROFUND add parent_pro_code VARCHAR2(21)';
end if;

execute immediate '
create or replace view v_perf_t_profund as
select t.*
 from perf_t_profund t
where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
   and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

execute immediate '
create or replace view v_perf_selfbdgpay_parentprogram as
select t.name as name, --资金来源
       (case when t.name = ''一般公共预算拨款-上级'' then 1
       when t.name = ''一般公共预算拨款-本级'' then 2
        when t.name = ''政府性基金'' then 3
          when t.name = ''国有资本经营预算'' then 4
        else 9
       end) as ordernum, -- 资金的排序
       parent_pro_code as pro_code, -- 项目编码唯一
       sum(t.amt1) as AMT1, -- 年初预算
       sum(t.amt2) as AMT2, -- 调整预算
       (sum(t.amt2) + sum(t.amt1)) as AMT3, -- 调整后预算（调整预算之和+年初预算）
       sum(t.amt4) as AMT4, -- 全年执行数
       decode((sum(t.amt2) + sum(t.amt1)),0,0,round(sum(t.amt4) / (sum(t.amt2) + sum(t.amt1))*100, 2)) as BGTGET, -- 预算执行率（实际执行数/调整后预算数）
       '''' as SCORE, --自评得分
       t.isedit
  from v_perf_t_profund t
 WHERE t.month <= PERF_FUNDPAY_VIEW.get_month
   and t.parent_pro_code = PERF_FUNDPAY_VIEW.get_procode
 group by t.parent_pro_code,t.name,t.isedit';

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_SELFPERFINDEX' and t.column_name='FILENAME';
if i=0 then
   execute immediate 'alter table PERF_T_SELFPERFINDEX add filename varchar2(4000)';
end if;

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_SELFPERFINDEX' and t.column_name='IND_REMARK';
if i=0 then
   execute immediate 'alter table PERF_T_SELFPERFINDEX add IND_REMARK VARCHAR2(4000)';
end if;

execute immediate '
create or replace view v_perf_t_selfperfindex as
select *
from perf_t_selfperfindex where
    year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
    and is_deleted = 2';
