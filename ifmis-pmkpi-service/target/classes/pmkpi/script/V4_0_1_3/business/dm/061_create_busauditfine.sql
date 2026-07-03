
i number;
begin
  -- 新建临时表  备份数据  perf_t_busauditdefine
  select count(*) into i from user_tables t where t.TABLE_NAME ='PERF_TMP_BUSAUDITDEFINE';
  if i=0 then
    execute immediate'create table PERF_TMP_BUSAUDITDEFINE as select * from PERF_T_BUSAUDITDEFINE';
  end if;
  
  -- 删除表
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_BUSAUDITDEFINE';
   if i>0 then
       execute immediate'drop table PERF_T_BUSAUDITDEFINE';
   end if;
   
  --重构表 
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_BUSAUDITDEFINE';
  if i=0 then
     execute immediate '
      create table PERF_T_BUSAUDITDEFINE
      (
        GUID        VARCHAR2(40) not null,
        BUSGUID     VARCHAR2(40) not null,
        ORDERNUM    NUMBER(9) not null,
        AUDITDEFINE VARCHAR2(40) not null,
        ERRTYPE     VARCHAR2(40) not null,
        PROVINCE    VARCHAR2(40),
    YEAR        NUMBER(4) not null
      )';
  execute immediate 'alter table PERF_T_BUSAUDITDEFINE
    add constraint P_PERF_BUSAUDITDEFINE primary key (GUID,PROVINCE,YEAR) ';
  end if;
  -- 临时表数据插入到新表中
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_TMP_BUSAUDITDEFINE';
  if i>0 then
    execute immediate 'insert into PERF_T_BUSAUDITDEFINE (GUID, BUSGUID, ORDERNUM, AUDITDEFINE, ERRTYPE, PROVINCE, YEAR) 
	select GUID, BUSGUID, ORDERNUM, AUDITDEFINE, ERRTYPE, ''87'', ''2016'' from PERF_TMP_BUSAUDITDEFINE t';
  end if;

  -- 删除临时表
  execute immediate '
  drop table PERF_TMP_BUSAUDITDEFINE ';
  
  