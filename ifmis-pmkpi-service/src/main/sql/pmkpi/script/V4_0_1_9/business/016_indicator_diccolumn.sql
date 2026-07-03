begin

--indicator_diccolumn-项目储备草稿保存会丢掉之前保存的草稿
delete from Bus_t_Diccolumn where TABLECODE = 'PM_PERF_INDICATOR' and COLUMNCODE = 'IS_DELETED';
insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'IS_DELETED', '1', '2016', '87', '60665A55B428436091A3F514BE6243BB', 'IS_DELETED', 'PM_PERF_INDICATOR', '是否删除', 'S', '32', null, 1, 0, null, sysdate);
