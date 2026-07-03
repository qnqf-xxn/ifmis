 
  i integer;
begin
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_SYSTEMSET';
  if i=0 then
     execute immediate '
      create table PERF_T_SYSTEMSET
      (
        guid       VARCHAR2(40) not null,
        paramcode  VARCHAR2(100) not null,
        paramname  VARCHAR2(200),
        paramvalue VARCHAR2(1000) not null,
        remark     VARCHAR2(2000) not null,
        appid      VARCHAR2(10),
        ordernum   NUMBER(5) not null,
        year       NUMBER(4) not null,
        province   VARCHAR2(32),
        status     NUMBER(1)
      )
      partition by list (PROVINCE)
      subpartition by list (YEAR)
      (
        partition P87 values (''87'')
        (
          subpartition P87_Y2016 values (''2016'')
        )
      )';
      execute immediate 'alter table PERF_T_SYSTEMSET
        add constraint PERF_T_SYSTEMSET primary key (GUID, YEAR, PROVINCE)
        using index ';
  end if;

execute immediate '
create or replace view v_PERF_T_SYSTEMSET as 
select * from PERF_T_SYSTEMSET where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
