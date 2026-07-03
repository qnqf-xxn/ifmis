
i number;
begin

  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTGOAL' and column_name = 'SUB_MOF_CODE';
  if i = 1 then
     execute immediate 'alter table PERF_T_ADJUSTGOAL rename column sub_mof_code to SUB_MOF_DIV_CODE';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTGOAL' and column_name = 'MOF_DIV_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTGOAL add mof_div_name varchar2(360)';
     execute immediate 'comment on column PERF_T_ADJUSTGOAL.mof_div_name is ''财政区划名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTGOAL' and column_name = 'AGENCY_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTGOAL add agency_name varchar2(300) ';
     execute immediate 'comment on column PERF_T_ADJUSTGOAL.agency_name is ''单位名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTGOAL' and column_name = 'PRO_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTGOAL add pro_name varchar2(180) ';
     execute immediate 'comment on column PERF_T_ADJUSTGOAL.pro_name is ''项目名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTGOAL' and column_name = 'SUB_MOF_DIV_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTGOAL add sub_mof_div_name varchar2(360)';
     execute immediate 'comment on column PERF_T_ADJUSTGOAL.sub_mof_div_name is ''下级财政区划名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTGOAL' and column_name = 'PERF_OBJ_TYPE_CODE';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTGOAL add perf_obj_type_code varchar2(1) ';
     execute immediate 'comment on column PERF_T_ADJUSTGOAL.perf_obj_type_code is ''绩效目标类型代码''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTGOAL' and column_name = 'PERF_OBJ_TYPE_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTGOAL add perf_obj_type_name varchar2(60) ';
     execute immediate 'comment on column PERF_T_ADJUSTGOAL.perf_obj_type_name is ''绩效目标类型名称''';
  end if;

  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTGOAL' and column_name = 'SPE_PRO_CODE';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTGOAL add spe_pro_code varchar2(21)';
     execute immediate 'comment on column PERF_T_ADJUSTGOAL.spe_pro_code is ''具体项目代码''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTGOAL' and column_name = 'SPE_PRO_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTGOAL add spe_pro_name varchar2(180)';
     execute immediate 'comment on column PERF_T_ADJUSTGOAL.spe_pro_name is ''具体项目名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTGOAL' and column_name = 'MOF_AUD_OPINION_CODE';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTGOAL add mof_aud_opinion_code varchar2(1)';
     execute immediate 'comment on column PERF_T_ADJUSTGOAL.mof_aud_opinion_code is ''财政审核意见代码''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTGOAL' and column_name = 'MOF_AUD_OPINION_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTGOAL add MOF_AUD_OPINION_NAME varchar2(60)';
     execute immediate 'comment on column PERF_T_ADJUSTGOAL.MOF_AUD_OPINION_NAME is ''财政审核意见名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTGOAL' and column_name = 'BGT_ID';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTGOAL add bgt_id varchar2(38)';
     execute immediate 'comment on column PERF_T_ADJUSTGOAL.bgt_id is ''指标主键''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTGOAL' and column_name = 'ORI_DIV_CODE';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTGOAL add ori_div_code varchar2(9)';
     execute immediate 'comment on column PERF_T_ADJUSTGOAL.ori_div_code is ''来源方财政区划代码''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTGOAL' and column_name = 'ORI_DIV_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTGOAL add ori_div_name varchar2(360)';
     execute immediate 'comment on column PERF_T_ADJUSTGOAL.ori_div_name is ''来源方财政区划名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTGOAL' and column_name = 'DEPT_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTGOAL add DEPT_NAME varchar2(360)';
     execute immediate 'comment on column PERF_T_ADJUSTGOAL.DEPT_NAME is ''部门名称''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTGOAL' and column_name = 'FIN_PERF_CODE';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTGOAL add FIN_PERF_CODE varchar2(4)';
     execute immediate 'comment on column PERF_T_ADJUSTGOAL.FIN_PERF_CODE is ''财政绩效目标审核结果代码''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTGOAL' and column_name = 'FIN_PERF_NAME';
  if i = 0 then
     execute immediate 'alter table PERF_T_ADJUSTGOAL add FIN_PERF_NAME varchar2(100)';
     execute immediate 'comment on column PERF_T_ADJUSTGOAL.FIN_PERF_NAME is ''财政绩效目标审核结果''';
  end if;
  
  select count(1) into i from user_tab_columns where table_name = 'PERF_T_ADJUSTGOAL' and column_name = 'IS_LAST_INST';
  if i = 0 then 
     execute immediate 'alter table PERF_T_ADJUSTGOAL add IS_LAST_INST number(1)';
     execute immediate 'comment on column PERF_T_ADJUSTGOAL.IS_LAST_INST is ''是否终审''';
  end if;
  
execute immediate '
create or replace view v_perf_t_adjustgoal as
select *
 from perf_t_adjustgoal t
where year = global_multyear_cz.v_pmyear
and province = global_multyear_cz.v_pmdivid and t.is_deleted=2';
  
