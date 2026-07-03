begin

--绩效监控查询-广西导出 按钮注册
delete from p#busfw_t_uifunction where key ='/pmkpi/program/trace/query' and name in('项目监控导出(广西)','部门监控导出(广西)') ;
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/program/trace/query', '项目监控导出(广西)', 0, 1, 'searchicon', 'Ext.lt.pmkpi.expdoc', null, '项目监控导出(广西)', 'pmkpi', 'expdoc', null, '{tempatecode:''gxxmzcjkdc''}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/program/trace/query', '部门监控导出(广西)', 0, 2, 'searchicon', 'Ext.lt.pmkpi.expdoc', null, '部门监控导出(广西)', 'pmkpi', 'expdoc', null, '{tempatecode:''gxbmztjkdc''}');
