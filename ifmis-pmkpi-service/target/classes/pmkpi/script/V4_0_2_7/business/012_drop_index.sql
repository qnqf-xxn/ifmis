  i number;
begin
    --删除 自定义视图表 多余的索引
   select count(*) into i from user_ind_columns where table_name='PERF_T_CUSTOMAUDITVIEW' and index_name ='PERF_T_CUSTOMAUDITVIEW';
     if i=1 then
       execute immediate 'drop index PERF_T_CUSTOMAUDITVIEW';
     end if;