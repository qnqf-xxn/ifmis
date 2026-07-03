
i number(9);
begin 
  
  select count(1) into i from user_tab_cols where table_name = upper('PERF_T_AUDITMAIN') and column_name = upper('REMARK');
if i = 1 then
     execute immediate 'alter table PERF_T_AUDITMAIN modify remark VARCHAR2(4000)';
  end if;
  
    UPDATE BUS_T_DICCOLUMN T SET T.Datalength=4000 WHERE T.TABLECODE='PERF_T_AUDITMAIN' AND T.COLUMNCODE='REMARK';

  
