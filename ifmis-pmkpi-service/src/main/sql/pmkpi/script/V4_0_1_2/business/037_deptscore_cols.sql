
i integer;
begin  

	select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_TMP_EVALUATETEMP';
  if i=0 then
     execute immediate '
create global temporary table PERF_TMP_EVALUATETEMP
(
  guid       VARCHAR2(40) not null,
  code       VARCHAR2(50),
  name       VARCHAR2(100),
  explain    VARCHAR2(1000),
  evalstd    VARCHAR2(2000),
  score      NUMBER(5,2),
  selfscore  NUMBER(5,2),
  ratiscore  NUMBER(5,2),
  creater    VARCHAR2(38),
  status     VARCHAR2(32),
  mainguid   VARCHAR2(38),
  remark     VARCHAR2(4000),
  bustype    VARCHAR2(40),
  audittype  VARCHAR2(40),
  createtime VARCHAR2(17),
  updatetime VARCHAR2(17),
  year       VARCHAR2(4) not null,
  province   VARCHAR2(9) not null,
  levelno    NUMBER(2),
  isleaf     NUMBER(1),
  superid    VARCHAR2(40),
  ordernum   NUMBER(9),
  isadd      VARCHAR2(1),
  isedit     VARCHAR2(1),
  querysql   VARCHAR2(4000)
)
on commit delete rows';
	end if;
	
   select count(1) into i from user_tab_cols t where t.table_name='PERF_T_DEPTSCORE' and t.column_name='TYPE';
     if i=0 then
       execute immediate 'alter table PERF_T_DEPTSCORE add type varchar2(32)';
   end if;

execute immediate '
create or replace view v_perf_t_deptscore as
select *
from perf_t_deptscore where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
 and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
