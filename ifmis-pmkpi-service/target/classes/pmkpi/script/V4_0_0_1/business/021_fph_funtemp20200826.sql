
 
  i integer;
begin
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_FUNDTEMP';
  if i=0 then
     execute immediate '
      create table PERF_T_FUNDTEMP
      (
        guid       VARCHAR2(40) not null,
        code       VARCHAR2(100),
        name       VARCHAR2(500),
        querysql   VARCHAR2(4000),
        sumcol     VARCHAR2(1000),
        updatetime VARCHAR2(17),
        createtime VARCHAR2(17),
        year       NUMBER(4),
        province   VARCHAR2(40),
        amt        NUMBER(18,2),
        fundtype   VARCHAR2(40),
        fundname   VARCHAR2(500),
        ordernum   NUMBER(3)
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
      execute immediate 'alter table PERF_T_FUNDTEMP
  add constraint PK_PERF_FUNDTEMP primary key (GUID)
  using index ';
  end if;



execute immediate 'create or replace view v_perf_t_fundtemp as
select * from perf_t_fundtemp where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

