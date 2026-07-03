
i number;
begin

  --项目目标备份表
  select count(1) into i from user_tables where table_name = 'PM_PERF_GOAL_INFO_ONE';
  if i = 1 then

    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_GOAL_INFO_ONE' and column_name = 'SUB_MOF_CODE';
    if i = 1 then
       execute immediate 'alter table PM_PERF_GOAL_INFO_ONE rename column sub_mof_code to SUB_MOF_DIV_CODE';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_GOAL_INFO_ONE' and column_name = 'MOF_DIV_NAME';
    if i = 0 then
       execute immediate 'alter table PM_PERF_GOAL_INFO_ONE add mof_div_name varchar2(360)';
       execute immediate 'comment on column PM_PERF_GOAL_INFO_ONE.mof_div_name is ''财政区划名称''';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_GOAL_INFO_ONE' and column_name = 'AGENCY_NAME';
    if i = 0 then
       execute immediate 'alter table PM_PERF_GOAL_INFO_ONE add agency_name varchar2(300) ';
       execute immediate 'comment on column PM_PERF_GOAL_INFO_ONE.agency_name is ''单位名称''';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_GOAL_INFO_ONE' and column_name = 'PRO_NAME';
    if i = 0 then
       execute immediate 'alter table PM_PERF_GOAL_INFO_ONE add pro_name varchar2(180) ';
       execute immediate 'comment on column PM_PERF_GOAL_INFO_ONE.pro_name is ''项目名称''';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_GOAL_INFO_ONE' and column_name = 'SUB_MOF_DIV_NAME';
    if i = 0 then
       execute immediate 'alter table PM_PERF_GOAL_INFO_ONE add sub_mof_div_name varchar2(360)';
       execute immediate 'comment on column PM_PERF_GOAL_INFO_ONE.sub_mof_div_name is ''下级财政区划名称''';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_GOAL_INFO_ONE' and column_name = 'PERF_OBJ_TYPE_CODE';
    if i = 0 then
       execute immediate 'alter table PM_PERF_GOAL_INFO_ONE add perf_obj_type_code varchar2(1) ';
       execute immediate 'comment on column PM_PERF_GOAL_INFO_ONE.perf_obj_type_code is ''绩效目标类型代码''';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_GOAL_INFO_ONE' and column_name = 'PERF_OBJ_TYPE_NAME';
    if i = 0 then
       execute immediate 'alter table PM_PERF_GOAL_INFO_ONE add perf_obj_type_name varchar2(60) ';
       execute immediate 'comment on column PM_PERF_GOAL_INFO_ONE.perf_obj_type_name is ''绩效目标类型名称''';
    end if;

    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_GOAL_INFO_ONE' and column_name = 'SPE_PRO_CODE';
    if i = 0 then
       execute immediate 'alter table PM_PERF_GOAL_INFO_ONE add spe_pro_code varchar2(21)';
       execute immediate 'comment on column PM_PERF_GOAL_INFO_ONE.spe_pro_code is ''具体项目代码''';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_GOAL_INFO_ONE' and column_name = 'SPE_PRO_NAME';
    if i = 0 then
       execute immediate 'alter table PM_PERF_GOAL_INFO_ONE add spe_pro_name varchar2(180)';
       execute immediate 'comment on column PM_PERF_GOAL_INFO_ONE.spe_pro_name is ''具体项目名称''';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_GOAL_INFO_ONE' and column_name = 'MOF_AUD_OPINION_CODE';
    if i = 0 then
       execute immediate 'alter table PM_PERF_GOAL_INFO_ONE add mof_aud_opinion_code varchar2(1)';
       execute immediate 'comment on column PM_PERF_GOAL_INFO_ONE.mof_aud_opinion_code is ''财政审核意见代码''';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_GOAL_INFO_ONE' and column_name = 'MOF_AUD_OPINION_NAME';
    if i = 0 then
       execute immediate 'alter table PM_PERF_GOAL_INFO_ONE add MOF_AUD_OPINION_NAME varchar2(60)';
       execute immediate 'comment on column PM_PERF_GOAL_INFO_ONE.MOF_AUD_OPINION_NAME is ''财政审核意见名称''';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_GOAL_INFO_ONE' and column_name = 'BGT_ID';
    if i = 0 then
       execute immediate 'alter table PM_PERF_GOAL_INFO_ONE add bgt_id varchar2(38)';
       execute immediate 'comment on column PM_PERF_GOAL_INFO_ONE.bgt_id is ''指标主键''';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_GOAL_INFO_ONE' and column_name = 'ORI_DIV_CODE';
    if i = 0 then
       execute immediate 'alter table PM_PERF_GOAL_INFO_ONE add ori_div_code varchar2(9)';
       execute immediate 'comment on column PM_PERF_GOAL_INFO_ONE.ori_div_code is ''来源方财政区划代码''';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_GOAL_INFO_ONE' and column_name = 'ORI_DIV_NAME';
    if i = 0 then
       execute immediate 'alter table PM_PERF_GOAL_INFO_ONE add ori_div_name varchar2(360)';
       execute immediate 'comment on column PM_PERF_GOAL_INFO_ONE.ori_div_name is ''来源方财政区划名称''';
    end if;
	
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_GOAL_INFO_ONE' and column_name = 'FIN_PERF_CODE';
    if i = 0 then
       execute immediate 'alter table PM_PERF_GOAL_INFO_ONE add FIN_PERF_CODE varchar2(4)';
       execute immediate 'comment on column PM_PERF_GOAL_INFO_ONE.FIN_PERF_CODE is ''财政绩效目标审核结果代码''';
    end if;
  
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_GOAL_INFO_ONE' and column_name = 'FIN_PERF_NAME';
    if i = 0 then
       execute immediate 'alter table PM_PERF_GOAL_INFO_ONE add FIN_PERF_NAME varchar2(100)';
       execute immediate 'comment on column PM_PERF_GOAL_INFO_ONE.FIN_PERF_NAME is ''财政绩效目标审核结果''';
    end if;
  
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_GOAL_INFO' and column_name = 'IS_LAST_INST';
    if i = 0 then 
       execute immediate 'alter table PM_PERF_GOAL_INFO_ONE add IS_LAST_INST number(1)';
       execute immediate 'comment on column PM_PERF_GOAL_INFO_ONE.IS_LAST_INST is ''是否终审''';
    end if;
    
  end if;
  
  
  --项目指标备份表
  select count(1) into i from user_tables where table_name = 'PM_PERF_INDICATOR_ONE';
  if i = 1 then

    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_ONE' and column_name = 'KPI_LV1';
    if i = 1 then
       execute immediate 'alter table PM_PERF_INDICATOR_ONE rename column kpi_lv1 to LV1_PERF_IND_CODE';
       --execute immediate 'alter table PM_PERF_INDICATOR_ONE modify lv1_perf_ind_code VARCHAR2(20)';
	 execute immediate 'select fn_altertablecol(''PM_PERF_INDICATOR_ONE'', ''lv1_perf_ind_code'', ''VARCHAR2'', 20)';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_ONE' and column_name = 'KPI_LV2';
    if i = 1 then
       execute immediate 'alter table PM_PERF_INDICATOR_ONE rename column kpi_lv2 to LV2_PERF_IND_CODE';
       --execute immediate 'alter table PM_PERF_INDICATOR_ONE modify lv2_perf_ind_code VARCHAR2(20)';
	 execute immediate 'select fn_altertablecol(''PM_PERF_INDICATOR_ONE'', ''LV2_PERF_IND_CODE'', ''VARCHAR2'', 20)';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_ONE' and column_name = 'KPI_LV3';
    if i = 1 then
       execute immediate 'alter table PM_PERF_INDICATOR_ONE rename column kpi_lv3 to LV3_PERF_IND_CODE';
       --execute immediate 'alter table PM_PERF_INDICATOR_ONE modify lv3_perf_ind_code VARCHAR2(20)';
	 execute immediate 'select fn_altertablecol(''PM_PERF_INDICATOR_ONE'', ''LV3_PERF_IND_CODE'', ''VARCHAR2'', 20)';

    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_ONE' and column_name = 'SUB_MOF_CODE';
    if i = 1 then
       execute immediate 'alter table PM_PERF_INDICATOR_ONE rename column sub_mof_code to SUB_MOF_DIV_CODE';
    end if;

    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_ONE' and column_name = 'MOF_DIV_NAME';
    if i = 0 then
       execute immediate 'alter table PM_PERF_INDICATOR_ONE add mof_div_name VARCHAR2(360)';
       execute immediate 'comment on column PM_PERF_INDICATOR_ONE.mof_div_name is ''财政区划名称''';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_ONE' and column_name = 'AGENCY_NAME';
    if i = 0 then
       execute immediate 'alter table PM_PERF_INDICATOR_ONE add agency_name VARCHAR2(300)';
       execute immediate 'comment on column PM_PERF_INDICATOR_ONE.agency_name is ''单位名称''';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_ONE' and column_name = 'PRO_NAME';
    if i = 0 then
       execute immediate 'alter table PM_PERF_INDICATOR_ONE add pro_name VARCHAR2(180)';
       execute immediate 'comment on column PM_PERF_INDICATOR_ONE.pro_name is ''项目名称''';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_ONE' and column_name = 'LV1_PERF_IND_NAME';
    if i = 0 then
       execute immediate 'alter table PM_PERF_INDICATOR_ONE add lv1_perf_ind_name varchar2(1000)';
       execute immediate 'comment on column PM_PERF_INDICATOR_ONE.lv1_perf_ind_name is ''一级绩效指标名称''';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_ONE' and column_name = 'LV2_PERF_IND_NAME';
    if i = 0 then
       execute immediate 'alter table PM_PERF_INDICATOR_ONE add lv2_perf_ind_name varchar2(1000)';
       execute immediate 'comment on column PM_PERF_INDICATOR_ONE.lv2_perf_ind_name is ''二级绩效指标名称''';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_ONE' and column_name = 'LV3_PERF_IND_NAME';
    if i = 0 then
       execute immediate 'alter table PM_PERF_INDICATOR_ONE add lv3_perf_ind_name varchar2(1000)';
       execute immediate 'comment on column PM_PERF_INDICATOR_ONE.lv3_perf_ind_name is ''三级绩效指标名称''';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_ONE' and column_name = 'SUB_MOF_DIV_NAME';
    if i = 0 then
       execute immediate 'alter table PM_PERF_INDICATOR_ONE add sub_mof_div_name VARCHAR2(360)';
       execute immediate 'comment on column PM_PERF_INDICATOR_ONE.sub_mof_div_name is ''下级财政区划名称''';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_ONE' and column_name = 'PERF_OBJ_TYPE_CODE';
    if i = 0 then
       execute immediate 'alter table PM_PERF_INDICATOR_ONE add perf_obj_type_code VARCHAR2(1)';
       execute immediate 'comment on column PM_PERF_INDICATOR_ONE.perf_obj_type_code is ''绩效目标类型代码''';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_ONE' and column_name = 'PERF_OBJ_TYPE_NAME';
    if i = 0 then
       execute immediate 'alter table PM_PERF_INDICATOR_ONE add perf_obj_type_name VARCHAR2(60)';
       execute immediate 'comment on column PM_PERF_INDICATOR_ONE.perf_obj_type_name is ''绩效目标类型名称''';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_ONE' and column_name = 'SPE_PRO_CODE';
    if i = 0 then
       execute immediate 'alter table PM_PERF_INDICATOR_ONE add spe_pro_code VARCHAR2(21)';
       execute immediate 'comment on column PM_PERF_INDICATOR_ONE.spe_pro_code is ''具体项目代码''';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_ONE' and column_name = 'SPE_PRO_NAME';
    if i = 0 then
       execute immediate 'alter table PM_PERF_INDICATOR_ONE add spe_pro_name VARCHAR2(180)';
       execute immediate 'comment on column PM_PERF_INDICATOR_ONE.spe_pro_name is ''具体项目名称''';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_ONE' and column_name = 'MOF_AUD_OPINION_CODE';
    if i = 0 then
       execute immediate 'alter table PM_PERF_INDICATOR_ONE add mof_aud_opinion_code VARCHAR2(1)';
       execute immediate 'comment on column PM_PERF_INDICATOR_ONE.mof_aud_opinion_code is ''财政审核意见代码''';
    end if;
	
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_ONE' and column_name = 'MOF_AUD_OPINION_NAME';
    if i = 0 then
       execute immediate 'alter table PM_PERF_INDICATOR_ONE add MOF_AUD_OPINION_NAME VARCHAR2(60)';
       execute immediate 'comment on column PM_PERF_INDICATOR_ONE.MOF_AUD_OPINION_NAME is ''财政审核意见名称''';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_ONE' and column_name = 'BGT_ID';
    if i = 0 then
       execute immediate 'alter table PM_PERF_INDICATOR_ONE add bgt_id VARCHAR2(38)';
       execute immediate 'comment on column PM_PERF_INDICATOR_ONE.bgt_id is ''指标主键''';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_ONE' and column_name = 'ORI_DIV_CODE';
    if i = 0 then
       execute immediate 'alter table PM_PERF_INDICATOR_ONE add ori_div_code VARCHAR2(9)';
       execute immediate 'comment on column PM_PERF_INDICATOR_ONE.ori_div_code is ''来源方财政区划代码''';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_ONE' and column_name = 'ORI_DIV_NAME';
    if i = 0 then
       execute immediate 'alter table PM_PERF_INDICATOR_ONE add ori_div_name VARCHAR2(360)';
       execute immediate 'comment on column PM_PERF_INDICATOR_ONE.ori_div_name is ''来源方财政区划名称''';
    end if;
	
    select count(1) into i from user_tab_columns where table_name = 'PM_PERF_INDICATOR_ONE' and column_name = 'IS_LAST_INST';
    if i = 0 then 
       execute immediate 'alter table PM_PERF_INDICATOR_ONE add IS_LAST_INST number(1)';
       execute immediate 'comment on column PM_PERF_INDICATOR_ONE.IS_LAST_INST is ''是否终审''';
    end if;
  end if;
  
  
  --部门整体目标备份表
  select count(1) into i from user_tables where table_name = 'BGT_PERF_GOAL_INFO_ONE';
  if i = 1 then
    select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_GOAL_INFO_ONE' and column_name = 'MOF_DIV_NAME';
    if i = 0 then
       execute immediate 'alter table BGT_PERF_GOAL_INFO_ONE add mof_div_name varchar2(360)';
       execute immediate 'comment on column BGT_PERF_GOAL_INFO_ONE.mof_div_name is ''财政区划名称''';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_GOAL_INFO_ONE' and column_name = 'DEPT_NAME';
    if i = 0 then
       execute immediate 'alter table BGT_PERF_GOAL_INFO_ONE add DEPT_NAME varchar2(360)';
       execute immediate 'comment on column BGT_PERF_GOAL_INFO_ONE.DEPT_NAME is ''部门名称''';
    end if;
	
	select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_GOAL_INFO_ONE' and column_name = 'IS_LAST_INST';
    if i = 0 then 
       execute immediate 'alter table BGT_PERF_GOAL_INFO_ONE add IS_LAST_INST number(1)';
       execute immediate 'comment on column BGT_PERF_GOAL_INFO_ONE.IS_LAST_INST is ''是否终审''';
    end if;
  end if;
  
  --部门整体指标备份表
  select count(1) into i from user_tables where table_name = 'BGT_PERF_INDICATOR_ONE';
  if i = 1 then
    select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_INDICATOR_ONE' and column_name = 'KPI_LV1';
    if i = 1 then
       execute immediate 'alter table BGT_PERF_INDICATOR_ONE rename column kpi_lv1 to LV1_PERF_IND_CODE';
       --execute immediate 'alter table BGT_PERF_INDICATOR_ONE modify lv1_perf_ind_code VARCHAR2(20)';
		execute immediate 'select fn_altertablecol(''BGT_PERF_INDICATOR_ONE'', ''lv1_perf_ind_code'', ''VARCHAR2'', 20)';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_INDICATOR_ONE' and column_name = 'KPI_LV2';
    if i = 1 then
       execute immediate 'alter table BGT_PERF_INDICATOR_ONE rename column kpi_lv2 to LV2_PERF_IND_CODE';
       --execute immediate 'alter table BGT_PERF_INDICATOR_ONE modify lv2_perf_ind_code VARCHAR2(20)';
		execute immediate 'select fn_altertablecol(''BGT_PERF_INDICATOR_ONE'', ''lv2_perf_ind_code'', ''VARCHAR2'', 20)';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_INDICATOR_ONE' and column_name = 'KPI_LV3';
    if i = 1 then
       execute immediate 'alter table BGT_PERF_INDICATOR_ONE rename column kpi_lv3 to LV3_PERF_IND_CODE';
       --execute immediate 'alter table BGT_PERF_INDICATOR_ONE modify lv3_perf_ind_code VARCHAR2(20)';
		execute immediate 'select fn_altertablecol(''BGT_PERF_INDICATOR_ONE'', ''lv3_perf_ind_code'', ''VARCHAR2'', 20)';
    end if;

    select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_INDICATOR_ONE' and column_name = 'MOF_DIV_NAME';
    if i = 0 then
       execute immediate 'alter table BGT_PERF_INDICATOR_ONE add mof_div_name VARCHAR2(360)';
       execute immediate 'comment on column BGT_PERF_INDICATOR_ONE.mof_div_name is ''财政区划名称''';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_INDICATOR_ONE' and column_name = 'DEPT_NAME';
    if i = 0 then
       execute immediate 'alter table BGT_PERF_INDICATOR_ONE add DEPT_NAME VARCHAR2(300)';
       execute immediate 'comment on column BGT_PERF_INDICATOR_ONE.DEPT_NAME is ''部门名称''';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_INDICATOR_ONE' and column_name = 'LV1_PERF_IND_NAME';
    if i = 0 then
       execute immediate 'alter table BGT_PERF_INDICATOR_ONE add lv1_perf_ind_name varchar2(1000)';
       execute immediate 'comment on column BGT_PERF_INDICATOR_ONE.lv1_perf_ind_name is ''一级绩效指标名称''';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_INDICATOR_ONE' and column_name = 'LV2_PERF_IND_NAME';
    if i = 0 then
       execute immediate 'alter table BGT_PERF_INDICATOR_ONE add lv2_perf_ind_name varchar2(1000)';
       execute immediate 'comment on column BGT_PERF_INDICATOR_ONE.lv2_perf_ind_name is ''二级绩效指标名称''';
    end if;
    
    select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_INDICATOR_ONE' and column_name = 'LV3_PERF_IND_NAME';
    if i = 0 then
       execute immediate 'alter table BGT_PERF_INDICATOR_ONE add lv3_perf_ind_name varchar2(1000)';
       execute immediate 'comment on column BGT_PERF_INDICATOR_ONE.lv3_perf_ind_name is ''三级绩效指标名称''';
    end if;
	
	select count(1) into i from user_tab_columns where table_name = 'BGT_PERF_INDICATOR_ONE' and column_name = 'IS_LAST_INST';
    if i = 0 then 
       execute immediate 'alter table BGT_PERF_INDICATOR_ONE add IS_LAST_INST number(1)';
       execute immediate 'comment on column BGT_PERF_INDICATOR_ONE.IS_LAST_INST is ''是否终审''';
    end if;
  end if;
