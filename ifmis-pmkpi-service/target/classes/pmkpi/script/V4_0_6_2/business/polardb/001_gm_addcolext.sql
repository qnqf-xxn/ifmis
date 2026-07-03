  i number;
begin

select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_PROMONITOR' and t.column_name='V_COLK1';
if i=0 then
    execute immediate 'alter table PERF_T_PROMONITOR add V_COLK1 VARCHAR2(40)';
end if;
select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_PROMONITOR' and t.column_name='V_COLK2';
if i=0 then
    execute immediate 'alter table PERF_T_PROMONITOR add V_COLK2 VARCHAR2(40)';
end if;
select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_PROMONITOR' and t.column_name='V_COLK3';
if i=0 then
    execute immediate 'alter table PERF_T_PROMONITOR add V_COLK3 VARCHAR2(40)';
end if;
select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_PROMONITOR' and t.column_name='V_COLK4';
if i=0 then
    execute immediate 'alter table PERF_T_PROMONITOR add V_COLK4 VARCHAR2(100)';
end if;
select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_PROMONITOR' and t.column_name='V_COLK5';
if i=0 then
    execute immediate 'alter table PERF_T_PROMONITOR add V_COLK5 VARCHAR2(100)';
end if;
execute immediate '
create or replace view v_perf_t_promonitor as
select t.*
   from perf_t_promonitor t
      WHERE year = global_multyear_cz.v_pmyear and
     province = global_multyear_cz.v_pmdivid
  ';
select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_SELFEVALTASK' and t.column_name='V_COLK1';
if i=0 then
    execute immediate 'alter table PERF_T_SELFEVALTASK add V_COLK1 VARCHAR2(40)';
end if;
select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_SELFEVALTASK' and t.column_name='V_COLK2';
if i=0 then
    execute immediate 'alter table PERF_T_SELFEVALTASK add V_COLK2 VARCHAR2(40)';
end if;
select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_SELFEVALTASK' and t.column_name='V_COLK3';
if i=0 then
    execute immediate 'alter table PERF_T_SELFEVALTASK add V_COLK3 VARCHAR2(40)';
end if;
select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_SELFEVALTASK' and t.column_name='V_COLK4';
if i=0 then
    execute immediate 'alter table PERF_T_SELFEVALTASK add V_COLK4 VARCHAR2(100)';
end if;
select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_SELFEVALTASK' and t.column_name='V_COLK5';
if i=0 then
    execute immediate 'alter table PERF_T_SELFEVALTASK add V_COLK5 VARCHAR2(100)';
end if;
execute immediate 'create or replace view v_perf_t_selfevaltask as
select * 
  from PERF_T_SELFEVALTASK t
 where t.year = global_multyear_cz.v_pmyear and
     t.province = global_multyear_cz.v_pmdivid and t.is_deleted = 2';

select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_ADJUST' and t.column_name='V_COLK1';
if i=0 then
    execute immediate 'alter table PERF_T_ADJUST add V_COLK1 VARCHAR2(40)';
end if;
select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_ADJUST' and t.column_name='V_COLK2';
if i=0 then
    execute immediate 'alter table PERF_T_ADJUST add V_COLK2 VARCHAR2(40)';
end if;
select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_ADJUST' and t.column_name='V_COLK3';
if i=0 then
    execute immediate 'alter table PERF_T_ADJUST add V_COLK3 VARCHAR2(40)';
end if;
select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_ADJUST' and t.column_name='V_COLK4';
if i=0 then
    execute immediate 'alter table PERF_T_ADJUST add V_COLK4 VARCHAR2(100)';
end if;
select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_ADJUST' and t.column_name='V_COLK5';
if i=0 then
    execute immediate 'alter table PERF_T_ADJUST add V_COLK5 VARCHAR2(100)';
end if;

execute immediate '
create or replace view v_perf_t_adjust as
select * from perf_t_adjust t
where year = global_multyear_cz.v_pmyear and
     province = global_multyear_cz.v_pmdivid';
