i number;
begin
 select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_ADJUSTFUNCTION';
  if i=0 then
   execute immediate '
      create table PERF_T_ADJUSTFUNCTION
      (
        guid          VARCHAR2(40) not null,
        code          VARCHAR2(100),
        name          VARCHAR2(200),
        isuse         VARCHAR2(2),
        findex        VARCHAR2(40),
        mainguid      VARCHAR2(40),
        agencyguid    VARCHAR2(40),
        wfstatus      VARCHAR2(40),
        status        NUMBER(1),
        createtime    VARCHAR2(17) not null,
        updatetime    VARCHAR2(17),
        creater       VARCHAR2(40) not null,
        province      VARCHAR2(32) not null,
        year          NUMBER(4) not null,
        ordernum      NUMBER(9),
        finintorgguid VARCHAR2(40),
        wfid          VARCHAR2(40)
      )';
  execute immediate'
    alter table PERF_T_ADJUSTFUNCTION
      add constraint PERF_T_ADJUSTFUNCTION primary key (GUID, YEAR, PROVINCE)';
 --÷ÿππ ”Õº
  execute immediate '
    create or replace view v_perf_t_adjustfunction as
    select t.*
    from PERF_T_ADJUSTFUNCTION t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
      and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
end if;
