
  i number(2);
begin
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_HBTRACEREPORTUPLOAD';
  if i=0 then
     execute immediate '
      create table PERF_T_HBTRACEREPORTUPLOAD
      (
        guid          VARCHAR2(40) not null,
        name          VARCHAR2(200),
        code          VARCHAR2(200),
        linkman       VARCHAR2(50),
        telephone     VARCHAR2(30),
        taskguid      VARCHAR2(40),
        agencyguid    VARCHAR2(40),
        status        NUMBER(1),
        createtime    VARCHAR2(17) not null,
        updatetime    VARCHAR2(17) default to_char(sysdate,''yyyyMMddHH24miss''),
        creater       VARCHAR2(40) not null,
        province      VARCHAR2(32) not null,
        year          NUMBER(4) not null,
        finintorgguid VARCHAR2(40)
      )
      partition by list (PROVINCE)
      subpartition by list (YEAR)
      (
        partition P87 values (''87'')
          tablespace EFMIS
          pctfree 10
          initrans 1
          maxtrans 255
        (
          subpartition P87_Y2016 values (''2016'') tablespace EFMIS
        )
		)';
    execute immediate 'alter table PERF_T_HBTRACEREPORTUPLOAD
  add constraint PK_PERF_HBTRACEREPORTUPLOAD primary key (GUID, YEAR, PROVINCE)
  using index';
  end if;
  
  execute immediate 'create or replace view V_PERF_T_HBTRACEREPORTUPLOAD as 
select * from PERF_T_HBTRACEREPORTUPLOAD t
 where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
