
  i integer;
begin
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_QUESTION';
  if i=0 then
     execute immediate '
      create table PERF_T_QUESTION
      (
        guid         VARCHAR2(40) not null,
        code         VARCHAR2(50) not null,
        name         VARCHAR2(2000) not null,
        weight       NUMBER(3),
        explanation  VARCHAR2(2000),
        scorestand   VARCHAR2(2000),
        scoredetails VARCHAR2(4000),
        remark       VARCHAR2(2000),
        status       NUMBER(1),
        createtime   VARCHAR2(17),
        updatetime   VARCHAR2(17) not null,
        creater      VARCHAR2(40),
        province     VARCHAR2(40) not null,
        year         NUMBER(4) not null,
        ordernum     NUMBER(9),
        questtype    VARCHAR2(40),
        wfid         VARCHAR2(32) not null,
        nodeguid     VARCHAR2(40) not null
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
     execute immediate 'alter table PERF_T_QUESTION
  add constraint PK_PERF_T_QUESTION primary key (GUID, YEAR, PROVINCE)
  using index ';
  end if;

execute immediate 'create or replace view v_perf_t_question as
select * from PERF_T_QUESTION where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
