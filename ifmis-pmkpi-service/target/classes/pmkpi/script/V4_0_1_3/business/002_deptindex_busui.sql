begin

delete from busfw_t_uifunction t where key in('/pmkpi/indexlib/deptlist') and t.code ='deptimport';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C42CC77073BCB27FE053B11FA8C0B7A0', '/pmkpi/indexlib/deptlist', '部门指标导入', 1, 5, 'searchicon', 'indexlib.import', null, '部门指标导入', 'pmkpi', 'deptimport', null, '{}');
