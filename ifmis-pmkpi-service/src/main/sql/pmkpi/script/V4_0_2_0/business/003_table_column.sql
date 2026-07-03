i number;
begin
  -- 案例库目标模板表
  -- KPITARGET长度 4000 改为 2000
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_CASEMODELGOAL' and t.column_name='KPITARGET';
     if i=1 then
       execute immediate 'alter table PERF_T_CASEMODELGOAL modify KPITARGET VARCHAR2(2000)';
     end if;
   
  -- 案例库指标模板表
  -- INDEXVALUE  指标值长度 500 改为 1000
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_CASEMODELINDEX' and t.column_name='INDEXVALUE';
     if i=1 then
       execute immediate 'alter table PERF_T_CASEMODELINDEX modify INDEXVALUE VARCHAR2(1000)';
     end if;
  -- INDEXREMARK  指标值说明(备注) 长度  1000 改为 2000
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_CASEMODELINDEX' and t.column_name='INDEXREMARK';
     if i=1 then
       execute immediate 'alter table PERF_T_CASEMODELINDEX modify INDEXREMARK VARCHAR2(2000)';
     end if; 
  -- FINDEX、SINDEX、TINDEX  一级、二级、三级指标长度 40 改为 300
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_CASEMODELINDEX' and t.column_name='FINDEX';
     if i=1 then
       execute immediate 'alter table PERF_T_CASEMODELINDEX modify FINDEX VARCHAR2(300)';
     end if;
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_CASEMODELINDEX' and t.column_name='SINDEX';
     if i=1 then
       execute immediate 'alter table PERF_T_CASEMODELINDEX modify SINDEX VARCHAR2(300)';
     end if; 
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_CASEMODELINDEX' and t.column_name='TINDEX';
     if i=1 then
       execute immediate 'alter table PERF_T_CASEMODELINDEX modify TINDEX VARCHAR2(300)';
     end if; 
     
  -- PERF_T_PROINDEXTRACE 
  -- agency_code 长度 40 改为 21 
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_PROINDEXTRACE' and t.column_name='AGENCY_CODE';
     if i=1 then
       execute immediate 'alter table PERF_T_PROINDEXTRACE modify AGENCY_CODE VARCHAR2(21)';
     end if; 
  -- REMARK  长度 4000 改为 2000
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_PROINDEXTRACE' and t.column_name='REMARK';
     if i=1 then
       execute immediate 'alter table PERF_T_PROINDEXTRACE modify REMARK VARCHAR2(2000)';
     end if; 
  -- INDEXVAL  指标值 60 改为 1000
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_PROINDEXTRACE' and t.column_name='INDEXVAL';
     if i=1 then
       execute immediate 'alter table PERF_T_PROINDEXTRACE modify INDEXVAL VARCHAR2(1000)';
     end if;
  -- FINDEX、SINDEX、TINDEX  一级、二级、三级指标长度 40 改为 300
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_PROINDEXTRACE' and t.column_name='FINDEX';
     if i=1 then
       execute immediate 'alter table PERF_T_PROINDEXTRACE modify FINDEX VARCHAR2(300)';
     end if;
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_PROINDEXTRACE' and t.column_name='SINDEX';
     if i=1 then
       execute immediate 'alter table PERF_T_PROINDEXTRACE modify SINDEX VARCHAR2(300)';
     end if; 
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_PROINDEXTRACE' and t.column_name='TINDEX';
     if i=1 then
       execute immediate 'alter table PERF_T_PROINDEXTRACE modify TINDEX VARCHAR2(300)';
     end if;
     
  --PERF_T_SELFPERFINDEX;
  -- PRO_CODE 项目编码长度 40 改为 21
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_SELFPERFINDEX' and t.column_name='PRO_CODE';
     if i=1 then
       execute immediate 'alter table PERF_T_SELFPERFINDEX modify PRO_CODE VARCHAR2(21)';
     end if;
  -- FINDEX、SINDEX、TINDEX  一级、二级、三级指标长度 40 改为 300
   select count(1) into i from user_tab_cols t where t.table_name='PERF_T_SELFPERFINDEX' and t.column_name='FINDEX';
     if i=1 then
       execute immediate 'alter table PERF_T_SELFPERFINDEX modify FINDEX VARCHAR2(300)';
     end if;
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_SELFPERFINDEX' and t.column_name='SINDEX';
     if i=1 then
       execute immediate 'alter table PERF_T_SELFPERFINDEX modify SINDEX VARCHAR2(300)';
     end if; 
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_SELFPERFINDEX' and t.column_name='TINDEX';
     if i=1 then
       execute immediate 'alter table PERF_T_SELFPERFINDEX modify TINDEX VARCHAR2(300)';
     end if;
