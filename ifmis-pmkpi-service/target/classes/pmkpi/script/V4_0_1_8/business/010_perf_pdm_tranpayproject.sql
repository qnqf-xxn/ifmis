
begin

execute immediate '
CREATE OR REPLACE VIEW PERF_PDM_TRANPAYPROJECT AS
select t.guid as guid, --项目guid
       t.pro_id as pro_id, --项目id
       t.PRO_CODE as pro_code, --项目编码
       t.PRO_NAME as pro_name, --项目名称
       t.LEADER_NAME as pro_creater, --项目负责人
       t.V_COL1 as is_perfeval, --是否事前绩效评估
       t.V_COL3 as is_publish, --是否绩效目标公开
       t.V_COL4 as publishremark, --非绩效目标公开原因
       '''' as is_welfare, --是否政府投资公益项目
       t.pro_start_year as startdate, --项目开始时间
       t.V_COL5 as is_addpro, --是否新增项目
       ''1'' as annualamt, --本年度项目资金
       '''' as amtincrease, --对比上年度资金增幅
       f.name as evalremark, --事前绩效评估审核结论
       b.freview as firstremark, --绩效目标初审结论
       b.sreview as reexamineremark, --绩效目标复审结论
       t.YEAR as year, --年度
       t.PROVINCE as province, --区划
       t.AGENCY_CODE as agencyguid, --单位
       t.mof_dep_code as finintorgguid, --处室
       b.REMARK as OPINION_REMARK, --审核意见
       b.conclusion as AUDIT_CONCLUSION, --审核结论
       t.mof_dep_code as mof_dep_code,
       t.PROJECTKIND as PROJECTKIND,
       tra.ADVANCE,
       t.MANAGE_DEPT_CODE as MANAGE_DEPT_CODE,
       t.MANAGE_MOF_DEP_CODE as MANAGE_MOF_DEP_CODE,
       tra.taskguid as taskguid,
       ''zyzfprogram'' bustype,
       t.is_deleted as is_deleted,
       t.pro_cat_code pro_kind_code
  from v_perf_project_info t
  left join fasp_t_pubdepartment a
    on a.guid = t.finintorgguid

  left join (SELECT n.pro_code,
                    (select q.name
                       from v_perf_enum q
                      where q.guid = m.freview
                        and q.elementcode = ''REVIEWOPINION'') as freview,
                    (select q.name
                       from v_perf_enum q
                      where q.guid = m.sreview
                        and q.elementcode = ''REVIEWOPINION'') as sreview,
                    DECODE(k.CONCLUSION, ''1'', ''通过'', ''2'', ''不通过'') as conclusion,
                    k.remark
               FROM v_perf_t_review n
               left join perf_t_audititems m
                 on m.mainguid = n.guid
                and m.tempguid = ''B9C7D80EC0298933E053B11FA8C0A5D6''
               left join v_perf_t_auditmain k
                 on k.mainguid = n.guid
              WHERE n.type = ''zyzfprogram''
                and n.islast = 1
                and n.isconfirm = ''1'') b
    on b.pro_code = t.pro_code
  left join fasp_t_causer c
    on c.guid = t.creater
  left join (SELECT m.proguid,
                    m.audittype,
                    (select q.name
                       from v_perf_enum q
                      where q.guid = m.audittype
                        and q.elementcode = ''AUDITTYPE'') as name
               from v_perf_t_evaluateaudit m
              WHERE m.bustype = ''assessment'') f
    on f.proguid = t.guid
  left join (select ADVANCE,taskguid,PRO_CODE from V_BGT_TRA group by ADVANCE,taskguid,PRO_CODE)  tra
   on tra.PRO_CODE = t.PRO_CODE
 where t.PROJECTKIND like ''32%''
and exists (select * from (select * from  V_BGT_TRA where pro_code in (select p.pro_code from V_BGT_TRA p  group by p.pro_code)and is_deleted = ''2'') n where n.pro_code=t.pro_code)
';
