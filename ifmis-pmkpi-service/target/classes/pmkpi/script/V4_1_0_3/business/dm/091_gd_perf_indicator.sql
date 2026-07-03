i integer;
begin
  --专项债券绩效指标信息表
  select count(*) into i from user_tables  t where t.TABLE_NAME='GD_PERF_INDICATOR';
  if i=0 then
     execute immediate '
CREATE TABLE GD_PERF_INDICATOR
(
  INDICATOR_ID    VARCHAR2(38) NOT NULL,
  GUID          VARCHAR2(38) NOT NULL,
  FISCAL_YEAR   VARCHAR2(4) NOT NULL,
  MOF_DIV_CODE      VARCHAR2(9) NOT NULL,
  MOF_DIV_NAME    VARCHAR2(360) NOT NULL,
  PERF_IND_CODE   VARCHAR2(300) NOT NULL,
  PERF_IND_NAME   VARCHAR2(1000) NOT NULL,
  VALUE_DESC    VARCHAR2(2000) NOT NULL,
  IND_TYPE_NAME     VARCHAR2(30) NOT NULL,
  IND_TYPE_CODE     VARCHAR2(1) NOT NULL,
  FULL_VALUE      VARCHAR2(1000),
  UNIT          VARCHAR2(10),
  AGENCY_CODE       VARCHAR2(21),
  AGENCY_NAME       VARCHAR2(300),
  IS_COMMON_IND     VARCHAR2(1) NOT NULL,
  PARENT_ID     VARCHAR2(38),
  FINDEX      VARCHAR2(38),
  SINDEX      VARCHAR2(38),
  COMPUTESIGN   VARCHAR2(10),
  LEVEL_NO        NUMBER(2) NOT NULL,
  IS_LEAF         NUMBER(1) NOT NULL,
  IS_LAST_INST    NUMBER(1) NOT NULL,
  START_DATE    VARCHAR2(17) NOT NULL,
  END_DATE      VARCHAR2(17) NOT NULL,
  IS_ENABLED    NUMBER(1) NOT NULL,
  IS_DELETED    NUMBER(1) NOT NULL,
  UPDATE_TIME   VARCHAR2(17) NOT NULL,
  CREATE_TIME   VARCHAR2(17) NOT NULL,
  BIZ_KEY     VARCHAR2(38),
  YEAR        VARCHAR2(4),
  PROVINCE      VARCHAR2(9),
  WFID        VARCHAR2(40),
  WFSTATUS        VARCHAR2(40),
  AUDITOR         VARCHAR2(40),
  LASTUPDATETIME  VARCHAR2(20),
  CREATETIME      VARCHAR2(17),
  UPDATETIME      VARCHAR2(17),
  CREATER         VARCHAR2(40),
  AGENCYGUID    VARCHAR2(21)
)
';
-- Add comments to the columns 
execute immediate 'comment on column GD_PERF_INDICATOR.INDICATOR_ID
is ''绩效指标主键''';
execute immediate 'comment on column GD_PERF_INDICATOR.FISCAL_YEAR
is ''预算年度''';
execute immediate 'comment on column GD_PERF_INDICATOR.MOF_DIV_CODE
is ''财政区划代码''';
execute immediate 'comment on column GD_PERF_INDICATOR.MOF_DIV_NAME
is ''财政区划名称''';
execute immediate 'comment on column GD_PERF_INDICATOR.PERF_IND_CODE
is ''绩效指标代码''';
execute immediate 'comment on column GD_PERF_INDICATOR.PERF_IND_NAME
is ''绩效指标名称''';
execute immediate 'comment on column GD_PERF_INDICATOR.VALUE_DESC
is ''指标值说明''';
execute immediate 'comment on column GD_PERF_INDICATOR.IND_TYPE_NAME
is ''债务绩效指标类型名称''';
execute immediate 'comment on column GD_PERF_INDICATOR.IND_TYPE_CODE
is ''债务绩效指标类型代码''';
execute immediate 'comment on column GD_PERF_INDICATOR.FULL_VALUE
is ''指标满分值''';
execute immediate 'comment on column GD_PERF_INDICATOR.UNIT
is ''计量单位''';
execute immediate 'comment on column GD_PERF_INDICATOR.AGENCY_CODE
is ''单位代码''';
execute immediate 'comment on column GD_PERF_INDICATOR.AGENCY_NAME
is ''单位名称''';
execute immediate 'comment on column GD_PERF_INDICATOR.IS_COMMON_IND
is ''是否共性指标''';
execute immediate 'comment on column GD_PERF_INDICATOR.PARENT_ID
is ''父级节点ID''';
execute immediate 'comment on column GD_PERF_INDICATOR.LEVEL_NO
is ''级次''';
execute immediate 'comment on column GD_PERF_INDICATOR.IS_LEAF
is ''是否末级''';
execute immediate 'comment on column GD_PERF_INDICATOR.IS_LAST_INST
is ''是否终审''';
execute immediate 'comment on column GD_PERF_INDICATOR.START_DATE
is ''启用日期''';
execute immediate 'comment on column GD_PERF_INDICATOR.END_DATE
is ''停用日期''';
execute immediate 'comment on column GD_PERF_INDICATOR.IS_ENABLED
is ''是否启用''';
execute immediate 'comment on column GD_PERF_INDICATOR.UPDATE_TIME
is ''更新时间''';
execute immediate 'comment on column GD_PERF_INDICATOR.IS_DELETED
is ''是否删除''';
execute immediate 'comment on column GD_PERF_INDICATOR.CREATE_TIME
is ''创建时间''';
execute immediate 'comment on column GD_PERF_INDICATOR.BIZ_KEY
is ''业务唯一标识''';
execute immediate 'comment on column GD_PERF_INDICATOR.YEAR
is ''年度''';
execute immediate 'comment on column GD_PERF_INDICATOR.PROVINCE
is ''区划''';
execute immediate 'comment on column GD_PERF_INDICATOR.WFID
is ''流程ID''';
execute immediate 'comment on column GD_PERF_INDICATOR.WFSTATUS
is ''流程状态''';
execute immediate 'comment on column GD_PERF_INDICATOR.AUDITOR
is ''审核人''';
execute immediate 'comment on column GD_PERF_INDICATOR.LASTUPDATETIME
is ''最后更新时间''';
execute immediate 'comment on column GD_PERF_INDICATOR.CREATETIME
is ''创建时间''';
execute immediate 'comment on column GD_PERF_INDICATOR.UPDATETIME
is ''修改时间''';
execute immediate 'comment on column GD_PERF_INDICATOR.CREATER
is ''创建人''';
execute immediate 'alter table GD_PERF_INDICATOR
  add constraint PK_GD_PERF_INDICATOR primary key (INDICATOR_ID,YEAR,PROVINCE)';
execute immediate '
CREATE OR REPLACE VIEW V_GD_PERF_INDICATOR
 AS
SELECT * FROM GD_PERF_INDICATOR WHERE 
    PROVINCE = GLOBAL_MULTYEAR_CZ.SECU_F_GLOBAL_PARM(''DIVID'')
   AND IS_DELETED = 2
';
end if;