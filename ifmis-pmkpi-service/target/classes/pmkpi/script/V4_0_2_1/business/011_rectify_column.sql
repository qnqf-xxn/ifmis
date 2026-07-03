i number;
begin
   --整改主表添加阶段字段
  --任务阶段
  select count(*) INTO i from user_tab_columns where table_name ='PERF_T_RECTIFY' and column_name = 'TASKSTAGE';
  if i = 0 then
     execute immediate 'alter table PERF_T_RECTIFY add TASKSTAGE VARCHAR2(32)';
  end if;
  --整改类型
  select count(*) INTO i from user_tab_columns where table_name ='PERF_T_RECTIFY' and column_name = 'RECTYPE';
  if i = 0 then
    execute immediate 'alter table PERF_T_RECTIFY add RECTYPE VARCHAR2(32)';
  end if;
  --任务名称
  select count(*) INTO i from user_tab_columns where table_name ='PERF_T_RECTIFY' and column_name = 'TASKNAME';
  if i = 0 then
    execute immediate 'alter table PERF_T_RECTIFY add TASKNAME VARCHAR2(32)';
  end if;
  --是否发起整改
  select count(*) INTO i from user_tab_columns where table_name ='PERF_T_RECTIFY' and column_name = 'ISRECTIFY';
  if i = 0 then
     execute immediate 'alter table PERF_T_RECTIFY add ISRECTIFY NUMBER(1)';
  end if;
  --是否完成整改
   select count(*) INTO i from user_tab_columns where table_name ='PERF_T_RECTIFY' and column_name = 'RECTIFYEND';
  if i = 0 then
     execute immediate 'alter table PERF_T_RECTIFY add RECTIFYEND NUMBER(1)';
  end if;
  --监控任务guid
   select count(*) INTO i from user_tab_columns where table_name ='PERF_T_RECTIFY' and column_name = 'TASKGUID';
  if i = 0 then
     execute immediate 'alter table PERF_T_RECTIFY add TASKGUID VARCHAR2(40)';
  end if;
  
  --重构视图
  execute immediate'create or replace view v_perf_t_rectify as
    select *
    from perf_t_rectify t
    where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and
    PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
    
  --创建视图
  execute immediate'
  create or replace view perf_v_rectify as
select t.PRO_CODE,t.PROGUID,t.TASKNAME,max(ISRECTIFY) as ISRECTIFY, max(RECTIFYEND) as RECTIFYEND
    from  v_perf_t_rectify t group by proguid,pro_code,taskname';