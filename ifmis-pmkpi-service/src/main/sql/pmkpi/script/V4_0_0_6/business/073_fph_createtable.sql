
  i integer;
begin
  --∆¿…Û±Ì
  select count(*) into i from user_tab_columns  t where t.TABLE_NAME='PERF_T_EVALUATEAUDIT';
  if i=0 then
     execute immediate '
     create table PERF_T_EVALUATEAUDIT
      (
        guid          VARCHAR2(40) not null,
        proguid       VARCHAR2(40),
        audittype     VARCHAR2(40),
        agencyguid    VARCHAR2(40),
        finintorgguid VARCHAR2(50),
        creater       VARCHAR2(32),
        createtime    VARCHAR2(20),
        updatetime    VARCHAR2(20),
        status        NUMBER(1),
        province      VARCHAR2(9) not null,
        year          CHAR(4) not null,
        opinion       VARCHAR2(4000),
        isaudit       VARCHAR2(40),
        oldopinion    VARCHAR2(40)
      )
      partition by list (PROVINCE)
      subpartition by list (YEAR)
      (
        partition P87 values (''87'')
        (
          subpartition P87_Y2016 values (''2016'')
        )
      )';
      execute immediate'alter table PERF_T_EVALUATEAUDIT 
      add constraint PK_PERF_T_EVALUATEAUDIT primary key (GUID,PROVINCE,YEAR) using index ';
    execute immediate 'create or replace view V_PERF_T_EVALUATEAUDIT as 
      select * FROM PERF_T_EVALUATEAUDIT T 
      WHERE T.PROVINCE = global_multyear_cz.Secu_f_Global_Parm(''DIVID'') 
      and T.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
      ';
end if;

