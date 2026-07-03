  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin

--阶段执行数
select count(*) into i from user_tables t where t.table_name ='PERF_T_DATACOMMUNICATION';
if i=0 then
--绩效与山西数据中心交互信息表
execute immediate 'create table PERF_T_DATACOMMUNICATION
(
  guid       VARCHAR2(32) not null,--主键
  pro_code   VARCHAR2(21) not null,--项目编码
  file_id   VARCHAR2(32) not null,--附件guid
  creater    VARCHAR2(32),--创建人
  create_time VARCHAR2(17) not null,--创建时间
  update_time VARCHAR2(17) not null,--修改时间
  mof_div_code   VARCHAR2(9) not null,--区划,
  fiscal_year       VARCHAR2(4) not null,--年度
  is_deleted        number(1) not null--是否删除
)';
execute immediate 'alter table PERF_T_DATACOMMUNICATION
  add constraint PK_PERF_DATAUNICATION primary key (GUID, mof_div_code, fiscal_year)';

execute immediate 'CREATE INDEX IDX_PERFDATACOMM_PROCODE ON PERF_T_DATACOMMUNICATION(PRO_CODE,Is_Deleted)';

end if;

v_sql :='create or replace view V_PERF_T_DATACOMMUNICATION as
select t.*
 from perf_t_datacommunication t
where t.fiscal_year = global_multyear_cz.v_pmyear and t.mof_div_code = global_multyear_cz.v_pmdivid and t.is_deleted=2';
select fn_alterview('V_PERF_T_DATACOMMUNICATION',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;


v_sql :='create or replace view V_PERF_SELFPRO_DATACOMMUN as
select t.pro_code, t.guid, t.year, t.province, t.name, t.agencyguid, decode(a.pro_code,null,''2'',''1'') as datacommun,t.manage_mof_dep_code,t.finintorgguid,dept_code
from perf_t_selfevaltask t
left join perf_t_datacommunication a on a.pro_code = t.pro_code and a.mof_div_code = t.province and a.fiscal_year = t.year and a.is_deleted = 2
where t.wfstatus = ''011'' and t.bustype=''program''';
select fn_alterview('V_PERF_SELFPRO_DATACOMMUN',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;
