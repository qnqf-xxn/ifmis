 i number;
begin
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_PROINDEXTRACE' and t.column_name='GOALGUID';
     if i=0 then
       execute immediate 'alter table PERF_T_PROINDEXTRACE add GOALGUID varchar2(40)';
     end if;        

execute immediate '
create or replace view v_perf_t_proindextrace as
select * FROM PERF_T_PROINDEXTRACE 
WHERE province = global_multyear_cz.secu_f_global_parm(''DIVID'') and year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')';
