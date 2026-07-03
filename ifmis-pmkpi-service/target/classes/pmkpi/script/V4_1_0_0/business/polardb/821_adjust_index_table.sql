
i number;
begin
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTINDEX' and column_name = 'KPI_LV1';
  if i = 1 then
     execute immediate 'alter table PERF_T_ADJUSTINDEX rename column kpi_lv1 to LV1_PERF_IND_CODE';
     --execute immediate 'alter table PERF_T_ADJUSTINDEX modify lv1_perf_ind_code VARCHAR2(20)';
	 execute immediate 'select fn_altertablecol(''PERF_T_ADJUSTINDEX'', ''lv1_perf_ind_code'', ''VARCHAR2'', 20)';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTINDEX' and column_name = 'KPI_LV2';
  if i = 1 then
     execute immediate 'alter table PERF_T_ADJUSTINDEX rename column kpi_lv2 to LV2_PERF_IND_CODE';
     --execute immediate 'alter table PERF_T_ADJUSTINDEX modify lv2_perf_ind_code VARCHAR2(20)';
	 execute immediate 'select fn_altertablecol(''PERF_T_ADJUSTINDEX'', ''lv2_perf_ind_code'', ''VARCHAR2'', 20)';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTINDEX' and column_name = 'KPI_LV3';
  if i = 1 then
     execute immediate 'alter table PERF_T_ADJUSTINDEX rename column kpi_lv3 to LV3_PERF_IND_CODE';
     --execute immediate 'alter table PERF_T_ADJUSTINDEX modify lv3_perf_ind_code VARCHAR2(20)';
	 execute immediate 'select fn_altertablecol(''PERF_T_ADJUSTINDEX'', ''lv3_perf_ind_code'', ''VARCHAR2'', 20)';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTINDEX' and column_name = 'SUB_MOF_CODE';
  if i = 1 then
     execute immediate 'alter table PERF_T_ADJUSTINDEX rename column sub_mof_code to SUB_MOF_DIV_CODE';
  end if;

  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTINDEX' and column_name = 'MOF_DIV_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTINDEX add mof_div_name VARCHAR2(360)';
     execute immediate 'comment on column PERF_T_ADJUSTINDEX.mof_div_name is ''财政区划名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTINDEX' and column_name = 'AGENCY_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTINDEX add agency_name VARCHAR2(300)';
     execute immediate 'comment on column PERF_T_ADJUSTINDEX.agency_name is ''单位名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTINDEX' and column_name = 'PRO_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTINDEX add pro_name VARCHAR2(180)';
     execute immediate 'comment on column PERF_T_ADJUSTINDEX.pro_name is ''项目名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTINDEX' and column_name = 'LV1_PERF_IND_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTINDEX add lv1_perf_ind_name varchar2(1000)';
     execute immediate 'comment on column PERF_T_ADJUSTINDEX.lv1_perf_ind_name is ''一级绩效指标名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTINDEX' and column_name = 'LV2_PERF_IND_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTINDEX add lv2_perf_ind_name varchar2(1000)';
     execute immediate 'comment on column PERF_T_ADJUSTINDEX.lv2_perf_ind_name is ''二级绩效指标名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTINDEX' and column_name = 'LV3_PERF_IND_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTINDEX add lv3_perf_ind_name varchar2(1000)';
     execute immediate 'comment on column PERF_T_ADJUSTINDEX.lv3_perf_ind_name is ''三级绩效指标名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTINDEX' and column_name = 'SUB_MOF_DIV_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTINDEX add sub_mof_div_name VARCHAR2(360)';
     execute immediate 'comment on column PERF_T_ADJUSTINDEX.sub_mof_div_name is ''下级财政区划名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTINDEX' and column_name = 'PERF_OBJ_TYPE_CODE';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTINDEX add perf_obj_type_code VARCHAR2(1)';
     execute immediate 'comment on column PERF_T_ADJUSTINDEX.perf_obj_type_code is ''绩效目标类型代码''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTINDEX' and column_name = 'PERF_OBJ_TYPE_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTINDEX add perf_obj_type_name VARCHAR2(60)';
     execute immediate 'comment on column PERF_T_ADJUSTINDEX.perf_obj_type_name is ''绩效目标类型名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTINDEX' and column_name = 'SPE_PRO_CODE';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTINDEX add spe_pro_code VARCHAR2(21)';
     execute immediate 'comment on column PERF_T_ADJUSTINDEX.spe_pro_code is ''具体项目代码''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTINDEX' and column_name = 'SPE_PRO_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTINDEX add spe_pro_name VARCHAR2(180)';
     execute immediate 'comment on column PERF_T_ADJUSTINDEX.spe_pro_name is ''具体项目名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTINDEX' and column_name = 'MOF_AUD_OPINION_CODE';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTINDEX add mof_aud_opinion_code VARCHAR2(1)';
     execute immediate 'comment on column PERF_T_ADJUSTINDEX.mof_aud_opinion_code is ''财政审核意见代码''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTINDEX' and column_name = 'MOF_AUD_OPINION_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTINDEX add MOF_AUD_OPINION_NAME varchar2(60)';
     execute immediate 'comment on column PERF_T_ADJUSTINDEX.MOF_AUD_OPINION_NAME is ''财政审核意见名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTINDEX' and column_name = 'BGT_ID';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTINDEX add bgt_id VARCHAR2(38)';
     execute immediate 'comment on column PERF_T_ADJUSTINDEX.bgt_id is ''指标主键''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTINDEX' and column_name = 'ORI_DIV_CODE';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTINDEX add ori_div_code VARCHAR2(9)';
     execute immediate 'comment on column PERF_T_ADJUSTINDEX.ori_div_code is ''来源方财政区划代码''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTINDEX' and column_name = 'ORI_DIV_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTINDEX add ori_div_name VARCHAR2(360)';
     execute immediate 'comment on column PERF_T_ADJUSTINDEX.ori_div_name is ''来源方财政区划名称''';
  end if;

  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTINDEX' and column_name = 'DEPT_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTINDEX add DEPT_NAME VARCHAR2(300)';
     execute immediate 'comment on column PERF_T_ADJUSTINDEX.DEPT_NAME is ''部门名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTINDEX' and column_name = 'IS_LAST_INST';
  if i = 0 then 
     execute immediate 'alter table PERF_T_ADJUSTINDEX add IS_LAST_INST number(1)';
     execute immediate 'comment on column PERF_T_ADJUSTINDEX.IS_LAST_INST is ''是否终审''';
  end if;


