
i number;
begin

  select count(1) into i from user_tab_columns where table_name = 'PERF_PROVISION_GOAL_INFO' and column_name = 'SUB_MOF_CODE';
  if i = 1 then
     execute immediate 'alter table PERF_PROVISION_GOAL_INFO rename column sub_mof_code to SUB_MOF_DIV_CODE';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_PROVISION_GOAL_INFO' and column_name = 'MOF_DIV_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_PROVISION_GOAL_INFO add mof_div_name varchar2(360)';
     execute immediate 'comment on column PERF_PROVISION_GOAL_INFO.mof_div_name is ''财政区划名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_PROVISION_GOAL_INFO' and column_name = 'AGENCY_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_PROVISION_GOAL_INFO add agency_name varchar2(300) ';
     execute immediate 'comment on column PERF_PROVISION_GOAL_INFO.agency_name is ''单位名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_PROVISION_GOAL_INFO' and column_name = 'PRO_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_PROVISION_GOAL_INFO add pro_name varchar2(180) ';
     execute immediate 'comment on column PERF_PROVISION_GOAL_INFO.pro_name is ''项目名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_PROVISION_GOAL_INFO' and column_name = 'SUB_MOF_DIV_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_PROVISION_GOAL_INFO add sub_mof_div_name varchar2(360)';
     execute immediate 'comment on column PERF_PROVISION_GOAL_INFO.sub_mof_div_name is ''下级财政区划名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_PROVISION_GOAL_INFO' and column_name = 'PERF_OBJ_TYPE_CODE';
  if i = 0 then
     execute immediate 'alter table PERF_PROVISION_GOAL_INFO add perf_obj_type_code varchar2(1) ';
     execute immediate 'comment on column PERF_PROVISION_GOAL_INFO.perf_obj_type_code is ''绩效目标类型代码''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_PROVISION_GOAL_INFO' and column_name = 'PERF_OBJ_TYPE_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_PROVISION_GOAL_INFO add perf_obj_type_name varchar2(60) ';
     execute immediate 'comment on column PERF_PROVISION_GOAL_INFO.perf_obj_type_name is ''绩效目标类型名称''';
  end if;

  select count(1) into i from user_tab_columns where table_name = 'PERF_PROVISION_GOAL_INFO' and column_name = 'SPE_PRO_CODE';
  if i = 0 then
     execute immediate 'alter table PERF_PROVISION_GOAL_INFO add spe_pro_code varchar2(21)';
     execute immediate 'comment on column PERF_PROVISION_GOAL_INFO.spe_pro_code is ''具体项目代码''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_PROVISION_GOAL_INFO' and column_name = 'SPE_PRO_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_PROVISION_GOAL_INFO add spe_pro_name varchar2(180)';
     execute immediate 'comment on column PERF_PROVISION_GOAL_INFO.spe_pro_name is ''具体项目名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_PROVISION_GOAL_INFO' and column_name = 'MOF_AUD_OPINION_CODE';
  if i = 0 then
     execute immediate 'alter table PERF_PROVISION_GOAL_INFO add mof_aud_opinion_code varchar2(1)';
     execute immediate 'comment on column PERF_PROVISION_GOAL_INFO.mof_aud_opinion_code is ''财政审核意见代码''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_PROVISION_GOAL_INFO' and column_name = 'MOF_AUD_OPINION_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_PROVISION_GOAL_INFO add MOF_AUD_OPINION_NAME varchar2(60)';
     execute immediate 'comment on column PERF_PROVISION_GOAL_INFO.MOF_AUD_OPINION_NAME is ''财政审核意见名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_PROVISION_GOAL_INFO' and column_name = 'BGT_ID';
  if i = 0 then
     execute immediate 'alter table PERF_PROVISION_GOAL_INFO add bgt_id varchar2(38)';
     execute immediate 'comment on column PERF_PROVISION_GOAL_INFO.bgt_id is ''指标主键''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_PROVISION_GOAL_INFO' and column_name = 'ORI_DIV_CODE';
  if i = 0 then
     execute immediate 'alter table PERF_PROVISION_GOAL_INFO add ori_div_code varchar2(9)';
     execute immediate 'comment on column PERF_PROVISION_GOAL_INFO.ori_div_code is ''来源方财政区划代码''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_PROVISION_GOAL_INFO' and column_name = 'ORI_DIV_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_PROVISION_GOAL_INFO add ori_div_name varchar2(360)';
     execute immediate 'comment on column PERF_PROVISION_GOAL_INFO.ori_div_name is ''来源方财政区划名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_PROVISION_GOAL_INFO' and column_name = 'FIN_PERF_CODE';
  if i = 0 then
     execute immediate 'alter table PERF_PROVISION_GOAL_INFO add FIN_PERF_CODE varchar2(4)';
     execute immediate 'comment on column PERF_PROVISION_GOAL_INFO.FIN_PERF_CODE is ''财政绩效目标审核结果代码''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_PROVISION_GOAL_INFO' and column_name = 'FIN_PERF_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_PROVISION_GOAL_INFO add FIN_PERF_NAME varchar2(100)';
     execute immediate 'comment on column PERF_PROVISION_GOAL_INFO.FIN_PERF_NAME is ''财政绩效目标审核结果''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_PROVISION_GOAL_INFO' and column_name = 'IS_LAST_INST';
  if i = 0 then 
     execute immediate 'alter table PERF_PROVISION_GOAL_INFO add IS_LAST_INST number(1)';
     execute immediate 'comment on column PERF_PROVISION_GOAL_INFO.IS_LAST_INST is ''是否终审''';
  end if;
 

execute immediate '
create or replace view v_perf_provision_goal_info as
select *
from PERF_PROVISION_GOAL_INFO t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted=2';
