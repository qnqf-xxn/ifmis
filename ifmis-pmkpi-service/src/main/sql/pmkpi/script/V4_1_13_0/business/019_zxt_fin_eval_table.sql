  i number;
begin

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_FINEVALUATION' and t.column_name='EVAL_AMT';
if i=0 then
   execute immediate 'ALTER TABLE PERF_T_FINEVALUATION ADD EVAL_AMT NUMBER(20,2)';
end if;


select count(1) into i from user_tab_columns t where t.table_name='PERF_T_FINEVALUATION' and t.column_name='EVAL_TYPE';
if i=0 then
   execute immediate 'ALTER TABLE PERF_T_FINEVALUATION ADD EVAL_TYPE VARCHAR2(400)';
end if;

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_FINEVALUATION' and t.column_name='REMARK';
if i=0 then
   execute immediate 'ALTER TABLE PERF_T_FINEVALUATION ADD REMARK VARCHAR2(4000)';
end if;

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_FINEVALUATION' and t.column_name='EVAL_SCORE';
if i=0 then
   execute immediate 'ALTER TABLE PERF_T_FINEVALUATION ADD EVAL_SCORE NUMBER(20,2)';
end if;

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_FINEVALUATION' and t.column_name='EVAL_TARGET';
if i=0 then
   execute immediate 'ALTER TABLE PERF_T_FINEVALUATION ADD EVAL_TARGET VARCHAR2(4000)';
end if;

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_FINEVALUATION' and t.column_name='EVAL_LEVLO';
if i=0 then
   execute immediate 'ALTER TABLE PERF_T_FINEVALUATION ADD EVAL_LEVLO VARCHAR2(40)';
end if;

execute immediate 'create or replace view v_perf_t_finevaluation as
select * from PERF_T_FINEVALUATION t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
            and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
