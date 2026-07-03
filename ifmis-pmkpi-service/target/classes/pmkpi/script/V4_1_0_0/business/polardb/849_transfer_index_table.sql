
i number;
begin

  select count(1) into i from user_tab_columns where table_name = 'PERF_TRANSFER_INDICATOR' and column_name = 'KPI_LV1';
  if i = 1 then
     execute immediate 'alter table PERF_TRANSFER_INDICATOR rename column kpi_lv1 to LV1_PERF_IND_CODE';
     --execute immediate 'alter table PERF_TRANSFER_INDICATOR modify lv1_perf_ind_code VARCHAR2(20)';
	execute immediate 'select fn_altertablecol(''PERF_TRANSFER_INDICATOR'', ''lv1_perf_ind_code'', ''VARCHAR2'', 20)';	 	 	 
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_TRANSFER_INDICATOR' and column_name = 'KPI_LV2';
  if i = 1 then
     execute immediate 'alter table PERF_TRANSFER_INDICATOR rename column kpi_lv2 to LV2_PERF_IND_CODE';
     --execute immediate 'alter table PERF_TRANSFER_INDICATOR modify lv2_perf_ind_code VARCHAR2(20)';
	execute immediate 'select fn_altertablecol(''PERF_TRANSFER_INDICATOR'', ''lv2_perf_ind_code'', ''VARCHAR2'', 20)';  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_TRANSFER_INDICATOR' and column_name = 'KPI_LV3';
  if i = 1 then
     execute immediate 'alter table PERF_TRANSFER_INDICATOR rename column kpi_lv3 to LV3_PERF_IND_CODE';
     --execute immediate 'alter table PERF_TRANSFER_INDICATOR modify lv3_perf_ind_code VARCHAR2(20)';
	execute immediate 'select fn_altertablecol(''PERF_TRANSFER_INDICATOR'', ''lv3_perf_ind_code'', ''VARCHAR2'', 20)';  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_TRANSFER_INDICATOR' and column_name = 'SUB_MOF_CODE';
  if i = 1 then
     execute immediate 'alter table PERF_TRANSFER_INDICATOR rename column sub_mof_code to SUB_MOF_DIV_CODE';
  end if;

  select count(1) into i from user_tab_columns where table_name = 'PERF_TRANSFER_INDICATOR' and column_name = 'MOF_DIV_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_TRANSFER_INDICATOR add mof_div_name VARCHAR2(360)';
     execute immediate 'comment on column PERF_TRANSFER_INDICATOR.mof_div_name is ''财政区划名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_TRANSFER_INDICATOR' and column_name = 'AGENCY_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_TRANSFER_INDICATOR add agency_name VARCHAR2(300)';
     execute immediate 'comment on column PERF_TRANSFER_INDICATOR.agency_name is ''单位名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_TRANSFER_INDICATOR' and column_name = 'PRO_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_TRANSFER_INDICATOR add pro_name VARCHAR2(180)';
     execute immediate 'comment on column PERF_TRANSFER_INDICATOR.pro_name is ''项目名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_TRANSFER_INDICATOR' and column_name = 'LV1_PERF_IND_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_TRANSFER_INDICATOR add lv1_perf_ind_name varchar2(1000)';
     execute immediate 'comment on column PERF_TRANSFER_INDICATOR.lv1_perf_ind_name is ''一级绩效指标名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_TRANSFER_INDICATOR' and column_name = 'LV2_PERF_IND_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_TRANSFER_INDICATOR add lv2_perf_ind_name varchar2(1000)';
     execute immediate 'comment on column PERF_TRANSFER_INDICATOR.lv2_perf_ind_name is ''二级绩效指标名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_TRANSFER_INDICATOR' and column_name = 'LV3_PERF_IND_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_TRANSFER_INDICATOR add lv3_perf_ind_name varchar2(1000)';
     execute immediate 'comment on column PERF_TRANSFER_INDICATOR.lv3_perf_ind_name is ''三级绩效指标名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_TRANSFER_INDICATOR' and column_name = 'SUB_MOF_DIV_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_TRANSFER_INDICATOR add sub_mof_div_name VARCHAR2(360)';
     execute immediate 'comment on column PERF_TRANSFER_INDICATOR.sub_mof_div_name is ''下级财政区划名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_TRANSFER_INDICATOR' and column_name = 'PERF_OBJ_TYPE_CODE';
  if i = 0 then
     execute immediate 'alter table PERF_TRANSFER_INDICATOR add perf_obj_type_code VARCHAR2(1)';
     execute immediate 'comment on column PERF_TRANSFER_INDICATOR.perf_obj_type_code is ''绩效目标类型代码''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_TRANSFER_INDICATOR' and column_name = 'PERF_OBJ_TYPE_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_TRANSFER_INDICATOR add perf_obj_type_name VARCHAR2(60)';
     execute immediate 'comment on column PERF_TRANSFER_INDICATOR.perf_obj_type_name is ''绩效目标类型名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_TRANSFER_INDICATOR' and column_name = 'SPE_PRO_CODE';
  if i = 0 then
     execute immediate 'alter table PERF_TRANSFER_INDICATOR add spe_pro_code VARCHAR2(21)';
     execute immediate 'comment on column PERF_TRANSFER_INDICATOR.spe_pro_code is ''具体项目代码''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_TRANSFER_INDICATOR' and column_name = 'SPE_PRO_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_TRANSFER_INDICATOR add spe_pro_name VARCHAR2(180)';
     execute immediate 'comment on column PERF_TRANSFER_INDICATOR.spe_pro_name is ''具体项目名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_TRANSFER_INDICATOR' and column_name = 'MOF_AUD_OPINION_CODE';
  if i = 0 then
     execute immediate 'alter table PERF_TRANSFER_INDICATOR add mof_aud_opinion_code VARCHAR2(1)';
     execute immediate 'comment on column PERF_TRANSFER_INDICATOR.mof_aud_opinion_code is ''财政审核意见代码''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_TRANSFER_INDICATOR' and column_name = 'MOF_AUD_OPINION_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_TRANSFER_INDICATOR add MOF_AUD_OPINION_NAME VARCHAR2(60)';
     execute immediate 'comment on column PERF_TRANSFER_INDICATOR.MOF_AUD_OPINION_NAME is ''财政审核意见名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_TRANSFER_INDICATOR' and column_name = 'BGT_ID';
  if i = 0 then
     execute immediate 'alter table PERF_TRANSFER_INDICATOR add bgt_id VARCHAR2(38)';
     execute immediate 'comment on column PERF_TRANSFER_INDICATOR.bgt_id is ''指标主键''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_TRANSFER_INDICATOR' and column_name = 'ORI_DIV_CODE';
  if i = 0 then
     execute immediate 'alter table PERF_TRANSFER_INDICATOR add ori_div_code VARCHAR2(9)';
     execute immediate 'comment on column PERF_TRANSFER_INDICATOR.ori_div_code is ''来源方财政区划代码''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_TRANSFER_INDICATOR' and column_name = 'ORI_DIV_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_TRANSFER_INDICATOR add ori_div_name VARCHAR2(360)';
     execute immediate 'comment on column PERF_TRANSFER_INDICATOR.ori_div_name is ''来源方财政区划名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_TRANSFER_INDICATOR' and column_name = 'IS_LAST_INST';
  if i = 0 then 
     execute immediate 'alter table PERF_TRANSFER_INDICATOR add IS_LAST_INST number(1)';
     execute immediate 'comment on column PERF_TRANSFER_INDICATOR.IS_LAST_INST is ''是否终审''';
  end if;
