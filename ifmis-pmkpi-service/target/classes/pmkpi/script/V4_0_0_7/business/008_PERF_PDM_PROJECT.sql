  i integer;
begin

   select count(1) into i from user_tab_cols t where t.table_name='PERF_T_EVALUATEAUDIT' and t.column_name='BUSTYPE';
     if i=0 then
       execute immediate 'alter table PERF_T_EVALUATEAUDIT add BUSTYPE VARCHAR2(40)';
       
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_EVALUATEAUDIT' and t.columncode='BUSTYPE';
       insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '0', 'BUSTYPE', '1', '2020', '87', 'B45a303CE6656613E053B11FA8C23111', 'BUSTYPE', 'PERF_T_EVALUATEAUDIT', '类别', 'S', '40', null, null, 1, null, sysdate);

     end if;

execute immediate 'create or replace view v_perf_t_evaluateaudit as
select * FROM PERF_T_EVALUATEAUDIT T
      WHERE T.PROVINCE = global_multyear_cz.Secu_f_Global_Parm(''DIVID'')
      and T.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')';

execute immediate'CREATE OR REPLACE VIEW PERF_PDM_PROJECT AS
select
t.guid as guid,--项目guid
t.pro_id as pro_id,--项目id
t.PRO_CODE as pro_code,--项目编码
t.PRO_NAME as pro_name,--项目名称
c.name as pro_creater,--项目负责人
'''' as is_perfeval,--是否事前绩效评估
'''' as is_publish,--是否绩效目标公开
'''' as publishremark,--非绩效目标公开原因
'''' as is_welfare,--是否政府投资公益项目
t.pro_start_year as startdate,--项目开始时间
'''' as is_addpro,--是否新增项目
'''' as annualamt,--本年度项目资金
'''' as amtincrease,--对比上年度资金增幅
f.name as evalremark,--事前绩效评估审核结论
b.freview as firstremark,--绩效目标初审结论
b.sreview as reexamineremark,--绩效目标复审结论
t.YEAR as year,--年度
t.PROVINCE as province,--区划
t.AGENCY_CODE as agencyguid,--单位
a.name as finintorgguid,--处室
''A69147082E975D0733386A42C3E5F4B5'' as taskguid,
''program'' bustype,
t.is_deleted  as is_deleted,
t.pro_cat_code pro_kind_code
from v_perf_project_info t
left join fasp_t_pubdepartment a on a.guid=t.finintorgguid
left join (SELECT m.proguid,
(select q.name from v_perf_enum q where q.guid=m.freview and q.elementcode=''REVIEWOPINION'') as freview,
(select q.name from v_perf_enum q where q.guid=m.sreview and q.elementcode=''REVIEWOPINION'') as sreview
FROM v_perf_t_review n left join perf_t_audititems m on m.proguid=n.proguid
WHERE  n.type=''goal'' and n.islast=1 and n.isconfirm=''1'' and m.tempguid = ''B9C7D80EC0298933E053B11FA8C0A5D6'') b on b.proguid = t.guid
left join fasp_t_causer c on c.guid=t.creater
left join (SELECT m.proguid,m.audittype,
(select q.name from v_perf_enum q where q.guid=m.audittype and q.elementcode=''AUDITTYPE'' ) as name
from v_perf_t_evaluateaudit m WHERE  m.bustype=''assessment'' ) f
on f.proguid=t.guid
union all
select
t.guid as guid,--项目guid
t.pro_id as pro_id,--项目id
t.PRO_CODE as pro_code,--项目编码
t.PRO_NAME as pro_name,--项目名称
c.name as pro_creater,--项目负责人
'''' as is_perfeval,--是否事前绩效评估
'''' as is_publish,--是否绩效目标公开
'''' as publishremark,--非绩效目标公开原因
'''' as is_welfare,--是否政府投资公益项目
t.pro_start_year as startdate,--项目开始时间
'''' as is_addpro,--是否新增项目
'''' as annualamt,--本年度项目资金
'''' as amtincrease,--对比上年度资金增幅
f.name as evalremark,--事前绩效评估审核结论
b.freview as firstremark,--绩效目标初审结论
b.sreview as reexamineremark,--绩效目标复审结论
t.YEAR as year,--年度
t.PROVINCE as province,--区划
t.AGENCY_CODE as agencyguid,--单位
a.name as finintorgguid,--处室
''9EE3A842793449818960559B00660C1B'' as taskguid,
''program'' bustype,
t.is_deleted  as is_deleted,
t.pro_cat_code pro_kind_code
from v_perf_project_info t
left join fasp_t_pubdepartment a on a.guid=t.finintorgguid
left join (SELECT m.proguid,
(select q.name from v_perf_enum q where q.guid=m.freview and q.elementcode=''REVIEWOPINION'') as freview,
(select q.name from v_perf_enum q where q.guid=m.sreview and q.elementcode=''REVIEWOPINION'') as sreview
FROM v_perf_t_review n left join perf_t_audititems m on m.proguid=n.proguid
WHERE  n.type=''goal'' and n.islast=1 and n.isconfirm=''1'' and m.tempguid = ''B9C7D80EC0298933E053B11FA8C0A5D6'') b on b.proguid = t.guid
left join fasp_t_causer c on c.guid=t.creater
left join (SELECT m.proguid,m.audittype,
(select q.name from v_perf_enum q where q.guid=m.audittype and q.elementcode=''AUDITTYPE'') as name
from v_perf_t_evaluateaudit m WHERE  m.bustype=''assessment'' ) f
on f.proguid=t.guid
';
