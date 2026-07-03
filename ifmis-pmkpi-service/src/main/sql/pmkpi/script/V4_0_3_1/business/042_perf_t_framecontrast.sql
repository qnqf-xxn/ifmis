
i number;
begin
  select count(1) into i from user_tables where table_name = 'PERF_T_FRAMECONTRAST';
  if i = 0 then
    execute immediate '
      create table PERF_T_FRAMECONTRAST
      (
        guid         VARCHAR2(40),
        oldfindex    VARCHAR2(300),
        oldsindex    VARCHAR2(300),
        newfindex    VARCHAR2(300),
        newsindex    VARCHAR2(300),
        frametype    VARCHAR2(40),
        contrastyear VARCHAR2(4),
        year         VARCHAR2(4) not null,
        province     VARCHAR2(9) not null
      )';
    execute immediate '
      alter table PERF_T_FRAMECONTRAST
        add constraint PK_PERF_FRAMECONTRAST primary key (GUID,YEAR, PROVINCE)';
    
    execute immediate 'comment on column PERF_T_FRAMECONTRAST.guid
      is ''sys_guid()随机生成''';
    execute immediate 'comment on column PERF_T_FRAMECONTRAST.oldfindex
      is ''历史年度一级指标编码''';
    execute immediate 'comment on column PERF_T_FRAMECONTRAST.oldsindex
      is ''历史年度二级指标编码''';
    execute immediate 'comment on column PERF_T_FRAMECONTRAST.newfindex
      is ''查询数据年度一级指标编码''';
    execute immediate 'comment on column PERF_T_FRAMECONTRAST.newsindex
      is ''查询数据年度二级指标编码''';
    execute immediate 'comment on column PERF_T_FRAMECONTRAST.frametype
      is ''指标类型''';
    execute immediate 'comment on column PERF_T_FRAMECONTRAST.contrastyear
      is ''历史数据年度''';
    execute immediate 'comment on column PERF_T_FRAMECONTRAST.year
      is ''年度''';
    execute immediate 'comment on column PERF_T_FRAMECONTRAST.province
      is ''区划''';

  end if;

execute immediate '
create or replace view v_perf_t_framecontrast as
select *
from perf_t_framecontrast
where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
      and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
