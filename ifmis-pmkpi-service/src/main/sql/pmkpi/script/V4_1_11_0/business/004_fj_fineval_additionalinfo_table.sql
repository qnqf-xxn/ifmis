i number;
begin

--财政评价新增页签 【评价补充信息】
select count(*) into i from user_tables t where t.table_name ='PERF_T_EVALADDITIONALINFO';
if i=0 then
execute immediate '
create table PERF_T_EVALADDITIONALINFO
(
  guid               VARCHAR2(40) not null,
  mainguid           VARCHAR2(40),
  evaledagency       VARCHAR2(4000),
  evalscore          VARCHAR2(40),
  otherinfo          VARCHAR2(4000),
  v_col1             VARCHAR2(40),
  v_col2             VARCHAR2(40),
  v_col3             VARCHAR2(40),
  v_col4             VARCHAR2(40),
  v_col5             VARCHAR2(40),
  is_deleted         VARCHAR2(40) not null,
  creater            VARCHAR2(40),
  createtime         VARCHAR2(17),
  updatetime         VARCHAR2(17),
  year               VARCHAR2(4) not null,
  province           VARCHAR2(32) not null
)';
execute immediate '
alter table PERF_T_EVALADDITIONALINFO add constraint PK_PERF_T_EVALADDITIONALINFO primary key (GUID, YEAR, PROVINCE)';
end if;

--评价补充信息视图
execute immediate '
create or replace view V_PERF_T_EVALADDITIONALINFO as
select * from PERF_T_EVALADDITIONALINFO
WHERE province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') AND year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and is_deleted = 2';