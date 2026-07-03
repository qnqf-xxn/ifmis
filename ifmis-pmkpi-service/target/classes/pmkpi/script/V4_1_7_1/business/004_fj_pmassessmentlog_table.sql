 i number;
begin

select count(*) into i from user_tables t where t.table_name ='PERF_T_ASSESSMENT_LOG';
if i=0 then
  execute immediate '
create table PERF_T_ASSESSMENT_LOG
(
  guid       VARCHAR2(40) not null,
  mainguid   VARCHAR2(40),
  tempguid   VARCHAR2(40),
  scorenum   NUMBER(5,2),
  agencyguid VARCHAR2(40),
  status     NUMBER(1),
  createtime VARCHAR2(17),
  updatetime VARCHAR2(17) not null,
  creater    VARCHAR2(40),
  province   VARCHAR2(32) not null,
  year       NUMBER(4) not null,
  pro_code   VARCHAR2(40),
  is_deleted NUMBER(1),
  standard   VARCHAR2(4000),
  remarks    VARCHAR2(4000),
  bustype    VARCHAR2(40),
  logguid	 VARCHAR2(40)
)';

end if;


execute immediate '
create or replace view v_pm_perf_indicator_log as select
guid,
kpi_id,
fiscal_year,
mof_div_code,
mof_div_name,
agency_code,
agency_name,
pro_code,
pro_name,
lv1_perf_ind_code,
lv1_perf_ind_name,
lv2_perf_ind_code,
lv2_perf_ind_name,
lv3_perf_ind_code,
lv3_perf_ind_name,
kpi_content,
kpi_evalstd,
kpi_val,
kpi_remark,
sub_mof_div_code,
sub_mof_div_name,
perf_obj_type_code,
perf_obj_type_name,
spe_pro_code,
spe_pro_name,
mof_aud_opinion_code,
mof_aud_opinion_name,
bgt_id,
ori_div_code,
ori_div_name,
version,
version_name,
is_last_inst,
is_deleted,
update_time,
create_time,
computesign,
meterunit,
is_backup,
province,
mainguid,
yearflag,
ordernum,
logguid,
11 as opttype
from pm_perf_indicator_log';

execute immediate '
create or replace view v_perf_t_assessmentquery as select 
t.guid,
t.code,
t.name,
t.weight,
t.points,
t.superid,
t.levelno,
t.isleaf,
t.guid as tguid,
a.mainguid,
a.scorenum,
a.standard,
a.remarks,
t.bustype,
t.ordernum,
10 as opttype
from V_PERF_T_ASSESSMENTTEMP t
left join V_PERF_T_ASSESSMENT a
   on t.guid = a.tempguid
where nvl(t.bustype, ''assessment'') = ''assessment''
 order by t.ordernum';
 
execute immediate '
create or replace view v_perf_t_assessment_log as select 
t.guid,
t.code,
t.name,
t.weight,
t.points,
t.superid,
t.levelno,
t.isleaf,
t.guid as tguid,
a.mainguid,
a.scorenum,
a.standard,
a.remarks,
t.bustype,
a.logguid,
t.ordernum,
11 as opttype
from V_PERF_T_ASSESSMENTTEMP t
left join PERF_T_ASSESSMENT_LOG a
   on t.guid = a.tempguid
   and t.province = a.province
where nvl(t.bustype, ''assessment'') = ''assessment''
    and a.is_deleted = 2
 order by t.ordernum';