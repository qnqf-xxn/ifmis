  i number;
begin

select count(*) into i from user_tables t where t.TABLE_NAME='PERF_T_JXY_INDICATOR';
if i = 0 then
    execute immediate '	
		create table PERF_T_JXY_INDICATOR
		(
		  ind_id      VARCHAR2(40) not null,
		  mainguid    VARCHAR2(40),
		  pro_code    VARCHAR2(40),
		  ind_code1   VARCHAR2(40),
		  ind_name1   VARCHAR2(40),
		  ind_code2   VARCHAR2(40),
		  ind_name2   VARCHAR2(40),
		  ind_code3   VARCHAR2(40),
		  ind_name3   VARCHAR2(40),
		  kpi_score   NUMBER(20,2),
		  kpi_content VARCHAR2(2000),
		  kpi_evalstd VARCHAR2(2000),
		  year        VARCHAR2(40),
		  province	  VARCHAR2(40)
		)
	';
	execute immediate 'alter table PERF_T_JXY_INDICATOR
	  add constraint PK_PERF_T_JXY_INDICATOR primary key (ind_id)';
end if;
  
  
execute immediate '  
  CREATE OR REPLACE VIEW V_PERF_T_JXY_INDICATOR AS
SELECT * FROM
    PERF_T_JXY_INDICATOR
WHERE
    YEAR = GLOBAL_MULTYEAR_CZ.SECU_F_GLOBAL_PARM(''YEAR'')
	AND PROVINCE = GLOBAL_MULTYEAR_CZ.SECU_F_GLOBAL_PARM(''DIVID'')
';