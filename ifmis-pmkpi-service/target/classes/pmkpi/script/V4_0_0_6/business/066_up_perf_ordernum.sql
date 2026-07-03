i integer;
begin
update perf_enum t set t.creater = t.ordernum;
update perf_enum t set t.ordernum = '';
select count(1) into i from user_tab_cols t where t.table_name='PERF_ENUM' and t.column_name='ORDERNUM';
     if i=0 then
       execute immediate 'alter table PERF_ENUM modify ordernum NUMBER(9)';
     end if;
update perf_enum t set t.ordernum=t.creater;

update p#Busfw_t_Uicolumn t set t.columncode = 'METERUNIT' where t.columncode = 'TARGETUNIT' and t.key like '/pmkpi%';