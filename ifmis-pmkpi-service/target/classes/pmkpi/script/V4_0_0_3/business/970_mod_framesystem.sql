i integer;
begin
  select count(*)
    into i
    from user_tables
   where table_name = upper('PERF_T_FRAMESYSTEM');
   if i > 0 then
     execute immediate 'drop table PERF_T_FRAMESYSTEM';
   end if;
   execute immediate '
   create table PERF_T_FRAMESYSTEM
    (
      ele_id       VARCHAR2(38) default SYS_GUID() not null,
      ele_code     VARCHAR2(20),
      ele_name     VARCHAR2(100),
      mof_div_code VARCHAR2(9) default 87,
      parent_id    VARCHAR2(38) default 00,
      level_no     NUMBER(2) default 1,
      is_leaf      NUMBER(1) default 1,
      ordernum     NUMBER(9),
      remark       VARCHAR2(2000),
      start_date   VARCHAR2(17) default TO_CHAR(SYSDATE,''YYYYMMDD''),
      end_date     VARCHAR2(17) default TO_CHAR(TO_DATE(''29991231'',''YYYYMMDD'')),
      is_enabled   NUMBER(1) default 1,
      update_time  VARCHAR2(17) default TO_CHAR(SYSDATE,''YYYYMMDD''),
      is_deleted   NUMBER(1) default 2,
      create_time  VARCHAR2(17) default TO_CHAR(SYSDATE,''YYYYMMDD''),
      fiscal_year  VARCHAR2(4),
      year         NUMBER(4) not null,
      province     VARCHAR2(9) not null
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
    )
   ';
    execute immediate 'alter table PERF_T_FRAMESYSTEM
    add constraint PK_PERF_FRAMESYSTEM primary key (ele_id, PROVINCE, YEAR,IS_DELETED)
    using index';
    execute immediate'
    create or replace view v_perf_t_framesystem as
select
        t.ele_code as guid,
        t.ele_code as code,
        t.ele_name as name,
        t.parent_id as superid,
        t.level_no as levelno,
        t.is_leaf as isleaf,
       t.mof_div_code,
       1 status,
       t.ordernum,
       t.remark,
       t.start_date,
       t.end_date,
       t.is_enabled,
       t.update_time,
       t.is_deleted,
       t.create_time,
       t.fiscal_year,
       t.year,t.province
 FROM perf_t_framesystem T
    WHERE T.IS_DELETED=2 AND PROVINCE=global_multyear_cz.Secu_f_Global_Parm(''DIVID'')
    AND YEAR=global_multyear_cz.Secu_f_Global_Parm(''YEAR'')
    ';