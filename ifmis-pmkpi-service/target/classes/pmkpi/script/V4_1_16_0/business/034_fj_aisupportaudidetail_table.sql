i number;
begin

--add col
select count(1) into i from user_tab_columns t where t.table_name='PERF_T_AISUPPORTAUDIDETAIL' and t.column_name='AUDIT_TYPE';
if i=0 then
   execute immediate 'alter table PERF_T_AISUPPORTAUDIDETAIL add AUDIT_TYPE VARCHAR2(4000)';
end if;

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_AISUPPORTAUDIDETAIL' and t.column_name='AUDIT_STANDARD';
if i=0 then
   execute immediate 'alter table PERF_T_AISUPPORTAUDIDETAIL add AUDIT_STANDARD VARCHAR2(4000)';
end if;

execute immediate '
CREATE OR REPLACE VIEW PERF_V_AISUPPORTAUDIDETAIL AS
SELECT * FROM PERF_T_AISUPPORTAUDIDETAIL t1
WHERE create_time = (
    SELECT MAX(create_time)
    FROM PERF_T_AISUPPORTAUDIDETAIL t2
    WHERE t2.pro_code = t1.pro_code 
      AND t2.province = t1.province 
      AND t2.year = t1.year
)
and t1.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') 
and t1.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')';