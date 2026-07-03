i number;
begin

--整改问题任务表
select count(*) into i from user_tables t where t.table_name ='PERF_T_PROBLEMTASK';
if i=0 then
execute immediate '
create table perf_t_problemtask(
  guid         VARCHAR2(40) not null,
  name         VARCHAR2(200),			--评价项目名称
  lv1_title    VARCHAR2(200),			--一级标题
  lv2_title    VARCHAR2(200),			--二级标题
  detailcontent VARCHAR2(4000),			--问题涉及具体事项
  problemtype   VARCHAR2(40),			--整改类型：从“立行立改类”、“分阶段整改类”中选择
  start_time    VARCHAR2(17),			--评价结果反馈时间 YYYY/MM/DD
  end_time    VARCHAR2(17),				--任务截止时间 YYYY/MM/DD
  lead_agency   VARCHAR2(4000),			--整改牵头部门，可多选
  lead_department    VARCHAR2(40),	    --牵头处室
  linkman      VARCHAR2(40),			--联系人
  issue	       NUMBER(1) default 2, 	--是否下达：默认为2否
  create_time  VARCHAR2(17),
  update_time  VARCHAR2(17),
  finintorgguid VARCHAR2(40),
  year         CHAR(4) not null,
  province     VARCHAR2(9) not null,
  creater	   VARCHAR2(40), 
  vcol1        VARCHAR2(40),
  vcol2        VARCHAR2(40),
  vcol3        VARCHAR2(40),
  vcol4        VARCHAR2(40),
  vcol5        VARCHAR2(40)
)';
end if;

execute immediate 'create or replace view v_perf_t_problemtask as select t.* from perf_t_problemtask t 
where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';


--整改问题反馈表
select count(*) into i from user_tables t where t.table_name ='PERF_T_PROBLEMFEEDBACK';
if i=0 then
execute immediate '
create table perf_t_problemfeedback(
  guid         VARCHAR2(40) not null,
  name         VARCHAR2(200),			--评价项目名称
  lv1_title    VARCHAR2(200),			--一级标题
  lv2_title    VARCHAR2(200),			--二级标题
  detailcontent VARCHAR2(4000),			--问题涉及具体事项
  problemtype    VARCHAR2(40),			--整改类型：从“立行立改类”、“分阶段整改类”中选择
  start_time  VARCHAR2(17),				--评价结果反馈时间 YYYY/MM/DD
  end_time    VARCHAR2(17),				--任务截止时间 YYYY/MM/DD
  lead_agency    VARCHAR2(4000),		--整改牵头部门，可多选
  lead_department    VARCHAR2(40),	    --牵头处室
  linkman      VARCHAR2(40),			--联系人
  mainguid 	   VARCHAR2(40),			--整改任务ID
  agency_code   VARCHAR2(40),			--被评价单位/部门
  rectify_measures   VARCHAR2(4000),	--整改举措
  rectify_time   VARCHAR2(17),			--整改时限“立行立改类”问题为“下达时间+60日”，“分阶段整改类”问题为“下达时间+1年”
  rectify_result   VARCHAR2(4000),		--整改结果
  rectify_condition   VARCHAR2(4000),	--整改情况
  rectify_reason   VARCHAR2(4000),		--整改未到位原因及下步措施
  complete_time   VARCHAR2(17),			--整改实际完成时间 YYYY/MM/DD
  budget_application   VARCHAR2(4000),	--预算应用（具体调整金额）
  introduce_system   VARCHAR2(4000),	--出台或更新制度
  perfect_mechanism  VARCHAR2(4000),	--完善机制
  other_achievement  VARCHAR2(4000),	--其他成果
  extension_reason   VARCHAR2(4000),	--延期原因
  extension_time   VARCHAR2(17),		--延期申请原因
  report_time  VARCHAR2(17),			--反馈上报时间
  extension_status NUMBER(1) default 0, --申请延期状态：默认为0,1为申请，2为通过
  is_end	   NUMBER(1) default 2, 	--是否销号：默认为2否
  evaluated_department    VARCHAR2(40),	--被评价单位责任处室
  evaluated_linkman    VARCHAR2(40),	--被评价单位联系人
  evaluated_contact    VARCHAR2(40),	--被评价单位联系方式
  create_time  VARCHAR2(17),
  update_time  VARCHAR2(17),
  year         CHAR(4) not null,
  province     VARCHAR2(9) not null,
  ordernum     NUMBER(9),				--序号
  creater			  VARCHAR2(40),
  wfstatus            VARCHAR2(40),
  wfid                VARCHAR2(40),
  auditor             VARCHAR2(32),
  lastupdatetime      VARCHAR2(17),
  vcol1        VARCHAR2(40),
  vcol2        VARCHAR2(40),
  vcol3        VARCHAR2(40),
  vcol4        VARCHAR2(40),
  vcol5        VARCHAR2(40)
)';
end if;

execute immediate 'create or replace view v_perf_t_problemfeedback as select t.* from perf_t_problemfeedback t 
where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

execute immediate 'create or replace view V_PERF_T_PROBLEMTASKQUERY as 
select t.*,
t.agency_code as agencyguid,
t.lead_department as finintorgguid,
case when (select count(1) from v_perf_file a where a.billguid = t.guid and a.filetype=''problemtaskfeedback001'' group by filetype,billguid) > 0 then 1 else 0 end as plan_file,
case when (select count(1) from v_perf_file a where a.billguid = t.guid and a.filetype=''problemtaskfeedback002'' group by filetype,billguid) > 0 then 1 else 0 end as support_file
from v_perf_t_problemfeedback t 
where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';