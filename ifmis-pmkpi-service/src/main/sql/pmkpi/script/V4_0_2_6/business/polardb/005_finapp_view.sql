 i number;
begin
  select count(1) into i from user_tables t where t.table_name='PERF_T_FINAPPLICATION';
     if i=0 then
execute immediate '
create table PERF_T_FINAPPLICATION
(
	GUID        VARCHAR2(40),
	FINGUID		VARCHAR2(40),
	CODE		VARCHAR2(40),
	CONTENTS	VARCHAR2(2000),
	YEAR		VARCHAR2(40),
	PROVINCE 	VARCHAR2(40)
)';

end if;

execute immediate '
CREATE OR REPLACE VIEW V_PERF_T_FINAPPLICATION
 AS
 SELECT * FROM PERF_T_FINAPPLICATION
  WHERE year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

execute immediate 'CREATE OR REPLACE VIEW V_PERF_T_FINAPP
 AS
 --固定根据区划年度进行维护，program-项目；dept-部门 以下为示例
select * from (
select ''2021'' as year,''330000000'' as province,''1'' as guid,''1'' as code,''是否被政府确认'' as name,''program'' as bustype from dual
union all
select ''2021'' as year,''330000000'' as province,''2'' as guid,''2'' as code,''是否发起调整'' as name,''dept'' as bustype from dual
union all
select ''2022'' as year,''330000000'' as province,''3'' as guid,''3'' as code,''是否发起整改'' as name,''program'' as bustype from dual
) where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'');
';



