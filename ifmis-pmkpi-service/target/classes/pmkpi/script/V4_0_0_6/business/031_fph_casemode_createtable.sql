
  i integer;
begin
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_MODEL' and t.column_name='ISMODEL';
  if i=0 then
     execute immediate 'alter table PERF_T_MODEL add ismodel VARCHAR2(40)';
      insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
      values (null, null, null, '1', 'ISMODEL', '1', '2016', '87', 'B98C5CF463803BE1E053B11FA8C0A9CE', 'ISMODEL', 'PERF_T_MODEL', '是否模板', 'S', '40', null, 1, 1, null, sysdate);

  end if;

  --案例模板绩效目标表
  select count(*) into i from user_tab_columns  t where t.TABLE_NAME='PERF_T_CASEMODELGOAL';
  if i=0 then
     execute immediate '
     create table PERF_T_CASEMODELGOAL
      (
        guid          VARCHAR2(40) not null,
        agencyguid    VARCHAR2(40),
        zqgoal        VARCHAR2(4000),
        ndgoal        VARCHAR2(4000),
        mainguid      VARCHAR2(40),
        createtime    VARCHAR2(17) not null,
        updatetime    VARCHAR2(17),
        creater       VARCHAR2(40) not null,
        province      VARCHAR2(40) not null,
        year          NUMBER(4) not null,
        finintorgguid VARCHAR2(40),
        status        NUMBER(1),
        framesystem   VARCHAR2(40),
        kpitarget     VARCHAR2(4000)
      )
      partition by list (PROVINCE)
      subpartition by list (YEAR)
      (
        partition P87 values (''87'')
        (
          subpartition P87_Y2016 values (''2016'')
        )
      )';

      execute immediate'alter table PERF_T_CASEMODELGOAL 
        add constraint PK_PERF_T_CASEMODELGOAL primary key (GUID, YEAR, PROVINCE)
        using index';
        
      execute immediate 'create or replace view V_PERF_T_CASEMODELGOAL as 
      select * FROM PERF_T_CASEMODELGOAL T 
      WHERE T.PROVINCE = global_multyear_cz.Secu_f_Global_Parm(''DIVID'')';
      
end if;

execute immediate 'create or replace view V_PERF_T_MODEL as 
      select * FROM PERF_T_MODEL T 
      WHERE T.PROVINCE = global_multyear_cz.Secu_f_Global_Parm(''DIVID'')';
      
execute immediate 'create or replace view V_PERF_T_CASE as 
      select * FROM PERF_T_CASE T 
      WHERE T.PROVINCE = global_multyear_cz.Secu_f_Global_Parm(''DIVID'')';
      
      
execute immediate 'create or replace view V_PERF_T_CASEMODELINDEX as 
      select * FROM PERF_T_CASEMODELINDEX T 
      WHERE T.PROVINCE = global_multyear_cz.Secu_f_Global_Parm(''DIVID'')';
      




