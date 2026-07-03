  i integer;
begin
  --专项债券绩效指标信息表
  select count(*) into i from user_tables  t where t.TABLE_NAME='GD_PERF_INDICATOR';
  if i=0 then
     execute immediate '
CREATE TABLE GD_PERF_INDICATOR
(
  INDICATOR_ID   	VARCHAR2(38) NOT NULL,
  GUID       		VARCHAR2(38) NOT NULL,
  FISCAL_YEAR		VARCHAR2(4) NOT NULL,
  MOF_DIV_CODE      VARCHAR2(9) NOT NULL,
  MOF_DIV_NAME		VARCHAR2(360) NOT NULL,
  PERF_IND_CODE		VARCHAR2(300) NOT NULL,
  PERF_IND_NAME		VARCHAR2(1000) NOT NULL,
  VALUE_DESC 	 	VARCHAR2(2000) NOT NULL,
  IND_TYPE_NAME     VARCHAR2(30) NOT NULL,
  IND_TYPE_CODE     VARCHAR2(1) NOT NULL,
  FULL_VALUE     	VARCHAR2(1000),
  UNIT     			VARCHAR2(10),
  AGENCY_CODE       VARCHAR2(21),
  AGENCY_NAME       VARCHAR2(300),
  IS_COMMON_IND     VARCHAR2(1) NOT NULL,
  PARENT_ID		 	VARCHAR2(38),
  FINDEX		 	VARCHAR2(38),
  SINDEX		 	VARCHAR2(38),
  COMPUTESIGN		VARCHAR2(10),
  LEVEL_NO     		NUMBER(2) NOT NULL,
  IS_LEAF      	 	NUMBER(1) NOT NULL,
  IS_LAST_INST		NUMBER(1) NOT NULL,
  START_DATE		VARCHAR2(17) NOT NULL,
  END_DATE			VARCHAR2(17) NOT NULL,
  IS_ENABLED 		NUMBER(1) NOT NULL,
  IS_DELETED		NUMBER(1) NOT NULL,
  UPDATE_TIME		VARCHAR2(17) NOT NULL,
  CREATE_TIME		VARCHAR2(17) NOT NULL,
  BIZ_KEY			VARCHAR2(38),
  YEAR				VARCHAR2(4),
  PROVINCE			VARCHAR2(9),
  WFID				VARCHAR2(40),
  WFSTATUS     	 	VARCHAR2(40),
  AUDITOR        	VARCHAR2(40),
  LASTUPDATETIME 	VARCHAR2(20),
  CREATETIME    	VARCHAR2(17),
  UPDATETIME    	VARCHAR2(17),
  CREATER       	VARCHAR2(40),
  AGENCYGUID		VARCHAR2(21)
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
  add constraint PK_GD_PERF_INDICATOR primary key (INDICATOR_ID, YEAR, PROVINCE)';
execute immediate '
CREATE OR REPLACE VIEW V_GD_PERF_INDICATOR
 AS
SELECT * FROM GD_PERF_INDICATOR WHERE 
	 YEAR = GLOBAL_MULTYEAR_CZ.V_PMYEAR AND
		PROVINCE = GLOBAL_MULTYEAR_CZ.V_PMDIVID
	 AND IS_DELETED = 2;
';  
--YEAR = GLOBAL_MULTYEAR_CZ.V_PMYEAR AND
--PROVINCE = GLOBAL_MULTYEAR_CZ.V_PMDIVID
end if;


  --专项债券项目绩效自评表
  select count(*) into i from user_tables  t where t.TABLE_NAME='GD_PERF_SELF_EVAL';
  if i=0 then
     execute immediate '
create table GD_PERF_SELF_EVAL
(
  EVAL_ID   	VARCHAR2(38) not null,
  GUID       		VARCHAR2(38) not null,
  FISCAL_YEAR		VARCHAR2(4) not null,
  MOF_DIV_CODE      VARCHAR2(9) not null,
  MOF_DIV_NAME		VARCHAR2(360) not null,
  AGENCY_CODE       VARCHAR2(21) not null,
  AGENCY_NAME       VARCHAR2(300) not null,
  PRO_CODE			VARCHAR2(21) not null,
  PRO_NAME			VARCHAR2(180) not null,
  TOTAL_EVAL_VALUE	NUMBER(16,6) not null,
  GOAL_COMP			VARCHAR2(2000) not null,
  IS_LAST_INST		VARCHAR2(1) not null,
  UPDATE_TIME		VARCHAR2(17) not null,
  IS_DELETED		VARCHAR2(1) not null,
  CREATE_TIME		VARCHAR2(17) not null,
  YEAR				VARCHAR2(4),
  PROVINCE			VARCHAR2(9),
  WFID				VARCHAR2(40),
  WFSTATUS     	 	VARCHAR2(40),
  AUDITOR        	VARCHAR2(40),
  LASTUPDATETIME 	VARCHAR2(20),
  CREATETIME    	VARCHAR2(17),
  UPDATETIME    	VARCHAR2(17),
  CREATER       	VARCHAR2(40)
)
';
execute immediate 'comment on column GD_PERF_SELF_EVAL.EVAL_ID
is ''绩效自评表主键''';
execute immediate 'comment on column GD_PERF_SELF_EVAL.FISCAL_YEAR
is ''评价年度''';
execute immediate 'comment on column GD_PERF_SELF_EVAL.MOF_DIV_CODE
is ''财政区划代码''';
execute immediate 'comment on column GD_PERF_SELF_EVAL.MOF_DIV_NAME
is ''财政区划名称''';
execute immediate 'comment on column GD_PERF_SELF_EVAL.AGENCY_CODE
is ''单位代码''';
execute immediate 'comment on column GD_PERF_SELF_EVAL.AGENCY_NAME
is ''单位名称''';
execute immediate 'comment on column GD_PERF_SELF_EVAL.PRO_CODE
is ''项目代码''';
execute immediate 'comment on column GD_PERF_SELF_EVAL.PRO_NAME
is ''项目名称''';
execute immediate 'comment on column GD_PERF_SELF_EVAL.TOTAL_EVAL_VALUE
is ''自评总得分''';
execute immediate 'comment on column GD_PERF_SELF_EVAL.GOAL_COMP
is ''绩效总体目标完成情况''';
execute immediate 'comment on column GD_PERF_SELF_EVAL.IS_LAST_INST
is ''是否终审''';
execute immediate 'comment on column GD_PERF_SELF_EVAL.UPDATE_TIME
is ''更新时间''';
execute immediate 'comment on column GD_PERF_SELF_EVAL.IS_DELETED
is ''是否删除''';
execute immediate 'comment on column GD_PERF_SELF_EVAL.CREATE_TIME
is ''创建时间''';
execute immediate 'comment on column GD_PERF_SELF_EVAL.YEAR
is ''年度''';
execute immediate 'comment on column GD_PERF_SELF_EVAL.PROVINCE
is ''区划''';
execute immediate 'comment on column GD_PERF_SELF_EVAL.WFID
is ''流程ID''';
execute immediate 'comment on column GD_PERF_SELF_EVAL.WFSTATUS
is ''流程状态''';
execute immediate 'comment on column GD_PERF_SELF_EVAL.AUDITOR
is ''审核人''';
execute immediate 'comment on column GD_PERF_SELF_EVAL.LASTUPDATETIME
is ''最后更新时间''';
execute immediate 'comment on column GD_PERF_SELF_EVAL.CREATETIME
is ''创建时间''';
execute immediate 'comment on column GD_PERF_SELF_EVAL.UPDATETIME
is ''修改时间''';
execute immediate 'comment on column GD_PERF_SELF_EVAL.CREATER
is ''创建人''';
execute immediate 'alter table GD_PERF_SELF_EVAL
  add constraint PK_GD_PERF_SELF_EVAL primary key (EVAL_ID, YEAR, PROVINCE)';
execute immediate '
CREATE OR REPLACE VIEW V_GD_PERF_SELF_EVAL
 AS
SELECT * FROM GD_PERF_SELF_EVAL WHERE 
YEAR = GLOBAL_MULTYEAR_CZ.V_PMYEAR AND
		PROVINCE = GLOBAL_MULTYEAR_CZ.V_PMDIVID
';
  end if;
  
  --专项债券项目绩效自评明细表
  select count(*) into i from user_tables  t where t.TABLE_NAME='GD_PERF_SELF_EVAL_DTL';
  if i=0 then
       execute immediate '
create table GD_PERF_SELF_EVAL_DTL
(
  EVAL_DTL_ID   	VARCHAR2(38) NOT NULL,
  GUID       		VARCHAR2(38) NOT NULL,
  EVAL_ID			VARCHAR2(38) NOT NULL,
  KPI_ID			VARCHAR2(38) NOT NULL,
  PRO_CODE			VARCHAR2(40),
  FISCAL_YEAR		VARCHAR2(4) NOT NULL,
  MOF_DIV_CODE      VARCHAR2(9) NOT NULL,
  MOF_DIV_NAME		VARCHAR2(360) NOT NULL,
  IND_WEIGHT		NUMBER(16,4) NOT NULL,
  EVAL_VALUE		NUMBER(16,6) NOT NULL,
  GOAL_COMP			VARCHAR2(2000) NOT NULL,
  DEVI_ANALY		VARCHAR2(2000) NOT NULL,
  IS_LAST_INST		VARCHAR2(1) NOT NULL,
  UPDATE_TIME		VARCHAR2(17) NOT NULL,
  IS_DELETED		VARCHAR2(1) NOT NULL,
  CREATE_TIME		VARCHAR2(17) NOT NULL,
  YEAR				VARCHAR2(4),
  PROVINCE			VARCHAR2(9),
  WFID				VARCHAR2(40),
  WFSTATUS     	 	VARCHAR2(40),
  AUDITOR        	VARCHAR2(40),
  LASTUPDATETIME 	VARCHAR2(20),
  CREATETIME    	VARCHAR2(17),
  UPDATETIME    	VARCHAR2(17),
  CREATER       	VARCHAR2(40)
)
';
execute immediate 'comment on column GD_PERF_SELF_EVAL_DTL.EVAL_DTL_ID
is ''绩效自评明细表主键''';
execute immediate 'comment on column GD_PERF_SELF_EVAL_DTL.EVAL_ID
is ''绩效自评表主键''';
execute immediate 'comment on column GD_PERF_SELF_EVAL_DTL.KPI_ID
is ''绩效指标主键''';
execute immediate 'comment on column GD_PERF_SELF_EVAL_DTL.FISCAL_YEAR
is ''评价年度''';
execute immediate 'comment on column GD_PERF_SELF_EVAL_DTL.MOF_DIV_CODE
is ''财政区划代码''';
execute immediate 'comment on column GD_PERF_SELF_EVAL_DTL.MOF_DIV_NAME
is ''财政区划名称''';
execute immediate 'comment on column GD_PERF_SELF_EVAL_DTL.IND_WEIGHT
is ''权重''';
execute immediate 'comment on column GD_PERF_SELF_EVAL_DTL.EVAL_VALUE
is ''自评分''';
execute immediate 'comment on column GD_PERF_SELF_EVAL_DTL.GOAL_COMP
is ''绩效指标完成情况''';
execute immediate 'comment on column GD_PERF_SELF_EVAL_DTL.DEVI_ANALY
is ''偏差分析及整改措施''';
execute immediate 'comment on column GD_PERF_SELF_EVAL_DTL.IS_LAST_INST
is ''是否终审''';
execute immediate 'comment on column GD_PERF_SELF_EVAL_DTL.UPDATE_TIME
is ''更新时间''';
execute immediate 'comment on column GD_PERF_SELF_EVAL_DTL.IS_DELETED
is ''是否删除''';
execute immediate 'comment on column GD_PERF_SELF_EVAL_DTL.CREATE_TIME
is ''创建时间''';
execute immediate 'comment on column GD_PERF_SELF_EVAL_DTL.YEAR
is ''年度''';
execute immediate 'comment on column GD_PERF_SELF_EVAL_DTL.PROVINCE
is ''区划''';
execute immediate 'comment on column GD_PERF_SELF_EVAL_DTL.WFID
is ''流程ID''';
execute immediate 'comment on column GD_PERF_SELF_EVAL_DTL.WFSTATUS
is ''流程状态''';
execute immediate 'comment on column GD_PERF_SELF_EVAL_DTL.AUDITOR
is ''审核人''';
execute immediate 'comment on column GD_PERF_SELF_EVAL_DTL.LASTUPDATETIME
is ''最后更新时间''';
execute immediate 'comment on column GD_PERF_SELF_EVAL_DTL.CREATETIME
is ''创建时间''';
execute immediate 'comment on column GD_PERF_SELF_EVAL_DTL.UPDATETIME
is ''修改时间''';
execute immediate 'comment on column GD_PERF_SELF_EVAL_DTL.CREATER
is ''创建人''';
execute immediate 'alter table GD_PERF_SELF_EVAL_DTL
  add constraint PK_GD_PERF_SELF_EVAL_DTL primary key (EVAL_DTL_ID, YEAR, PROVINCE)';
execute immediate '
CREATE OR REPLACE VIEW V_GD_PERF_SELF_EVAL_DTL
 AS
SELECT * FROM GD_PERF_SELF_EVAL_DTL WHERE 
YEAR = GLOBAL_MULTYEAR_CZ.V_PMYEAR AND
		PROVINCE = GLOBAL_MULTYEAR_CZ.V_PMDIVID
';  
  end if;
  
  
  --专项债券重点项目绩效评价表
  select count(*) into i from user_tables  t where t.TABLE_NAME='GD_PERF_EVAL';
  if i=0 then
         execute immediate '
create table GD_PERF_EVAL
(
  EVAL_ID   	VARCHAR2(38) NOT NULL,
  GUID       		VARCHAR2(38) NOT NULL,
  FISCAL_YEAR		VARCHAR2(4) NOT NULL,
  MOF_DIV_CODE      VARCHAR2(9) NOT NULL,
  MOF_DIV_NAME		VARCHAR2(360) NOT NULL,
  AGENCY_CODE       VARCHAR2(21) NOT NULL,
  AGENCY_NAME       VARCHAR2(300) NOT NULL,
  PRO_CODE			VARCHAR2(21) NOT NULL,
  PRO_NAME			VARCHAR2(180) NOT NULL,
  TOTAL_EVAL_VAL	NUMBER(16,6) NOT NULL,
  EVAL_FILE			VARCHAR2(2000),
  FILE_NAME			VARCHAR2(120),
  FULL_PATH			VARCHAR2(300),
  IS_LAST_INST		VARCHAR2(1) NOT NULL,
  UPDATE_TIME		VARCHAR2(17) NOT NULL,
  IS_DELETED		VARCHAR2(1) NOT NULL,
  CREATE_TIME		VARCHAR2(17) NOT NULL,
  YEAR				VARCHAR2(4),
  PROVINCE			VARCHAR2(9),
  WFID				VARCHAR2(40),
  WFSTATUS     	 	VARCHAR2(40),
  AUDITOR        	VARCHAR2(40),
  LASTUPDATETIME 	VARCHAR2(20),
  CREATETIME    	VARCHAR2(17),
  UPDATETIME    	VARCHAR2(17),
  CREATER       	VARCHAR2(40)
)
';
execute immediate 'comment on column GD_PERF_EVAL.EVAL_ID
is ''重点项目绩效表主键''';
execute immediate 'comment on column GD_PERF_EVAL.FISCAL_YEAR
is ''评价年度''';
execute immediate 'comment on column GD_PERF_EVAL.MOF_DIV_CODE
is ''财政区划代码''';
execute immediate 'comment on column GD_PERF_EVAL.MOF_DIV_NAME
is ''财政区划名称''';
execute immediate 'comment on column GD_PERF_EVAL.AGENCY_CODE
is ''单位代码''';
execute immediate 'comment on column GD_PERF_EVAL.AGENCY_NAME
is ''单位名称''';
execute immediate 'comment on column GD_PERF_EVAL.PRO_CODE
is ''项目代码''';
execute immediate 'comment on column GD_PERF_EVAL.PRO_NAME
is ''项目名称''';
execute immediate 'comment on column GD_PERF_EVAL.TOTAL_EVAL_VAL
is ''评价总得分''';
execute immediate 'comment on column GD_PERF_EVAL.EVAL_FILE
is ''评价报告''';
execute immediate 'comment on column GD_PERF_EVAL.FILE_NAME
is ''附件名称''';
execute immediate 'comment on column GD_PERF_EVAL.FULL_PATH
is ''附件路径''';
execute immediate 'comment on column GD_PERF_EVAL.IS_LAST_INST
is ''是否终审''';
execute immediate 'comment on column GD_PERF_EVAL.UPDATE_TIME
is ''更新时间''';
execute immediate 'comment on column GD_PERF_EVAL.IS_DELETED
is ''是否删除''';
execute immediate 'comment on column GD_PERF_EVAL.CREATE_TIME
is ''创建时间''';
execute immediate 'comment on column GD_PERF_EVAL.YEAR
is ''年度''';
execute immediate 'comment on column GD_PERF_EVAL.PROVINCE
is ''区划''';
execute immediate 'comment on column GD_PERF_EVAL.WFID
is ''流程ID''';
execute immediate 'comment on column GD_PERF_EVAL.WFSTATUS
is ''流程状态''';
execute immediate 'comment on column GD_PERF_EVAL.AUDITOR
is ''审核人''';
execute immediate 'comment on column GD_PERF_EVAL.LASTUPDATETIME
is ''最后更新时间''';
execute immediate 'comment on column GD_PERF_EVAL.CREATETIME
is ''创建时间''';
execute immediate 'comment on column GD_PERF_EVAL.UPDATETIME
is ''修改时间''';
execute immediate 'comment on column GD_PERF_EVAL.CREATER
is ''创建人''';
execute immediate 'alter table GD_PERF_EVAL
  add constraint PK_GD_PERF_EVAL primary key (EVAL_ID, YEAR, PROVINCE)';
execute immediate '
CREATE OR REPLACE VIEW V_GD_PERF_EVAL
 AS
SELECT * FROM GD_PERF_EVAL WHERE 
YEAR = GLOBAL_MULTYEAR_CZ.V_PMYEAR AND
		PROVINCE = GLOBAL_MULTYEAR_CZ.V_PMDIVID
';  
  end if;
  
    
  --专项债券重点项目绩效评价明细表
  select count(*) into i from user_tables  t where t.TABLE_NAME='GD_PERF_EVAL_DTL';
  if i=0 then
         execute immediate '
create table GD_PERF_EVAL_DTL
(
  EVAL_DTL_ID   	VARCHAR2(38) not null,
  GUID       		VARCHAR2(38) not null,
  EVAL_ID			VARCHAR2(38) not null,
  KPI_ID			VARCHAR2(38) not null,
  PRO_CODE			VARCHAR2(40),
  FISCAL_YEAR		VARCHAR2(4) not null,
  MOF_DIV_CODE      VARCHAR2(9) not null,
  MOF_DIV_NAME		VARCHAR2(360) not null,
  IND_WEIGHT		NUMBER(16,4) not null,
  EVAL_VALUE		NUMBER(16,6) not null,
  DEVI_ANALY		VARCHAR2(2000) not null,
  IS_LAST_INST		VARCHAR2(1) not null,
  UPDATE_TIME		VARCHAR2(17) not null,
  IS_DELETED		VARCHAR2(1) not null,
  CREATE_TIME		VARCHAR2(17) not null,
  YEAR				VARCHAR2(4),
  PROVINCE			VARCHAR2(9),
  WFID				VARCHAR2(40),
  WFSTATUS     	 	VARCHAR2(40),
  AUDITOR        	VARCHAR2(40),
  LASTUPDATETIME 	VARCHAR2(20),
  CREATETIME    	VARCHAR2(17),
  UPDATETIME    	VARCHAR2(17),
  CREATER       	VARCHAR2(40)
)
';
execute immediate 'comment on column GD_PERF_EVAL_DTL.EVAL_DTL_ID
is ''重点项目评价明细表主键''';
execute immediate 'comment on column GD_PERF_EVAL_DTL.EVAL_ID
is ''重点项目评价表主键''';
execute immediate 'comment on column GD_PERF_EVAL_DTL.KPI_ID
is ''绩效指标主键''';
execute immediate 'comment on column GD_PERF_EVAL_DTL.FISCAL_YEAR
is ''评价年度''';
execute immediate 'comment on column GD_PERF_EVAL_DTL.MOF_DIV_CODE
is ''财政区划代码''';
execute immediate 'comment on column GD_PERF_EVAL_DTL.MOF_DIV_NAME
is ''财政区划名称''';
execute immediate 'comment on column GD_PERF_EVAL_DTL.IND_WEIGHT
is ''权重''';
execute immediate 'comment on column GD_PERF_EVAL_DTL.EVAL_VALUE
is ''绩效评分''';
execute immediate 'comment on column GD_PERF_EVAL_DTL.DEVI_ANALY
is ''目标偏差分析及整改措施''';
execute immediate 'comment on column GD_PERF_EVAL_DTL.IS_LAST_INST
is ''是否终审''';
execute immediate 'comment on column GD_PERF_EVAL_DTL.UPDATE_TIME
is ''更新时间''';
execute immediate 'comment on column GD_PERF_EVAL_DTL.IS_DELETED
is ''是否删除''';
execute immediate 'comment on column GD_PERF_EVAL_DTL.CREATE_TIME
is ''创建时间''';
execute immediate 'comment on column GD_PERF_EVAL_DTL.YEAR
is ''年度''';
execute immediate 'comment on column GD_PERF_EVAL_DTL.PROVINCE
is ''区划''';
execute immediate 'comment on column GD_PERF_EVAL_DTL.WFID
is ''流程ID''';
execute immediate 'comment on column GD_PERF_EVAL_DTL.WFSTATUS
is ''流程状态''';
execute immediate 'comment on column GD_PERF_EVAL_DTL.AUDITOR
is ''审核人''';
execute immediate 'comment on column GD_PERF_EVAL_DTL.LASTUPDATETIME
is ''最后更新时间''';
execute immediate 'comment on column GD_PERF_EVAL_DTL.CREATETIME
is ''创建时间''';
execute immediate 'comment on column GD_PERF_EVAL_DTL.UPDATETIME
is ''修改时间''';
execute immediate 'comment on column GD_PERF_EVAL_DTL.CREATER
is ''创建人''';
execute immediate 'alter table GD_PERF_EVAL_DTL
  add constraint PK_GD_PERF_EVAL_DTL primary key (EVAL_DTL_ID, YEAR, PROVINCE)';
execute immediate '
CREATE OR REPLACE VIEW V_GD_PERF_EVAL_DTL
 AS
SELECT * FROM GD_PERF_EVAL_DTL WHERE 
YEAR = GLOBAL_MULTYEAR_CZ.V_PMYEAR AND
		PROVINCE = GLOBAL_MULTYEAR_CZ.V_PMDIVID
';
  end if;