  i number;
begin

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_DEPTEVALUATION' and t.column_name='EVAL_AMT';
if i=0 then
   execute immediate 'ALTER TABLE PERF_T_DEPTEVALUATION ADD EVAL_AMT NUMBER(20,2)';
end if;

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_DEPTEVALUATION' and t.column_name='ISADD';
if i=0 then
   execute immediate 'ALTER TABLE PERF_T_DEPTEVALUATION ADD ISADD NUMBER(2)';
end if;

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_DEPTEVALUATION' and t.column_name='EVAL_TYPE';
if i=0 then
   execute immediate 'ALTER TABLE PERF_T_DEPTEVALUATION ADD EVAL_TYPE VARCHAR2(40)';
end if;

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_DEPTEVALUATION' and t.column_name='REMARK';
if i=0 then
   execute immediate 'ALTER TABLE PERF_T_DEPTEVALUATION ADD REMARK VARCHAR2(4000)';
end if;

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_DEPTEVALUATION' and t.column_name='EVAL_SCORE';
if i=0 then
   execute immediate 'ALTER TABLE PERF_T_DEPTEVALUATION ADD EVAL_SCORE NUMBER(20,2)';
end if;

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_DEPTEVALUATION' and t.column_name='EVAL_TARGET';
if i=0 then
   execute immediate 'ALTER TABLE PERF_T_DEPTEVALUATION ADD EVAL_TARGET VARCHAR2(4000)';
end if;

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_DEPTEVALUATION' and t.column_name='EVAL_LEVLO';
if i=0 then
   execute immediate 'ALTER TABLE PERF_T_DEPTEVALUATION ADD EVAL_LEVLO VARCHAR2(40)';
end if;

execute immediate 'create or replace view v_perf_t_deptevaluation as
select * from PERF_T_DEPTEVALUATION t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

 
		
select count(*) into i from user_tables t where t.TABLE_NAME='PERF_T_DEPTEVARELATION';
if i = 0 then
    execute immediate '	
		create table PERF_T_DEPTEVARELATION
		(
		  guid                VARCHAR2(32) not null,
		  projectkind         VARCHAR2(32),
		  pro_code            VARCHAR2(40),
		  pro_name            VARCHAR2(500),
		  pro_total_amt       NUMBER(20,2),
		  agencyguid          VARCHAR2(21),
		  agency_code         VARCHAR2(21),
		  manage_dept_code    VARCHAR2(21),
		  manage_mof_dep_code VARCHAR2(6),
		  setup_year          VARCHAR2(4),
		  pro_start_year      VARCHAR2(4),
		  pro_term            VARCHAR2(8),
		  mainguid            VARCHAR2(32),
		  is_deleted          NUMBER(1) default 2 not null,
		  year                CHAR(4) not null,
		  province            VARCHAR2(9) not null,
		  creater             VARCHAR2(32) not null,
		  create_time         VARCHAR2(17) not null,
		  update_time         VARCHAR2(17) not null
		)
	';
	execute immediate 'comment on column PERF_T_DEPTEVARELATION.guid
	  is ''主键''';
	execute immediate 'comment on column PERF_T_DEPTEVARELATION.projectkind
	  is ''支出项目类别''';
	execute immediate 'comment on column PERF_T_DEPTEVARELATION.pro_code
	  is ''项目代码''';
	execute immediate 'comment on column PERF_T_DEPTEVARELATION.pro_name
	  is ''项目名称''';
	execute immediate 'comment on column PERF_T_DEPTEVARELATION.pro_total_amt
	  is ''项目总额（元）''';
	execute immediate 'comment on column PERF_T_DEPTEVARELATION.agencyguid
	  is ''预算单位GUID''';
	execute immediate 'comment on column PERF_T_DEPTEVARELATION.agency_code
	  is ''预算单位''';
	execute immediate 'comment on column PERF_T_DEPTEVARELATION.manage_dept_code
	  is ''主管部门''';
	execute immediate 'comment on column PERF_T_DEPTEVARELATION.manage_mof_dep_code
	  is ''主管处室''';
	execute immediate 'comment on column PERF_T_DEPTEVARELATION.setup_year
	  is ''设立年度''';
	execute immediate 'comment on column PERF_T_DEPTEVARELATION.pro_start_year
	  is ''起始时间''';
	execute immediate 'comment on column PERF_T_DEPTEVARELATION.pro_term
	  is ''项目期限''';
	execute immediate 'comment on column PERF_T_DEPTEVARELATION.mainguid
	  is ''主单guid''';
	execute immediate 'comment on column PERF_T_DEPTEVARELATION.is_deleted
	  is ''是否删除1是2否''';
	execute immediate 'comment on column PERF_T_DEPTEVARELATION.year
	  is ''年份''';
	execute immediate 'comment on column PERF_T_DEPTEVARELATION.province
	  is ''区划''';
	execute immediate 'comment on column PERF_T_DEPTEVARELATION.creater
	  is ''创建人''';
	execute immediate 'comment on column PERF_T_DEPTEVARELATION.create_time
	  is ''创建时间''';
	execute immediate 'comment on column PERF_T_DEPTEVARELATION.update_time
	  is ''更新时间''';
	execute immediate 'alter table PERF_T_DEPTEVARELATION
	  add constraint PK_PERF_T_DEPTEVARELATION primary key (GUID)';
end if;
  
  
  
execute immediate '  
  CREATE OR REPLACE VIEW V_PERF_T_DEPTEVARELATION AS
SELECT * FROM
    PERF_T_DEPTEVARELATION
WHERE
    IS_DELETED = 2
    AND YEAR = GLOBAL_MULTYEAR_CZ.SECU_F_GLOBAL_PARM(''YEAR'')
    AND PROVINCE = GLOBAL_MULTYEAR_CZ.SECU_F_GLOBAL_PARM(''DIVID'')
';