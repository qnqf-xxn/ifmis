
 
  i integer;
begin
  select count(1) into i from user_tables  t where t.TABLE_NAME='PERF_T_EXPDOCMAIN';
  if i=0 then
     execute immediate 'create table PERF_T_EXPDOCMAIN
        (
          guid         VARCHAR2(40) not null,
          templatecode VARCHAR2(50),
          templatename VARCHAR2(100),
          expfilename  VARCHAR2(50),
          exptype      VARCHAR2(40),
          iszip        VARCHAR2(40),
          ordernum     NUMBER(2),
          province     VARCHAR2(40),
          status       NUMBER(1)  default 1,
          createtime   VARCHAR2(17),
          updatetime   VARCHAR2(17),
          year         NUMBER(4)
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
    execute immediate 'alter table PERF_T_EXPDOCMAIN
		add constraint PK_PERF_EXPDOCMAIN primary key (GUID, YEAR, PROVINCE)';
  end if;
  
  select count(1) into i from user_tables  t where t.TABLE_NAME='PERF_T_EXPDOCSUB';
  if i=0 then
     execute immediate 'create table PERF_T_EXPDOCSUB
        (
          guid       VARCHAR2(40) not null,
          datakey    VARCHAR2(40),
          mainguid   VARCHAR2(40),
          ordernum   NUMBER(2),
          province   VARCHAR2(40),
          querytype  VARCHAR2(40) default 1,
          status     NUMBER(1)  default 1,
          tablecode  VARCHAR2(50),
          createtime VARCHAR2(17),
          updatetime VARCHAR2(17),
          wheresql   VARCHAR2(50),
          wholename  VARCHAR2(2000),
          year       NUMBER(4)
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
    execute immediate 'alter table PERF_T_EXPDOCSUB add constraint P_PERF_T_EXPDOCSUB primary key (GUID, YEAR, PROVINCE)';
    execute immediate 'create index INDEX_PERF_T_EXPDOCSUB on PERF_T_EXPDOCSUB (MAINGUID)';
  end if;


execute immediate 'create or replace view v_perf_t_expdocmain as
select *
 from PERF_T_EXPDOCMAIN T where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

execute immediate 'create or replace view v_perf_t_expdocsub as
select *
 from PERF_T_EXPDOCSUB T where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

