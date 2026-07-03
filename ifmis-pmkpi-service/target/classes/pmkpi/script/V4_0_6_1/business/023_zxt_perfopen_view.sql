begin
execute immediate 'create or replace view V_PERF_MANCEOPEN as
with temp as
(
 select distinct pro_code,''本年财政拨款'' as zjly,''年初预算项目''as  xmlb from  v_bgt_pm_annual temp1 where temp1.is_deleted = 2
 and nvl(temp1.rec_flag,0) =0 and temp1.BUDGET_LEVEL_CODE = 2
 and temp1.FIN_AUDIT_MONEY <> 0
 union
 select distinct pro_code,''本年财政拨款'' as zjly,''中央转移支付项目''as  xmlb from  v_bgt_pm_annual temp1 where temp1.is_deleted = 2
 and nvl(temp1.rec_flag,0) =2 and temp1.BUDGET_LEVEL_CODE = 1
  and temp1.FIN_AUDIT_MONEY <> 0
  union
 select distinct pro_code,''上年结转资金'' as zjly,''年终结转项目'' as  xmlb from  v_bgt_pm_annual temp1 where temp1.is_deleted = 2
 and nvl(temp1.rec_flag,0) =2 and temp1.BUDGET_LEVEL_CODE = 2
  and temp1.FIN_AUDIT_MONEY <> 0
   union
 select distinct pro_code,''本年财政拨款'' as zjly,''省对下转移支付项目''as  xmlb from  v_bgt_tra  temp2 where temp2.is_deleted = 2
  and temp2.FIN_AUDIT_MONEY <> 0
)
--年初安排项目
select c.guid, --主键ID
	v.guid as projguid, --项目guid
t.MANAGE_MOF_DEP_CODE, --处室
t.MANAGE_MOF_DEP_CODE as finintorgguid, --处室
  (select MANAGE_DEPT_CODE
          from pm_project_info a
         where a.pro_code = t.pro_code
           and a.ISHISTORY=2
           and a.is_Deleted = 2 ) dept_code, --部门  
t.AGENCY_CODE,--单位
t.AGENCY_CODE as AGENCYGUID,--单位
t.PRO_KIND_CODE,--项目类型
t.PRO_CODE , --项目
v.pro_name,
t.money, --预算金额
(case when (t.REC_FLAG = 2 and t.BUDGET_LEVEL_CODE = 1)
 then ''中央转移支付项目''
   when (t.REC_FLAG = 2 and t.BUDGET_LEVEL_CODE = 2)
     then ''年终结转项目''
       else
           ''年初预算项目''
           end )xmly ,--项目来源
 (case when exists(select 1 from v_pm_perf_goal_info a where a.pro_code = t.pro_code)
  then ''是''
    else ''否''
      end )istbjx, --是否填报绩效
''01'' as perfopen, --绩效公开类型
c.isopen, --是否公开
c.openamt, --公开金额
c.openurl,  --公开地址
c.openreason, --不开公开原因
c.wfid, --流程ID
c.wfstatus,	   --流程状态
c.auditor,
c.updatetime,
c.lastupdatetime,
c.is_deleted,
v.year,
v.province
 from (select a.MANAGE_MOF_DEP_CODE,a.AGENCY_CODE,a.PRO_KIND_CODE,a.pro_code,a.REC_FLAG,a.BUDGET_LEVEL_CODE,sum(a.FIN_AUDIT_MONEY) as money from v_bgt_pm_annual a
 where a.IS_DELETED = 2
and a.PRO_KIND_CODE in (''22'',''3'')
and a.TASKGUID is not null
group by a.MANAGE_MOF_DEP_CODE,a.AGENCY_CODE,a.PRO_KIND_CODE,a.pro_code,a.REC_FLAG,a.BUDGET_LEVEL_CODE) t
left join pm_project_info v 
 on t.pro_code = v.pro_code and v.is_deleted = 2 and v.ishistory = 2
 left join v_perf_t_manceopen c on v.pro_code = c.pro_code and c.bustype = ''01''
union
--年中追加项目
select c.guid, --主键ID
	   v.guid as projguid, --项目guid
	   v.MANAGE_MOF_DEP_CODE, --处室
	   v.MANAGE_MOF_DEP_CODE as finintorgguid, --处室
       v.MANAGE_DEPT_CODE, --部门
       v.AGENCY_CODE, --单位
	   V.AGENCY_CODE as AGENCYGUID,--单位
       v.PRO_CAT_CODE as PRO_KIND_CODE, --项目类型
       tt.pro_code, --项目
	   v.pro_name,
       tt.money, --预算金额
       ''年中追加项目'' xmly, --项目来源
       (case
         when exists (select 1
                 from v_pm_perf_goal_info a
                where a.pro_code = tt.pro_code) then
          ''是''
         else
          ''否''
       end) istbjx, --是否填报绩效
	   ''02'' as perfopen, --绩效公开类型
c.isopen, --是否公开
c.openamt, --公开金额
c.openurl,  --公开地址
c.openreason, --不开公开原因
c.wfid, --流程ID
c.wfstatus,	   --流程状态
c.auditor,
c.updatetime,
c.lastupdatetime,
c.is_deleted,
v.year,
v.province
  from  (select t.pro_code,sum(t.amt3) money from perf_t_profund t 
 where t.pro_code not in (select pro_code from v_bgt_pm_annual b where b.is_deleted = 2 )
 and t.pro_code  in (select pro_code from v_perf_project_info b where b.pro_cat_code in (''22'',''3'') and b.is_Deleted = 2
 and b.pro_lev = 2 )
 and t.PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
 and t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
 group by t.pro_code) tt
 left join v_perf_project_info v 
 on tt.pro_code = v.pro_code and v.is_deleted = 2 and v.ishistory = 2
 left join v_perf_t_manceopen c on v.pro_code = c.pro_code and c.bustype = ''02''
 union
 --绩效自评项目
select
c.guid,  --主键ID
a.projguid, --项目guid
a.manage_mof_dep_code,-- 处室
a.MANAGE_MOF_DEP_CODE as finintorgguid, --处室
a.MANAGE_DEPT_CODE,--部门
a.AGENCYGUID as agency_code ,--单位
A.AGENCYGUID ,--单位
(select pro_cat_code from pm_project_info where pro_code = a.pro_code and  IS_DELETED = 2 and ishistory= 2)pro_kind_code,--项目类型
a.pro_code, --项目
a.pro_name,
      nvl(b.amt3, 0.00) money ,---全年预算金额
       nvl(a.xmlb, ''年中追加项目'') xmly, ---项目来源 
            (case
         when exists (select 1
                 from v_pm_perf_goal_info aa
                where aa.pro_code = a.pro_code) then
          ''是''
         else
          ''否''
       end) istbjx,  --是否填报绩效
''03'' as perfopen, --绩效公开类型
c.isopen, --是否公开
c.openamt, --公开金额
c.openurl,  --公开地址
c.openreason, --不开公开原因
c.wfid, --流程ID
c.wfstatus,	   --流程状态
c.auditor,
c.updatetime,
c.lastupdatetime,
c.is_deleted,
to_char(a.year) as year,
a.province
  from (select t.guid,
			   t.projguid,
			   t.MANAGE_MOF_DEP_CODE,
               t.MANAGE_DEPT_CODE,
               t.AGENCYGUID,
               t.pro_code,
			   t.name as pro_name,
               t.WFSTATUS,
				t.province,
				t.year,
               temp.zjly,
               temp.xmlb
          from  PERF_V_SELFEVALTASK t
          left join temp
            on t.pro_CODE = temp.pro_code
         where t.BUSTYPE = ''program'') a
  left join (select t.PRO_CODE,
                    sum(t.amt3) amt3,
                    (case
                      when t.name = ''其他资金'' then
                       ''本年财政拨款''
                      else
                       nvl(t.name, ''本年财政拨款'')
                    end) as name
               from  V_PERF_T_SELFPROFUND t
              where t.amt3 <> 0
                and t.pro_code is not null
              group by t.AGENCY_CODE,
                       t.pro_code,
                       (case
                         when t.name = ''其他资金'' then
                          ''本年财政拨款''
                         else
                          nvl(t.name, ''本年财政拨款'')
                       end)) b
    on a.pro_CODE = b.pro_code
   and a.zjly = b.name
   left join v_perf_t_manceopen c on a.pro_code = c.pro_code and c.bustype = ''03''';