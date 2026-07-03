i number;
begin
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_DEPTEVALUATION' and column_name = 'FUND_TYPE_CODE';
  if i = 0 then
     execute immediate 'alter table PERF_T_DEPTEVALUATION add FUND_TYPE_CODE VARCHAR2(40)';
  end if;
  


execute immediate '
create or replace view v_perf_t_deptevaluation as
select * from perf_t_deptevaluation
where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';


delete from  bus_t_diccolumn where COLUMNCODE = 'FUND_TYPE_CODE' and TABLECODE = 'PERF_T_DEPTEVALUATION';

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'JXFUNDTYPE', null, '1', 'FUND_TYPE_CODE', '1', '2016', '87', '08FF5D9CE3BF5B11E0630A64A8C06A0D', 'FUND_TYPE_CODE', 'PERF_T_DEPTEVALUATION', '资金来源', 'S', '40', null, 1, 1, null, sysdate);
