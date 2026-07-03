  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin  
select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_PROAUDITMARK';
  if i=0 then
   execute immediate '
create table PERF_T_PROAUDITMARK
(
  guid           VARCHAR2(32) not null,
  pro_id         VARCHAR2(38),
  pro_code       VARCHAR2(21),
  create_time    VARCHAR2(14),
  update_time    VARCHAR2(14),
  province       VARCHAR2(9) not null,
  year           CHAR(4) not null,
  is_audit       VARCHAR2(2),    --是否审核
  creater    VARCHAR2(32)
)';

-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PERF_T_PROAUDITMARK
  add constraint PK_PERF_T_PROAUDITMARK primary key (GUID, YEAR, PROVINCE)';
end if;  

  --重构视图
  v_sql :='
create or replace view V_PERF_T_PROAUDITMARK as
select *
from PERF_T_PROAUDITMARK
where year = global_multyear_cz.v_pmyear
and province = global_multyear_cz.v_pmdivid';
	select fn_alterview('V_PERF_T_PROAUDITMARK',v_sql) into ln_i;
	if ln_i = 0 then
	    return;
	end if;	  
