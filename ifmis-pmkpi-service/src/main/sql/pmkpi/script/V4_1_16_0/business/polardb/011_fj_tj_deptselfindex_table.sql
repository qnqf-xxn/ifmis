  i number;
  j number;
  v_sql varchar2(2000);
  ln_i integer;
begin

select count(*) into i from user_tables t where t.table_name ='PERF_T_SELFPERFGOAL';
if i=0 then
execute immediate '
create table PERF_T_SELFPERFGOAL
(
  guid           VARCHAR2(40) not null,
  agencyguid     VARCHAR2(40),
  zqgoal         VARCHAR2(4000),
  ndgoal         VARCHAR2(4000),
  mainguid       VARCHAR2(40),
  createtime     VARCHAR2(17),
  updatetime     VARCHAR2(17),
  creater        VARCHAR2(40),
  province       VARCHAR2(40) not null,
  year           NUMBER(4) not null,
  kpi_dep_id     VARCHAR2(38),
  mof_div_code   VARCHAR2(9),
  fiscal_year    VARCHAR2(4),
  dept_code      VARCHAR2(21),
  kpi_target     VARCHAR2(2000),
  update_time    VARCHAR2(17),
  is_deleted     NUMBER(1) default 2 not null,
  create_time    VARCHAR2(17),
  adj_batch_no   VARCHAR2(6),
  busi_type_code VARCHAR2(6),
  remark         VARCHAR2(2000),
  yearflag       VARCHAR2(1),
  ordernum       NUMBER(4),
  goalname       VARCHAR2(100),
  ratio          NUMBER(4,1),
  weightscore    NUMBER(20,2),
  actual_comp    VARCHAR2(2000),
  deviationanaly VARCHAR2(2000)
)';
end if;

if i=1 then
	select count(1) into j from user_tab_columns t where t.table_name='PERF_T_SELFPERFGOAL' and t.column_name='ACTUAL_COMP';
	if j=0 then
	   execute immediate 'alter table PERF_T_SELFPERFGOAL add ACTUAL_COMP VARCHAR2(2000)';
	end if;
	
	select count(1) into j from user_tab_columns t where t.table_name='PERF_T_SELFPERFGOAL' and t.column_name='DEVIATIONANALY';
	if j=0 then
	   execute immediate 'alter table PERF_T_SELFPERFGOAL add DEVIATIONANALY VARCHAR2(2000)';
	end if;
	
end if;

v_sql :='create or replace view V_PERF_T_SELFPERFGOAL as
select * from PERF_T_SELFPERFGOAL t
where YEAR = global_multyear_cz.v_pmyear and PROVINCE = global_multyear_cz.v_pmdivid';
select fn_alterview('V_PERF_T_SELFPERFGOAL',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;
