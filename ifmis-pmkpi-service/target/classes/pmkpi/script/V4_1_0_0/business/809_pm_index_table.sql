
i number;
begin

  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR' and column_name = 'KPI_LV1';
  if i = 1 then
     execute immediate 'alter table PM_PERF_INDICATOR rename column kpi_lv1 to LV1_PERF_IND_CODE';
     execute immediate 'alter table PM_PERF_INDICATOR modify lv1_perf_ind_code VARCHAR2(20)';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR' and column_name = 'KPI_LV2';
  if i = 1 then
     execute immediate 'alter table PM_PERF_INDICATOR rename column kpi_lv2 to LV2_PERF_IND_CODE';
     execute immediate 'alter table PM_PERF_INDICATOR modify lv2_perf_ind_code VARCHAR2(20)';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR' and column_name = 'KPI_LV3';
  if i = 1 then
     execute immediate 'alter table PM_PERF_INDICATOR rename column kpi_lv3 to LV3_PERF_IND_CODE';
     execute immediate 'alter table PM_PERF_INDICATOR modify lv3_perf_ind_code VARCHAR2(20)';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR' and column_name = 'SUB_MOF_CODE';
  if i = 1 then
     execute immediate 'alter table PM_PERF_INDICATOR rename column sub_mof_code to SUB_MOF_DIV_CODE';
  end if;

  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR' and column_name = 'MOF_DIV_NAME';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR add mof_div_name VARCHAR2(360)';
     execute immediate 'comment on column PM_PERF_INDICATOR.mof_div_name is ''财政区划名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR' and column_name = 'AGENCY_NAME';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR add agency_name VARCHAR2(300)';
     execute immediate 'comment on column PM_PERF_INDICATOR.agency_name is ''单位名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR' and column_name = 'PRO_NAME';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR add pro_name VARCHAR2(180)';
     execute immediate 'comment on column PM_PERF_INDICATOR.pro_name is ''项目名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR' and column_name = 'LV1_PERF_IND_NAME';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR add lv1_perf_ind_name varchar2(1000)';
     execute immediate 'comment on column PM_PERF_INDICATOR.lv1_perf_ind_name is ''一级绩效指标名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR' and column_name = 'LV2_PERF_IND_NAME';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR add lv2_perf_ind_name varchar2(1000)';
     execute immediate 'comment on column PM_PERF_INDICATOR.lv2_perf_ind_name is ''二级绩效指标名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR' and column_name = 'LV3_PERF_IND_NAME';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR add lv3_perf_ind_name varchar2(1000)';
     execute immediate 'comment on column PM_PERF_INDICATOR.lv3_perf_ind_name is ''三级绩效指标名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR' and column_name = 'SUB_MOF_DIV_NAME';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR add sub_mof_div_name VARCHAR2(360)';
     execute immediate 'comment on column PM_PERF_INDICATOR.sub_mof_div_name is ''下级财政区划名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR' and column_name = 'PERF_OBJ_TYPE_CODE';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR add perf_obj_type_code VARCHAR2(1)';
     execute immediate 'comment on column PM_PERF_INDICATOR.perf_obj_type_code is ''绩效目标类型代码''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR' and column_name = 'PERF_OBJ_TYPE_NAME';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR add perf_obj_type_name VARCHAR2(60)';
     execute immediate 'comment on column PM_PERF_INDICATOR.perf_obj_type_name is ''绩效目标类型名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR' and column_name = 'SPE_PRO_CODE';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR add spe_pro_code VARCHAR2(21)';
     execute immediate 'comment on column PM_PERF_INDICATOR.spe_pro_code is ''具体项目代码''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR' and column_name = 'SPE_PRO_NAME';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR add spe_pro_name VARCHAR2(180)';
     execute immediate 'comment on column PM_PERF_INDICATOR.spe_pro_name is ''具体项目名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR' and column_name = 'MOF_AUD_OPINION_CODE';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR add mof_aud_opinion_code VARCHAR2(1)';
     execute immediate 'comment on column PM_PERF_INDICATOR.mof_aud_opinion_code is ''财政审核意见代码''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR' and column_name = 'MOF_AUD_OPINION_NAME';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR add MOF_AUD_OPINION_NAME VARCHAR2(60)';
     execute immediate 'comment on column PM_PERF_INDICATOR.MOF_AUD_OPINION_NAME is ''财政审核意见名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR' and column_name = 'BGT_ID';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR add bgt_id VARCHAR2(38)';
     execute immediate 'comment on column PM_PERF_INDICATOR.bgt_id is ''指标主键''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR' and column_name = 'ORI_DIV_CODE';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR add ori_div_code VARCHAR2(9)';
     execute immediate 'comment on column PM_PERF_INDICATOR.ori_div_code is ''来源方财政区划代码''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR' and column_name = 'ORI_DIV_NAME';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR add ori_div_name VARCHAR2(360)';
     execute immediate 'comment on column PM_PERF_INDICATOR.ori_div_name is ''来源方财政区划名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR' and column_name = 'IS_LAST_INST';
  if i = 0 then 
     execute immediate 'alter table PM_PERF_INDICATOR add IS_LAST_INST number(1)';
     execute immediate 'comment on column PM_PERF_INDICATOR.IS_LAST_INST is ''是否终审''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR' and column_name = 'VERSIONTYPE';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR add VERSIONTYPE number(1) default 0';
     execute immediate 'comment on column PM_PERF_INDICATOR.VERSIONTYPE is ''0 日常动态 1 编制 2 批复，3执行''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR' and column_name = 'IS_BACKUP';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR add IS_BACKUP number(1) default 2';
     execute immediate 'comment on column PM_PERF_INDICATOR.IS_BACKUP is ''1 版本记录 2 日常动态''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR' and column_name = 'IS_ADJ';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR add is_adj NUMBER(1) default 2';
     execute immediate 'comment on column PM_PERF_INDICATOR.is_adj is ''调整是否终审 2终审 1没有终审''';
  end if;

execute immediate '
create or replace view v_pm_perf_indicator as
select t.*
from pm_perf_indicator t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
      and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted = 2
	  and t.is_backup = 2 and nvl(t.is_adj, 2) = 2';


  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_TEMP' and column_name = 'KPI_LV1';
  if i = 1 then
     execute immediate 'alter table PM_PERF_INDICATOR_TEMP rename column kpi_lv1 to LV1_PERF_IND_CODE';
     execute immediate 'alter table PM_PERF_INDICATOR_TEMP modify lv1_perf_ind_code VARCHAR2(20)';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_TEMP' and column_name = 'KPI_LV2';
  if i = 1 then
     execute immediate 'alter table PM_PERF_INDICATOR_TEMP rename column kpi_lv2 to LV2_PERF_IND_CODE';
     execute immediate 'alter table PM_PERF_INDICATOR_TEMP modify lv2_perf_ind_code VARCHAR2(20)';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_TEMP' and column_name = 'KPI_LV3';
  if i = 1 then
     execute immediate 'alter table PM_PERF_INDICATOR_TEMP rename column kpi_lv3 to LV3_PERF_IND_CODE';
     execute immediate 'alter table PM_PERF_INDICATOR_TEMP modify lv3_perf_ind_code VARCHAR2(20)';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_TEMP' and column_name = 'SUB_MOF_CODE';
  if i = 1 then
     execute immediate 'alter table PM_PERF_INDICATOR_TEMP rename column sub_mof_code to SUB_MOF_DIV_CODE';
  end if;

  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_TEMP' and column_name = 'MOF_DIV_NAME';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR_TEMP add mof_div_name VARCHAR2(360)';
     execute immediate 'comment on column PM_PERF_INDICATOR_TEMP.mof_div_name is ''财政区划名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_TEMP' and column_name = 'AGENCY_NAME';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR_TEMP add agency_name VARCHAR2(300)';
     execute immediate 'comment on column PM_PERF_INDICATOR_TEMP.agency_name is ''单位名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_TEMP' and column_name = 'PRO_NAME';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR_TEMP add pro_name VARCHAR2(180)';
     execute immediate 'comment on column PM_PERF_INDICATOR_TEMP.pro_name is ''项目名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_TEMP' and column_name = 'LV1_PERF_IND_NAME';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR_TEMP add lv1_perf_ind_name varchar2(1000)';
     execute immediate 'comment on column PM_PERF_INDICATOR_TEMP.lv1_perf_ind_name is ''一级绩效指标名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_TEMP' and column_name = 'LV2_PERF_IND_NAME';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR_TEMP add lv2_perf_ind_name varchar2(1000)';
     execute immediate 'comment on column PM_PERF_INDICATOR_TEMP.lv2_perf_ind_name is ''二级绩效指标名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_TEMP' and column_name = 'LV3_PERF_IND_NAME';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR_TEMP add lv3_perf_ind_name varchar2(1000)';
     execute immediate 'comment on column PM_PERF_INDICATOR_TEMP.lv3_perf_ind_name is ''三级绩效指标名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_TEMP' and column_name = 'SUB_MOF_DIV_NAME';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR_TEMP add sub_mof_div_name VARCHAR2(360)';
     execute immediate 'comment on column PM_PERF_INDICATOR_TEMP.sub_mof_div_name is ''下级财政区划名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_TEMP' and column_name = 'PERF_OBJ_TYPE_CODE';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR_TEMP add perf_obj_type_code VARCHAR2(1)';
     execute immediate 'comment on column PM_PERF_INDICATOR_TEMP.perf_obj_type_code is ''绩效目标类型代码''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_TEMP' and column_name = 'PERF_OBJ_TYPE_NAME';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR_TEMP add perf_obj_type_name VARCHAR2(60)';
     execute immediate 'comment on column PM_PERF_INDICATOR_TEMP.perf_obj_type_name is ''绩效目标类型名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_TEMP' and column_name = 'SPE_PRO_CODE';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR_TEMP add spe_pro_code VARCHAR2(21)';
     execute immediate 'comment on column PM_PERF_INDICATOR_TEMP.spe_pro_code is ''具体项目代码''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_TEMP' and column_name = 'SPE_PRO_NAME';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR_TEMP add spe_pro_name VARCHAR2(180)';
     execute immediate 'comment on column PM_PERF_INDICATOR_TEMP.spe_pro_name is ''具体项目名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_TEMP' and column_name = 'MOF_AUD_OPINION_CODE';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR_TEMP add mof_aud_opinion_code VARCHAR2(1)';
     execute immediate 'comment on column PM_PERF_INDICATOR_TEMP.mof_aud_opinion_code is ''财政审核意见代码''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_TEMP' and column_name = 'MOF_AUD_OPINION_NAME';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR_TEMP add MOF_AUD_OPINION_NAME VARCHAR2(60)';
     execute immediate 'comment on column PM_PERF_INDICATOR_TEMP.MOF_AUD_OPINION_NAME is ''财政审核意见名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_TEMP' and column_name = 'BGT_ID';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR_TEMP add bgt_id VARCHAR2(38)';
     execute immediate 'comment on column PM_PERF_INDICATOR_TEMP.bgt_id is ''指标主键''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_TEMP' and column_name = 'ORI_DIV_CODE';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR_TEMP add ori_div_code VARCHAR2(9)';
     execute immediate 'comment on column PM_PERF_INDICATOR_TEMP.ori_div_code is ''来源方财政区划代码''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_TEMP' and column_name = 'ORI_DIV_NAME';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR_TEMP add ori_div_name VARCHAR2(360)';
     execute immediate 'comment on column PM_PERF_INDICATOR_TEMP.ori_div_name is ''来源方财政区划名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_TEMP' and column_name = 'IS_LAST_INST';
  if i = 0 then 
     execute immediate 'alter table PM_PERF_INDICATOR_TEMP add IS_LAST_INST number(1)';
     execute immediate 'comment on column PM_PERF_INDICATOR_TEMP.IS_LAST_INST is ''是否终审''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_TEMP' and column_name = 'IS_ADJ';
  if i = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR_TEMP add is_adj NUMBER(1) default 2';
     execute immediate 'comment on column PM_PERF_INDICATOR_TEMP.is_adj is ''调整是否终审 2终审 1没有终审''';
  end if;

execute immediate '
create or replace view v_pm_perf_indicator_temp as
select *
FROM pm_perf_indicator_temp 
WHERE province = global_multyear_cz.secu_f_global_parm(''DIVID'') and is_deleted = 2';
