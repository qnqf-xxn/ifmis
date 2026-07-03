
begin

execute immediate '
CREATE OR REPLACE VIEW PERF_PDM_PROJECT AS
select
t.guid as guid,--项目guid
t.pro_id as pro_id,--项目id
t.PRO_CODE as pro_code,--项目编码
t.PRO_NAME as pro_name,--项目名称
t.LEADER_NAME as pro_creater,--项目负责人
t.V_COL1 as is_perfeval,--是否事前绩效评估
t.V_COL3 as is_publish,--是否绩效目标公开
t.V_COL4 as publishremark,--非绩效目标公开原因
'''' as is_welfare,--是否政府投资公益项目
t.pro_start_year as startdate,--项目开始时间
t.V_COL5 as is_addpro,--是否新增项目
'''' as annualamt,--本年度项目资金
'''' as amtincrease,--对比上年度资金增幅
f.name as evalremark,--事前绩效评估审核结论
b.freview as firstremark,--绩效目标初审结论
b.sreview as reexamineremark,--绩效目标复审结论
t.YEAR as year,--年度
t.PROVINCE as province,--区划
t.AGENCY_CODE as agencyguid,--单位
t.mof_dep_code as finintorgguid,--处室
b.REMARK as opinion_remark,--审核意见
b.conclusion as audit_conclusion,--审核结论
''A69147082E975D0733386A42C3E5F4B5'' as taskguid,
''program'' as bustype,
''goal'' as protype,
t.is_deleted  as is_deleted,
t.pro_cat_code as pro_kind_code
from v_pm_project_info_forbdm t
left join (SELECT n.pro_code,
(select q.name from v_perf_enum q where q.guid=m.freview and q.elementcode=''REVIEWOPINION'') as freview,
(select q.name from v_perf_enum q where q.guid=m.sreview and q.elementcode=''REVIEWOPINION'') as sreview,
DECODE(k.CONCLUSION,''1'',''通过'',''2'',''不通过'') as conclusion,k.remark
FROM v_perf_t_review n left join perf_t_audititems m on m.mainguid=n.guid and m.tempguid = ''B9C7D80EC0298933E053B11FA8C0A5D6''
left join v_perf_t_auditmain k on k.mainguid=n.guid
WHERE  n.type=''goal'' and n.islast=1 and n.isconfirm=''1'') b on b.pro_code = t.pro_code
left join (SELECT m.proguid,m.audittype,
(select q.name from v_perf_enum q where q.guid=m.audittype and q.elementcode=''AUDITTYPE'' ) as name
from v_perf_t_evaluateaudit m WHERE  m.bustype=''assessment'' ) f
on f.proguid=t.guid
where exists (select * from (select p.pro_code,p.proguid from v_bgt_pm_annual p where p.is_deleted=''2'' group by p.pro_code,p.proguid)n where n.pro_code=t.pro_code)
union all
select
t.guid as guid,--项目guid
t.pro_id as pro_id,--项目id
t.PRO_CODE as pro_code,--项目编码
t.PRO_NAME as pro_name,--项目名称
t.LEADER_NAME as pro_creater,--项目负责人
t.V_COL1 as is_perfeval,--是否事前绩效评估
t.V_COL3 as is_publish,--是否绩效目标公开
t.V_COL4 as publishremark,--非绩效目标公开原因
'''' as is_welfare,--是否政府投资公益项目
t.pro_start_year as startdate,--项目开始时间
t.V_COL5 as is_addpro,--是否新增项目
'''' as annualamt,--本年度项目资金
'''' as amtincrease,--对比上年度资金增幅
f.name as evalremark,--事前绩效评估审核结论
b.freview as firstremark,--绩效目标初审结论
b.sreview as reexamineremark,--绩效目标复审结论
t.YEAR as year,--年度
t.PROVINCE as province,--区划
t.AGENCY_CODE as agencyguid,--单位
t.mof_dep_code as finintorgguid,--处室
b.REMARK as opinion_remark,--审核意见
b.conclusion audit_conclusion,--审核结论
''9EE3A842793449818960559B00660C1B'' as taskguid,
''program'' as bustype,
''goal'' as protype,
t.is_deleted  as is_deleted,
t.pro_cat_code as pro_kind_code
from v_pm_project_info_forbdm t
left join (SELECT n.pro_code,
(select q.name from v_perf_enum q where q.guid=m.freview and q.elementcode=''REVIEWOPINION'') as freview,
(select q.name from v_perf_enum q where q.guid=m.sreview and q.elementcode=''REVIEWOPINION'') as sreview,
DECODE(k.CONCLUSION,''1'',''通过'',''2'',''不通过'') as conclusion,k.remark
FROM v_perf_t_review n left join perf_t_audititems m on m.mainguid=n.guid and m.tempguid = ''B9C7D80EC0298933E053B11FA8C0A5D6''
left join v_perf_t_auditmain k on k.mainguid=n.guid
WHERE  n.type=''goal'' and n.islast=1 and n.isconfirm=''1'') b on b.pro_code = t.pro_code
left join (SELECT m.proguid,m.audittype,
(select q.name from v_perf_enum q where q.guid=m.audittype and q.elementcode=''AUDITTYPE'') as name
from v_perf_t_evaluateaudit m WHERE  m.bustype=''assessment'' ) f
on f.proguid=t.guid
where exists (select * from (select p.pro_code,p.proguid from v_bgt_pm_annual p where p.is_deleted=''2'' group by p.pro_code,p.proguid)n where n.pro_code=t.pro_code)
';

execute immediate '
CREATE OR REPLACE VIEW PERF_BGT_DEPT AS
select
t.guid as guid,--主键guid
t.code as dept_code,--部门编号
t.name as dept_name,--预算部门名称
a.name as finintorgguid,--管理处室
'''' as bgttotalamt,--预算总资金（元）
t.year as bgtyear,--预算年度
b.freview as firstremark,--绩效目标初审结论
b.sreview as reexamineremark,--绩效目标复审结论
t.year as year,--年度
t.province as province,--区划
t.agencyguid as agencyguid,--单位
b.REMARK as opinion_remark,--审核意见
b.conclusion as audit_conclusion,--审核结论
''A69147082E975D0733386A42C3E5F4B5'' as taskguid,
''dept'' as bustype,
''goal'' as protype,
2  as is_deleted
from v_perf_t_deptperfdeclare t
left join fasp_t_pubdepartment a on a.guid=t.finintorgguid
left join (SELECT n.proguid,
(select q.name from v_perf_enum q where q.guid=m.freview and q.elementcode=''REVIEWOPINION'') as freview,
(select q.name from v_perf_enum q where q.guid=m.sreview and q.elementcode=''REVIEWOPINION'') as sreview,
DECODE(k.CONCLUSION,''1'',''通过'',''2'',''不通过'') as conclusion,k.remark
FROM v_perf_t_review n left join perf_t_audititems m on m.mainguid=n.guid and m.tempguid = ''B9C7D80EC0298933E053B11FA8C0A5D6''
left join v_perf_t_auditmain k on k.mainguid=n.guid
WHERE  n.type=''goal'' and n.islast=1 and n.isconfirm=''1'') b on b.proguid = t.guid
union all
select
t.guid as guid,--主键guid
t.code as dept_code,--部门编号
t.name as dept_name,--预算部门名称
a.name as finintorgguid,--管理处室
'''' as bgttotalamt,--预算总资金（元）
t.year as bgtyear,--预算年度
b.freview as firstremark,--绩效目标初审结论
b.sreview as reexamineremark,--绩效目标复审结论
t.year as year,--年度
t.province as province,--区划
t.agencyguid as agencyguid,--单位
b.REMARK as opinion_remark,--审核意见
b.conclusion as audit_conclusion,--审核结论
''9EE3A842793449818960559B00660C1B'' as taskguid,
''dept'' as bustype,
''goal'' as protype,
2  as is_deleted
from v_perf_t_deptperfdeclare t
left join fasp_t_pubdepartment a on a.guid=t.finintorgguid
left join (SELECT n.proguid,
(select q.name from v_perf_enum q where q.guid=m.freview and q.elementcode=''REVIEWOPINION'') as freview,
(select q.name from v_perf_enum q where q.guid=m.sreview and q.elementcode=''REVIEWOPINION'') as sreview,
DECODE(k.CONCLUSION,''1'',''通过'',''2'',''不通过'') as conclusion,k.remark
FROM v_perf_t_review n left join perf_t_audititems m on m.mainguid=n.guid and m.tempguid = ''B9C7D80EC0298933E053B11FA8C0A5D6''
left join v_perf_t_auditmain k on k.mainguid=n.guid
WHERE  n.type=''goal'' and n.islast=1 and n.isconfirm=''1'') b on b.proguid = t.guid'
;
