i integer;
begin
  select count(*) into i from user_tables t where t.TABLE_NAME='PERF_FILE';
  if i=0 then
     execute immediate '
  create table PERF_FILE
  (
    guid        VARCHAR2(40) not null,
    billguid    VARCHAR2(40) not null,
    fileguid    VARCHAR2(40) not null,
    filename    VARCHAR2(500) not null,
    province    VARCHAR2(9) not null,
    year        CHAR(4) not null,
    creater     VARCHAR2(40),
    creatername VARCHAR2(100),
    filetype    VARCHAR2(40),
    url         VARCHAR2(255),
    update_time VARCHAR2(18),
    create_time VARCHAR2(18)
  )
  partition by list (PROVINCE)
  subpartition by list (YEAR)
  (
    partition P87 values (''87'')
      pctfree 10
      initrans 1
      maxtrans 255
    (
      subpartition P87_Y2016 values (''2016'')
    )
  )';
  execute immediate 'alter table PERF_FILE
  add constraint PK_PERF_FILE primary key (GUID)
  using index ';
  execute immediate 'create index INDX_PERF_FLGUID on PERF_FILE (fileguid)';
end if;

execute immediate '
create or replace view v_PERF_file as
select * from PERF_FILE t  where year= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';