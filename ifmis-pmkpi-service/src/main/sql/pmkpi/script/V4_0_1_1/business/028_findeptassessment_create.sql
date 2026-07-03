i integer;
begin  
   
   select count(1) into i from user_tables t where t.table_name='PERF_T_DEPTSCORE';
	 if i=0 then
execute immediate '
create table PERF_T_DEPTSCORE
(
  guid       VARCHAR2(40) not null,
  selfscore  NUMBER(5,2),
  ratiscore  NUMBER(5,2),
  remark     VARCHAR2(4000),
  mainguid   VARCHAR2(40),
  proguid    VARCHAR2(40),
  tempguid   VARCHAR2(40),
  creater    VARCHAR2(40),
  createtime VARCHAR2(17),
  updatetime VARCHAR2(17),
  year       VARCHAR2(4) not null,
  province   VARCHAR2(9) not null,
  status     NUMBER(1),
  name       VARCHAR2(100),
  explain    VARCHAR2(1000),
  evalstd    VARCHAR2(2000),
  score      NUMBER(5,2),
  isdeptadd  VARCHAR2(1),
  ordernum   NUMBER(9),
  superid    VARCHAR2(40),
  levelno    NUMBER(2),
  isleaf     NUMBER(1)
)
partition by list (PROVINCE)
subpartition by list (YEAR)
(
  partition P87 values (''87'')
    pctfree 10
    initrans 1
    maxtrans 255
  (
    subpartition P87_Y2016 values (''2016'')
  )
)';
execute immediate 'alter table PERF_T_DEPTSCORE
  add constraint PK_PERF_DEPTSCORE primary key (GUID, YEAR, PROVINCE)
  using index ';
  end if;

   select count(1) into i from user_tab_cols t where t.table_name='PERF_T_EVALUATETEMP' and t.column_name='ISEDIT';
     if i=0 then
       execute immediate 'alter table PERF_T_EVALUATETEMP add ISEDIT varchar2(1)';
   end if;
   
execute immediate '
create or replace view v_perf_t_evaluatetemp as
select *
from PERF_T_EVALUATETEMP t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';


execute immediate '
create or replace view v_perf_t_deptscore as
select *
from perf_t_deptscore where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
 and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
