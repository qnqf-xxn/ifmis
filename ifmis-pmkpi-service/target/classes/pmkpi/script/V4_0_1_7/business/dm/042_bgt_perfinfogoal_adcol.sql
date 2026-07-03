num number(9);
begin 
  select count(1) into num from user_tab_cols where table_name = upper('BGT_PERF_GOAL_INFO') and column_name = upper('remark');
  if num = 0 then
     execute immediate 'alter table BGT_PERF_GOAL_INFO add remark VARCHAR2(2000)';
     execute immediate 'create or replace view V_BGT_PERF_GOAL_INFO as select * from BGT_PERF_GOAL_INFO t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
     and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted<>1';
     execute immediate 'insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
     values (null, null, null, ''1'', ''REMARK'', ''1'', ''2016'', ''87'', ''AC49724ECC224DAF97EBDB7794A929C4'', ''REMARK'', ''BGT_PERF_GOAL_INFO'', ''’„Ω≠∏≈ ˆ'', ''S'', ''2000'', null, 1, 1, null, '''||sysdate||''')';
  end if;