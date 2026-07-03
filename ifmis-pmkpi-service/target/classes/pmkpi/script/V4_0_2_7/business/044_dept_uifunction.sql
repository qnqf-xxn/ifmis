begin
  --部门申报查询页面湖北导出按钮    
delete from p#busfw_t_uifunction where key ='/pmkpi/deptperformance/query/index' and code ='expxlshb';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('E1781223AC576506E0533315A8C0B909', '/pmkpi/deptperformance/query/index', '导出报表(湖北)', 0, 5, 'searchicon', 'Ext.lt.pmkpi.expdoc', null, '导出报表(湖北)', 'pmkpi', 'expxlshb', null, '{tempatecode:''hubeibmjxmbsbb''}');
