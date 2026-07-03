i integer;
begin
  delete FROM Busfw_t_Uitable t where t.key = '/pmkpi/adjust/report/deptamt';
  insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
  values ('E44BDA2E5C9C7072E0533315A8C039CE', '/pmkpi/adjust/report/deptamt', 'V_PERF_T_ADJDEPTAMT', 0, 0, 0, 'order by ordernum', null, 'pmkpi', null, '87', '2016');

  delete FROM Busfw_t_Uicolumn t where t.key = '/pmkpi/adjust/report/deptamt';
  insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
  values ('E44BDA2E5C9L7072E0533315A8C039CE', '/pmkpi/adjust/report/deptamt', 'GUID', 'guid', 1, 0, 0, 0, null, 0, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

  insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
  values ('E44BDA2E5C9K7072E0533315A8C039CE', '/pmkpi/adjust/report/deptamt', 'TYPENAME', '资金分类', 2, 1, 0, 0, null, 0, 1, '[''总体资金情况'']', null, null, null, null, 0, 's', '{}', null, '87', '2016');

  insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
  values ('E44BDA2E5C9G7072E0533315A8C039CE', '/pmkpi/adjust/report/deptamt', 'FUNDNAME', '资金性质', 3, 1, 0, 0, null, 0, 1, '[''总体资金情况'']', null, null, null, null, 0, 's', '{}', null, '87', '2016');

  insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
  values ('E44BDA2E5C9F7072E0533315A8C039CE', '/pmkpi/adjust/report/deptamt', 'YEARAMT', '当年金额', 4, 1, 1, 0, null, 1, 1, null, null, null, null, 200, 0, 'amt', '{}', null, '87', '2016');

  insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
  values ('E44BDA2E5C9E7072E0533315A8C039CE', '/pmkpi/adjust/report/deptamt', 'RATE', '占比', 5, 1, 0, 0, null, 1, 1, null, null, null, null, 200, 0, 's', '{width:100}', null, '87', '2016');

  insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
  values ('E44BDA2E5C9D7072E0533315A8C039CE', '/pmkpi/adjust/report/deptamt', 'FAMT', '上年金额', 6, 1, 1, 0, null, 1, 1, '[''近两年收支金额'']', null, null, null, 200, 0, 'amt', '{}', null, '87', '2016');

  insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
  values ('E44BDA2E5C9M7072E0533315A8C039CE', '/pmkpi/adjust/report/deptamt', 'SAMT', '前年金额', 7, 1, 1, 0, null, 1, 1, '[''近两年收支金额'']', null, null, null, 200, 0, 'amt', '{}', null, '87', '2016');
