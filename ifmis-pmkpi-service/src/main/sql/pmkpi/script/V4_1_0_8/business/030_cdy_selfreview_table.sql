
 i number;
begin
  
select count(1) into i from user_tables t where t.table_name = 'PERF_T_SELFREVIEWTASK';
if i=0 then
execute immediate '
create table PERF_T_SELFREVIEWTASK
(
  guid                VARCHAR2(40) not null,
  code                VARCHAR2(40),
  name                NVARCHAR2(1000),
  evalstatus          NUMBER(1),
  evalstart           VARCHAR2(17),
  evalend             VARCHAR2(17),
  c1                  NUMBER(18,2),
  c2                  NUMBER(18,2),
  c3                  NUMBER(18,2),
  c4                  NUMBER(18,2),
  c5                  NUMBER(18,2),
  c6                  NUMBER(18,2),
  c7                  NUMBER(18,2),
  c8                  NUMBER(18,2),
  c9                  NUMBER(18,2),
  c10                 NUMBER(18,2),
  c11                 NUMBER(18,2),
  c12                 NUMBER(18,2),
  c13                 NUMBER(18,2),
  agencyguid          VARCHAR2(40),
  wfstatus            VARCHAR2(40),
  status              NUMBER(1),
  createtime          VARCHAR2(17) not null,
  updatetime          VARCHAR2(17),
  creater             VARCHAR2(40) not null,
  province            VARCHAR2(32) not null,
  year                NUMBER(4) not null,
  ordernum            NUMBER(9),
  finintorgguid       VARCHAR2(40),
  wfid                VARCHAR2(40),
  auditor             VARCHAR2(32),
  lastupdatetime      VARCHAR2(17),
  month               VARCHAR2(40),
  perfgoalguid        VARCHAR2(40),
  projguid            VARCHAR2(40),
  bustype             VARCHAR2(40),
  prokind             VARCHAR2(40),
  remainingdays       VARCHAR2(40),
  is_deleted          NUMBER(1) default 2,
  pro_code            VARCHAR2(40),
  bgtget              NUMBER(5,2),
  manage_dept_code    VARCHAR2(200),
  manage_mof_dep_code VARCHAR2(200),
  mof_dep_code        VARCHAR2(200),
  dept_code           VARCHAR2(200),
  pro_lev             VARCHAR2(40),
  pro_total_amt       NUMBER(20,2),
  bgtamt              NUMBER(20,2),
  budgetamount        NUMBER(20,2),
  execamount          NUMBER(20,2),
  projectkind         VARCHAR2(32),
  pro_levone_code     VARCHAR2(21),
  v_colk1             VARCHAR2(40),
  v_colk2             VARCHAR2(40),
  v_colk3             VARCHAR2(40),
  v_colk4             VARCHAR2(100),
  v_colk5             VARCHAR2(100),
  provincetask        VARCHAR2(1) default 2,
  arrangercreater     VARCHAR2(40),
  selfproguid         VARCHAR2(40)
)';
execute immediate '
alter table PERF_T_SELFREVIEWTASK
  add constraint PK_PERF_SELFREVIEWTASK primary key (GUID, PROVINCE, YEAR)';

end if;

execute immediate '
create or replace view v_perf_t_selfreviewtask as
select *
  from perf_t_selfreviewtask t
 where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted = 2';

execute immediate '
create or replace view v_perf_selfreviewproject_check as
select t.*
  from v_perf_t_selfevaltask t
 where t.wfstatus=''011'' and t.bustype=''program'''
;
