
 i number;
begin
  
select count(1) into i from user_tables t where t.table_name = 'PERF_T_BEFOREVIEW';
if i=0 then
    execute immediate '
create table PERF_T_BEFOREVIEW
(
  guid       VARCHAR2(40) not null,
  mainguid   VARCHAR2(40),
  pro_code   VARCHAR2(40),
  agencyguid VARCHAR2(40),
  is_deleted NUMBER(1),
  creater    VARCHAR2(40),
  status     NUMBER(1),
  createtime VARCHAR2(17),
  updatetime VARCHAR2(17),
  year       VARCHAR2(4) not null,
  province   VARCHAR2(9) not null,
  text1      VARCHAR2(4000),
  text2      VARCHAR2(4000),
  text3      VARCHAR2(4000),
  text4      VARCHAR2(4000),
  text5      VARCHAR2(4000),
  text6      VARCHAR2(4000),
  text7      VARCHAR2(4000),
  text8      VARCHAR2(4000),
  text9      VARCHAR2(4000),
  text10     VARCHAR2(4000),
  text11     VARCHAR2(4000),
  text12     VARCHAR2(4000),
  text13     VARCHAR2(4000),
  text14     VARCHAR2(4000),
  text15     VARCHAR2(4000),
  text16     VARCHAR2(4000),
  text17     VARCHAR2(4000),
  text18     VARCHAR2(4000),
  text19     VARCHAR2(4000),
  text20     VARCHAR2(4000),
  text21     VARCHAR2(4000),
  text22     VARCHAR2(4000),
  text23     VARCHAR2(4000),
  text24     VARCHAR2(4000),
  text25     VARCHAR2(4000)
)';
execute immediate '
alter table PERF_T_BEFOREVIEW
  add constraint PK_PERF_BEFOREVIEW primary key (GUID, YEAR, PROVINCE)';

end if;

execute immediate '
create or replace view v_perf_t_beforeview as 
select * 
from perf_t_beforeview t where t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted=2';
