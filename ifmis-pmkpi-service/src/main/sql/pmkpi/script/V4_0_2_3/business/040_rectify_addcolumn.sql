--问题整改主表添加 ISADD 字段，判断发起整改的项目是否是财政评价新增的项目
  i number;
begin
   select count(*) into i from user_tab_cols t where t.TABLE_NAME ='PERF_T_RECTIFY' and t.COLUMN_NAME ='ISADD';
    if i = 0 then
      execute immediate 'alter table PERF_T_RECTIFY add ISADD NUMBER(1)';
    end if;
    select count(*) into i from bus_t_diccolumn t where t.tablecode ='PERF_T_RECTIFY' and t.columncode ='ISADD';
    if i = 0 then
      execute immediate '
        insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
        values (null, ''ISLEAF'', null, ''0'', ''ISADD'', ''1'', null, null, ''0065EF0C551491BD3B5E66B7022DBBAD'', ''ISADD'', ''PERF_T_RECTIFY'', null, ''S'', ''40'', null, null, 1, null, sysdate)';
      end if;

 execute immediate '
     create or replace view v_perf_t_rectify as
      select *
       from perf_t_rectify t
          where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and
          PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') ';
