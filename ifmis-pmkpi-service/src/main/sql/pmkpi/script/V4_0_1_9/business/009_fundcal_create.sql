--declare
 i integer;
begin
select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_FUNDCALINDEX';
  if i=0 then
     execute immediate '
create table perf_T_fundcalindex (
	GUID           VARCHAR2(40) not null,
  	INDEXGUID       VARCHAR2(40) not null,
	PROCODE 		VARCHAR2(40) not null,
	FUNDGUID		VARCHAR2(40) not null,
	YEAR			VARCHAR2(40),
	PROVINCE		VARCHAR2(40),
	CREATETIME		VARCHAR2(40),
	UPDATETIME		VARCHAR2(40),
	IS_DELETED		VARCHAR2(2)
)';
execute immediate 'alter table PERF_T_FUNDCALINDEX
  add constraint PERF_T_FUNDCALINDEX primary key (GUID)';
  
execute immediate '
CREATE OR REPLACE VIEW v_perf_T_fundcalindex AS
select * from perf_T_fundcalindex
where province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')';  

 end if;
 
--end; 