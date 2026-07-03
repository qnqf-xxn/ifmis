
i number;
begin
  
  select count(1) into i from user_tables t where t.table_name='PERF_T_BACKINFO';

  if i=0 then
    execute immediate '    
    create table PERF_T_BACKINFO
    (
      guid       VARCHAR2(38) not null,
      proguid    VARCHAR2(38) not null,
      pro_code   VARCHAR2(1000) not null,
      stage      VARCHAR2(1),
      wfstatus   VARCHAR2(10),
      backtype   VARCHAR2(1),
      opinion    VARCHAR2(4000),
      creater    VARCHAR2(32),
      createtime VARCHAR2(20) not null,
      updatetime VARCHAR2(20) not null,
      province   VARCHAR2(9) not null,
      year       VARCHAR2(4) not null
    )';

    execute immediate 'alter table PERF_T_BACKINFO add constraint PK_PERF_T_BACKINFO primary key (GUID, PROVINCE, YEAR)';
  end if;
  
execute immediate 'create or replace view v_perf_t_backinfo as
select *
 from perf_t_backinfo t
where YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
