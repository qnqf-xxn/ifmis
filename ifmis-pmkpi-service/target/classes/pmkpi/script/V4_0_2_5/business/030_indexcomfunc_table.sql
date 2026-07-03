i number;

begin

select count(*) into i from user_tables t where t.TABLE_NAME='PERF_T_INDEXCOMFUNC';
if i = 0 then
    execute immediate '
         create table PERF_T_INDEXCOMFUNC
    (
      guid       VARCHAR2(64) not null,
      code       VARCHAR2(100),
      name       VARCHAR2(200),
      status     NUMBER(1),
      createtime VARCHAR2(17),
      updatetime VARCHAR2(17),
      year       NUMBER(4),
      province   VARCHAR2(9) not null,
      version    NUMBER(9),
      superid    VARCHAR2(38),
      levelno    NUMBER(2) default 1,
      isleaf     NUMBER(1) default 1,
      remark     VARCHAR2(4000),
      creater    VARCHAR2(40),
      ordernum   NUMBER(9),
      dept       VARCHAR2(17),
      agencyguid VARCHAR2(17),
      proelement VARCHAR2(17)
    )
    ';
    execute immediate 'comment on column PERF_T_INDEXCOMFUNC.proelement is ''项目分类：01项目支出02转移支付''';
    execute immediate 'alter table PERF_T_INDEXCOMFUNC add constraint PK_PERF_INDEXCOMFUNC primary key (GUID,province)';
end if;

select count(1) into i from user_tab_columns t where t.table_name ='PERF_T_INDEXCOMFUNC' and t.column_name ='ORDERNUM';
 if i = 0 then
   execute immediate 'alter table PERF_T_INDEXCOMFUNC add ORDERNUM NUMBER(9)';
 end if;
select count(1) into i from user_tab_columns t where t.table_name ='PERF_T_INDEXCOMFUNC' and t.column_name ='DEPT';
 if i = 0 then
   execute immediate 'alter table PERF_T_INDEXCOMFUNC add DEPT VARCHAR2(40)';
 end if;
select count(1) into i from user_tab_columns t where t.table_name ='PERF_T_INDEXCOMFUNC' and t.column_name ='AGENCYGUID';
 if i = 0 then
   execute immediate 'alter table PERF_T_INDEXCOMFUNC add AGENCYGUID VARCHAR2(40)';
 end if;
select count(1) into i from user_tab_columns t where t.table_name ='PERF_T_INDEXCOMFUNC' and t.column_name ='PROELEMENT';
 if i = 0 then
   execute immediate 'alter table PERF_T_INDEXCOMFUNC add PROELEMENT VARCHAR2(40)';
 end if;
select count(1) into i from user_tab_columns t where t.table_name ='PERF_T_INDEXCOMFUNC' and t.column_name ='CREATER';
 if i = 0 then
   execute immediate 'alter table PERF_T_INDEXCOMFUNC add CREATER VARCHAR2(40)';
 end if;
select count(1) into i from user_tab_columns t where t.table_name ='PERF_T_INDEXCOMFUNC' and t.column_name ='REMARK';
 if i = 0 then
   execute immediate 'alter table PERF_T_INDEXCOMFUNC add REMARK VARCHAR2(4000)';
 end if;

execute immediate '
CREATE OR REPLACE VIEW V_PERF_T_INDEXCOMFUNC AS
SELECT
    *
FROM
    PERF_T_INDEXCOMFUNC
WHERE
     PROVINCE = GLOBAL_MULTYEAR_CZ.SECU_F_GLOBAL_PARM(''DIVID'')
';