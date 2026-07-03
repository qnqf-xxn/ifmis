i number;
begin  
  --重构视图
  execute immediate'
  create or replace view v_perf_t_evaluationaudit as
select t.PRO_ID, --项目guid
       t.PROVINCE, --- 区划
       t.PRO_NAME, --项目名称
       t.MANAGE_DEPT_CODE, --主管部门
       t.AGENCYGUID, --单位
       t.PRO_START_YEAR, --项目设立年度
       round((decode(t1.declaration_amt, 0, 0, t1.declaration_amt) / 10000),
             2) as declaration_amt, --预算拟安排额度（当年申报预算）
       t2.organization, -- 评估机构
       t2.score, --评估得分
       t2.ispdm, --是否纳入项目库
       t2.opinions --问题及意见
  from v_pm_project_info t
  left join PM_ANNUAL_EXPPLAN_INFO t1
    on t.PRO_ID = t1.proguid and t1.fiscal_year = GLOBAL_MULTYEAR_CZ.V_PMYEAR
  left join perf_t_evaluationaudit t2
    on t2.proguid = t.PRO_ID';