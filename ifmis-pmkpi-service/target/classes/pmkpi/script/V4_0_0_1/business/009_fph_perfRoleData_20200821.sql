
 
  i integer;
begin
  select count(*) into i from user_tables  t where t.TABLE_NAME='PMKPI_T_DATARULE';
  if i=0 then
     execute immediate '
      create table PMKPI_T_DATARULE
      (
        guid       VARCHAR2(32) not null,
        name       VARCHAR2(100),
        appid      VARCHAR2(10),
        wheresql   VARCHAR2(2000),
        createtime VARCHAR2(17),
        updatetime VARCHAR2(17),
        status     NUMBER(1),
        isprivate  NUMBER(1) default 0 not null,
        province   VARCHAR2(32),
        year       NUMBER(4) default 0 not null
      )';
  end if;


  select count(*) into i from user_tables  t where t.TABLE_NAME='PMKPI_T_ROLEDATARULE';
  if i=0 then
     execute immediate '
      create table PMKPI_T_ROLEDATARULE
      (
        guid         VARCHAR2(40) not null,
        roleguid     VARCHAR2(40),
        menuguid     VARCHAR2(40),
        createtime   VARCHAR2(17),
        updatetime   VARCHAR2(17),
        status       NUMBER(1),
        province     VARCHAR2(40),
        year         NUMBER(4),
        appid        VARCHAR2(10),
        dataruleguid VARCHAR2(40)
      )
      partition by list (PROVINCE)
      subpartition by list (YEAR)
      (
        partition P87 values (''87'')
        (
          subpartition P87_Y2016 values (''2016'') 
        )
      )';
  end if;
  
execute immediate '
create or replace view v_pmkpi_t_roledatarule as
select * from Pmkpi_t_Roledatarule where province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
 and year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')';

