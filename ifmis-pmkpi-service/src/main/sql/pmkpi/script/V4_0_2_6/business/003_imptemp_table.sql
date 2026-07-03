
 i number;
begin
  select count(1) into i from user_tables t where t.table_name='PERF_T_IMPTEMP';
     if i=0 then
execute immediate 'create table PERF_T_IMPTEMP
(
  guid     VARCHAR2(40) not null,
  temptype VARCHAR2(40),
  datatype VARCHAR2(50),
  num      NUMBER(3),
  c1       VARCHAR2(500),
  c2       VARCHAR2(500),
  c3       VARCHAR2(500),
  c4       VARCHAR2(500),
  c5       VARCHAR2(500),
  c6       VARCHAR2(500),
  c7       VARCHAR2(500),
  c8       VARCHAR2(500),
  c9       VARCHAR2(500),
  c10      VARCHAR2(500),
  c11      VARCHAR2(500),
  c12      VARCHAR2(500),
  c13      VARCHAR2(500),
  c14      VARCHAR2(500),
  c15      VARCHAR2(500),
  c16      VARCHAR2(500),
  c17      VARCHAR2(500),
  c18      VARCHAR2(500),
  c19      VARCHAR2(500),
  c20      VARCHAR2(500),
  c21      VARCHAR2(500),
  c22      VARCHAR2(500),
  c23      VARCHAR2(500),
  c24      VARCHAR2(500),
  c25      VARCHAR2(500),
  year     VARCHAR2(4) not null,
  province VARCHAR2(9) not null
)';

execute immediate '
alter table PERF_T_IMPTEMP
  add constraint PK_PERF_IMPTEMP primary key (GUID, YEAR, PROVINCE)';
  
end if;

execute immediate '
create or replace view v_perf_t_imptemp as
select *
 from perf_t_imptemp t
 where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
';


