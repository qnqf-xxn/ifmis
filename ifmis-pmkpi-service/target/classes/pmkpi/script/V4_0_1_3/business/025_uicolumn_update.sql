begin
UPDATE Busfw_t_Uicolumn SET NAME = '专家姓名' WHERE  KEY = '/pmkpi/setting/baseinfo/expertinifo' AND COLUMNCODE = 'NAME';
UPDATE Busfw_t_Uicolumn SET NAME = '联系方式' WHERE  KEY = '/pmkpi/setting/baseinfo/expertinifo' AND COLUMNCODE = 'PHONE';
UPDATE Bus_t_Pageconsolecomconfig SET CONFIG = '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}' WHERE URL = '/pmkpi/setting/baseinfo/intermediaryinfo' AND COMPONENTID = 'busqueryform';
