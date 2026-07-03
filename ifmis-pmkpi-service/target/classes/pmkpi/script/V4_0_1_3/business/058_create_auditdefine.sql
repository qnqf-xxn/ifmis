-- 审核定义表   修改为分区表
i integer;
begin
  -- 新建临时表  备份数据
  select count(*) into i from user_tables t where t.TABLE_NAME ='PERF_TMP_AUDITFINE';
  if i=0 then
    execute immediate'create table PERF_TMP_AUDITFINE as select * from PERF_T_AUDITDEFINE';
  end if;
  
  -- 删除表
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_AUDITDEFINE';
   if i>0 then
       execute immediate'drop table PERF_T_AUDITDEFINE';
   end if;
   
  --重构表 
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_AUDITDEFINE';
    if i=0 then
       execute immediate '
        create table PERF_T_AUDITDEFINE
        (
            guid        VARCHAR2(40) not null,
            code        VARCHAR2(40) not null,
            name        VARCHAR2(255) not null,
            explain     VARCHAR2(2000),
            year        NUMBER(4) not null,
            agencyguid  VARCHAR2(40),
            wfid        VARCHAR2(40),
            wfstatus    VARCHAR2(40),
            creater     VARCHAR2(40),
            createtime  VARCHAR2(17),
            updatetime  VARCHAR2(17),
            province    VARCHAR2(40),
            ordernum    NUMBER(9),
            status      NUMBER(1),
            procedure   VARCHAR2(1000),
            auditdetype VARCHAR2(20),
            isalltable  NUMBER(1),
            recordadopt NUMBER(1),
            checkflag   NUMBER(1),
            viewguid    VARCHAR2(40),
            auditbeanid VARCHAR2(200),
            remark      NUMBER(1),
            auditsql    VARCHAR2(4000)
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
        execute immediate 'alter table PERF_T_AUDITDEFINE
          add constraint PK_PERF_T_AUDITDEFINE primary key (GUID,PROVINCE, YEAR)
          using index ';
  end if;

  --临时表数据区划改为87/2016
  execute immediate '
  update PERF_TMP_AUDITFINE set year=''2016'',province =''87'' ';

  -- 数据插入到新表中
  execute immediate '
  delete from PERF_T_AUDITDEFINE ';
  execute immediate '
  insert into PERF_T_AUDITDEFINE(GUID,CODE,NAME,EXPLAIN,YEAR,AGENCYGUID,WFID,WFSTATUS,CREATER,CREATETIME,UPDATETIME,PROVINCE,ORDERNUM,STATUS,PROCEDURE,AUDITDETYPE,ISALLTABLE,RECORDADOPT,CHECKFLAG,VIEWGUID,AUDITBEANID,REMARK,AUDITSQL) 
    select * from PERF_TMP_AUDITFINE ';
  -- 删除临时表
  execute immediate '
  drop table PERF_TMP_AUDITFINE ';