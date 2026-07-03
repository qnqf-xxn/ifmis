
i number;
begin

select count(1) into i from user_tables t where t.TABLE_NAME='PERF_T_SELFFRAME';
 if i=0 then
execute immediate '
create table PERF_T_SELFFRAME
(
  guid        VARCHAR2(40) not null,
  code        VARCHAR2(300),
  name        VARCHAR2(1000),
  superid     VARCHAR2(38),
  levelno     NUMBER(2),
  isleaf      NUMBER(1),
  ordernum    NUMBER(9),
  remark      VARCHAR2(2000),
  status      NUMBER,
  update_time VARCHAR2(17),
  is_deleted  NUMBER(1) not null,
  create_time VARCHAR2(17),
  frametype   VARCHAR2(40) not null,
  year        NUMBER(4) not null,
  province    VARCHAR2(9) not null,
  weight      NUMBER(18,2),
  indexval    VARCHAR2(1000),
  computesign VARCHAR2(40),
  meterunit   VARCHAR2(40),
  isedit      VARCHAR2(40)
)';
execute immediate ' 
alter table PERF_T_SELFFRAME
  add constraint PK_PERF_SELFFRAME primary key (GUID, YEAR, PROVINCE)';
end if;

select count(1) into i from user_tables t where t.TABLE_NAME='PERF_T_SELFPERFOPINION';
 if i=0 then
execute immediate '
create table PERF_T_SELFPERFOPINION
(
  guid                 VARCHAR2(40) not null,
  content_remark       VARCHAR2(4000),
  demonstration_remark VARCHAR2(4000),
  result_remark        VARCHAR2(4000),
  opinionscore         NUMBER(5,2),
  mainguid             VARCHAR2(40),
  update_time          VARCHAR2(17),
  is_deleted           NUMBER(1) not null,
  create_time          VARCHAR2(17),
  year                 NUMBER(4) not null,
  province             VARCHAR2(9) not null,
  creater              VARCHAR2(40)
)';
execute immediate '
alter table PERF_T_SELFPERFOPINION
  add constraint PK_PERF_SELFPERFOPINION primary key (GUID, PROVINCE, YEAR)';
end if;

select count(1) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_SELFEVALTASK' and t.COLUMN_NAME='LASTUPDATETIME';
 if i>0 then
    execute immediate 'alter table PERF_T_SELFEVALTASK modify lastupdatetime default null';
end if;

select count(1) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_SELFEVALTASK' and t.COLUMN_NAME='BGTGET';
 if i=0 then
    execute immediate 'alter table PERF_T_SELFEVALTASK add BGTGET NUMBER(5,2)';
end if;

select count(1) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_SELFPERFINDEX' and t.COLUMN_NAME='SCORE_REMARK';
 if i=0 then
    execute immediate 'alter table PERF_T_SELFPERFINDEX add SCORE_REMARK VARCHAR2(2000)';
end if;

select count(1) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_SELFPERFINDEX' and t.COLUMN_NAME='DATATYPE';
 if i=0 then
    execute immediate 'alter table PERF_T_SELFPERFINDEX add DATATYPE VARCHAR2(40)';
end if;

execute immediate '
create or replace view v_perf_t_selfevaltask as
select t.*
    from PERF_T_SELFEVALTASK t
    where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
      and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted = 2';

execute immediate '
create or replace view perf_v_selfevaltask as
select t.*
       ,''2'' as rectifytype,
       a.amt1 as budgetamount,  --全年预算数
       a.amt3 as execratenum,  --调整后预算数
       a.amt4 as execamount, --预算执行数
       to_date(t.evalend, ''yyyymmdd'') -
       to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') warndays,
       decode(s.score,null,0,s.score) score,
       s.selfresult,
       s.warn
  from v_perf_t_selfevaltask t
    left join v_perf_t_selfperfdesc s on s.mainguid = t.guid
    left join (select mainguid,sum(amt1)as amt1, sum(amt3)as amt3, sum(amt4)as amt4 from v_perf_t_selfprofund group by mainguid) a on a.mainguid = t.guid
  where 1=1'
;

execute immediate '
create or replace view v_perf_t_selfperfindex as
select t.*
   from PERF_T_SELFPERFINDEX t
  where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

execute immediate '
create or replace view v_perf_t_selfperfopinion as
select t.*
 FROM perf_t_selfperfopinion T
    WHERE t.is_deleted=2 AND PROVINCE=global_multyear_cz.Secu_f_Global_Parm(''DIVID'')
    AND YEAR=global_multyear_cz.Secu_f_Global_Parm(''YEAR'')';

execute immediate '
create or replace view perf_v_selfperfopinionimp as
select '''' as pro_name,'''' as pro_code,'''' as agency_code,'''' as agency_name,'''' as content_remark,'''' as demonstration_remark,'''' as result_remark,'''' as opinionscore
 FROM dual';

execute immediate '
create or replace view v_perf_t_selfframe as
select *
       FROM perf_t_selfframe T
    WHERE t.is_deleted=2 AND PROVINCE=global_multyear_cz.Secu_f_Global_Parm(''DIVID'')
    AND YEAR=global_multyear_cz.Secu_f_Global_Parm(''YEAR'')';
