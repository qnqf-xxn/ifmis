
 i number;
begin
  
select count(*) into i from user_tables t where t.table_name ='PERF_T_PROSUBMOFDIV';
if i=0 then
  execute immediate '
create table perf_t_prosubmofdiv
(
  guid                VARCHAR2(40) not null,
  pro_code            VARCHAR2(200),
  submofdivcode       varchar2(4000),           
  createtime          VARCHAR2(17) not null,
  updatetime          VARCHAR2(17) not null,
  creater             VARCHAR2(40) not null,
  province            VARCHAR2(32) not null,
  year                NUMBER(4) not null
)';

execute immediate '
alter table perf_t_prosubmofdiv
  add constraint pk_perf_t_prosubmofdiv primary key (GUID, YEAR, PROVINCE)';

end if;

execute immediate '
create or replace view v_perf_t_prosubmofdiv as
select *
      from perf_t_prosubmofdiv
     where province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
       and year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')';

execute immediate '
create or replace view v_perf_traindex_province as
select a.submofdivcode,a.pro_code from v_perf_t_prosubmofdiv a
union
select b.sub_mof_div_code as sub_mof_div_code,b.pro_code from v_bgt_tra b where b.is_deleted=2';
