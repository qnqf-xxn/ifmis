 i number;
begin
--PERF_T_SYNCTASKCFG（同步数据配置表）
select count(1) into i from user_tables t where t.table_name = 'PERF_T_SYNCTASKCFG';
if i=0 then
    execute immediate 'create table PERF_T_SYNCTASKCFG (
       guid         VARCHAR2(40) not null,
     province     VARCHAR2(9) not null,  --区划
       year         VARCHAR2(4) not null,  --年度
       tablecode    VARCHAR2(40) not null, --来源报表
       savetable    VARCHAR2(40) not null, --保存表
       pagecount    VARCHAR2(40),  --每页数据量
       type         NUMBER(1),  --同步类型
       ordernum     NUMBER(12),
       remark       VARCHAR2(400),
       status       NUMBER(1)
  )
    ';
  execute immediate ' 
  alter table PERF_T_SYNCTASKCFG
    add constraint pk_perf_t_synctaskcfg primary key (GUID)';

  execute immediate 'comment on column PERF_T_SYNCTASKCFG.province
    is ''区划''';
  execute immediate 'comment on column PERF_T_SYNCTASKCFG.year
    is ''年度''';  
  execute immediate 'comment on column PERF_T_SYNCTASKCFG.tablecode
    is ''来源表（视图）名''';
  execute immediate 'comment on column PERF_T_SYNCTASKCFG.savetable
    is ''保存表名''';
  execute immediate 'comment on column PERF_T_SYNCTASKCFG.pagecount
    is ''每页数据量''';
  execute immediate 'comment on column PERF_T_SYNCTASKCFG.type
    is ''同步类型：1为自动定时任务同步 0为手动按钮同步 ''';
  execute immediate 'comment on column PERF_T_SYNCTASKCFG.status
    is ''启用状态：1为开启 0为关闭''';
end if;

--部门整体绩效目标落地资金表  
select count(1) into i from user_tables t where t.table_name = 'PERF_T_DEPTBGTFUND';
if i=0 then
    execute immediate 'create table PERF_T_DEPTBGTFUND (
    guid         VARCHAR2(40) not null,
    agency_code  VARCHAR2(40) not null,
    year         VARCHAR2(4) not null,
    province     VARCHAR2(9) not null,
    create_time  VARCHAR2(17) not null,
    creater      VARCHAR2(40) not null,
    amt1         NUMBER(20,2),
    amt2         NUMBER(20,2),
    amt3         NUMBER(20,2),
    amt4         NUMBER(20,2),
    amt5         NUMBER(20,2),
    amt6         NUMBER(20,2),
    amt7         NUMBER(20,2),
    amt8         NUMBER(20,2),
    amt9         NUMBER(20,2),
    amt10        NUMBER(20,2),
    amt11        NUMBER(20,2),
    amt12         NUMBER(20,2),
    amt13         NUMBER(20,2),
    amt14         NUMBER(20,2),
    amt15         NUMBER(20,2),
    amt16         NUMBER(20,2),
    amt17         NUMBER(20,2),
    amt18         NUMBER(20,2),
    amt19         NUMBER(20,2),
    amt20         NUMBER(20,2)
  )
    ';
  execute immediate ' 
  alter table PERF_T_DEPTBGTFUND
    add constraint PK_PERF_T_DEPTBGTFUND primary key (GUID)';
end if;

--项目列表预算数据落地资金表
select count(1) into i from user_tables t where t.table_name = 'PERF_T_PROLISTBGTFUND';
if i=0 then
    execute immediate 'create table PERF_T_PROLISTBGTFUND (
    guid         VARCHAR2(40) not null,
    pro_id     VARCHAR2(40) not null,
    pro_code     VARCHAR2(40) not null,
    agency_code  VARCHAR2(40) not null,
    year         VARCHAR2(4) not null,
    province     VARCHAR2(9) not null,
    create_time  VARCHAR2(17) not null,
    creater      VARCHAR2(40) not null,
    pro_levone_code    VARCHAR2(40),
    bgtamt     NUMBER(20,2),
    amt1         NUMBER(20,2),
    amt2         NUMBER(20,2),
    amt3         NUMBER(20,2),
    amt4         NUMBER(20,2),
    amt5         NUMBER(20,2),
    amt6         NUMBER(20,2),
    amt7         NUMBER(20,2),
    amt8         NUMBER(20,2),
    amt9         NUMBER(20,2),
    amt10        NUMBER(20,2),
    amt11        NUMBER(20,2),
    amt12         NUMBER(20,2),
    amt13         NUMBER(20,2),
    amt14         NUMBER(20,2),
    amt15         NUMBER(20,2),
    amt16         NUMBER(20,2),
    amt17         NUMBER(20,2),
    amt18         NUMBER(20,2),
    amt19         NUMBER(20,2),
    amt20         NUMBER(20,2)
  )
    ';
  execute immediate ' 
  alter table PERF_T_PROLISTBGTFUND
    add constraint PK_PERF_T_PROLISTBGTFUND primary key (GUID)';
end if;