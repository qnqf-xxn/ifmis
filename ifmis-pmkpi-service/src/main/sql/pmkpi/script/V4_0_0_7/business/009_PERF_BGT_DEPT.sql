  i integer;
begin
  
execute immediate'CREATE OR REPLACE VIEW PERF_BGT_DEPT AS
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
''A69147082E975D0733386A42C3E5F4B5'' as taskguid,
''dept'' bustype,
2  as is_deleted
from v_perf_t_deptperfdeclare t
left join fasp_t_pubdepartment a on a.guid=t.finintorgguid
left join (SELECT m.proguid,
(select q.name from v_perf_enum q where q.guid=m.freview and q.elementcode=''REVIEWOPINION'') as freview,
(select q.name from v_perf_enum q where q.guid=m.sreview and q.elementcode=''REVIEWOPINION'') as sreview 
FROM v_perf_t_review n left join perf_t_audititems m on m.proguid=n.proguid 
WHERE  n.type=''goal'' and n.islast=1 and n.isconfirm=''1'' and m.tempguid = ''B9C7D80EC0298933E053B11FA8C0A5D6'') b on b.proguid = t.guid   
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
''9EE3A842793449818960559B00660C1B'' as taskguid,
''dept'' bustype,
2  as is_deleted
from v_perf_t_deptperfdeclare t
left join fasp_t_pubdepartment a on a.guid=t.finintorgguid
left join (SELECT m.proguid,
(select q.name from v_perf_enum q where q.guid=m.freview and q.elementcode=''REVIEWOPINION'') as freview,
(select q.name from v_perf_enum q where q.guid=m.sreview and q.elementcode=''REVIEWOPINION'') as sreview 
FROM v_perf_t_review n left join perf_t_audititems m on m.proguid=n.proguid 
WHERE  n.type=''goal'' and n.islast=1 and n.isconfirm=''1'' and m.tempguid = ''B9C7D80EC0298933E053B11FA8C0A5D6'') b on b.proguid = t.guid
';
