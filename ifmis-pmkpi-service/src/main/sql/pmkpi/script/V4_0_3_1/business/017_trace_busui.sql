begin

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/program/trace/report') and t.code in('ahybexpdoc','ahybimpdoc');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/program/trace/report', '一般监控模板导出（安徽）', 0, 24, 'searchicon', 'protaskreport.expdoc', null, '一般监控模板导出（安徽）', 'pmkpi', 'ahybexpdoc', null, '{protempatecode:''ahxmjxjkbg'',depttempatecode:''ahbmztjxjkbg'',proexptype:''ahprogram'',deptexptype:''ahdept''}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/program/trace/report', '一般监控导入（安徽）', 0, 25, 'searchicon', 'protaskreport.impdoc', null, '一般监控导入（安徽）', 'pmkpi', 'ahybimpdoc', null, '{impServicetype:''impreport'',protempatecode:''ahxmjxjkbg'',depttempatecode:''ahbmztjxjkbg'',impreporttype:''ah''}');

update p#busfw_t_uifunction t set t.ordernum=14, t.name='一般监控模板导出（合肥）',t.title='一般监控模板导出（合肥）' where t.key in('/pmkpi/program/trace/report') and t.code='ordexpdoc';
update p#busfw_t_uifunction t set t.ordernum=15, t.name='一般监控导入（合肥）',t.title='一般监控导入（合肥）' where t.key in('/pmkpi/program/trace/report') and t.code='ordimpdoc';
update p#busfw_t_uifunction t set t.ordernum=16, t.name='重点监控模板导出（合肥）',t.title='重点监控模板导出（合肥）' where t.key in('/pmkpi/program/trace/report') and t.code='hfexpdoc';
update p#busfw_t_uifunction t set t.ordernum=17, t.name='重点监控导入（合肥）',t.title='重点监控导入（合肥）' where t.key in('/pmkpi/program/trace/report') and t.code='hfimpdoc';

update p#busfw_t_uifunction t set t.ordernum=26, t.name='重点监控模板导出（安徽）',t.title='重点监控模板导出（安徽）' where t.key in('/pmkpi/program/trace/report') and t.code='ahexpdoc';
update p#busfw_t_uifunction t set t.ordernum=27, t.name='重点监控导入（安徽）',t.title='重点监控导入（安徽）' where t.key in('/pmkpi/program/trace/report') and t.code='ahimpdoc';

update p#busfw_t_uitabpage t set t.hidebtns='填报/修改,删除,送审,一般监控模板导出（合肥）,一般监控导入（合肥）,重点监控模板导出（安徽）,重点监控导入（安徽）,重点监控模板导出（合肥）,重点监控导入（合肥）,一般监控模板导出（安徽）,一般监控导入（安徽）' where t.key in('/pmkpi/program/trace/report') and t.code='alreadyaudit';
update p#busfw_t_uitabpage t set t.hidebtns='取消送审,一般监控模板导出（合肥）,一般监控导入（合肥）,重点监控模板导出（安徽）,重点监控导入（安徽）,重点监控模板导出（合肥）,重点监控导入（合肥）,一般监控模板导出（安徽）,一般监控导入（安徽）' where t.key in('/pmkpi/program/trace/report') and t.code='back';
update p#busfw_t_uitabpage t set t.hidebtns='填报/修改,删除,送审,取消送审,一般监控模板导出（合肥）,重点监控模板导出（安徽）,重点监控模板导出（合肥）,一般监控模板导出（安徽）' where t.key in('/pmkpi/program/trace/report') and t.code='alldeals';

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/program/trace/query') and t.code in('ahybexpdoc');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/program/trace/query', '一般监控导出（安徽）', 0, 21, 'searchicon', 'protracequery.expdoc', null, '一般监控导出（安徽）', 'pmkpi', 'ahybexpdoc', null, '{protempatecode:''ahxmjxjkbg'',depttempatecode:''ahbmztjxjkbg'',proexptype:''ahprogram'',deptexptype:''ahdept''}');

update p#busfw_t_uifunction t set t.ordernum=19, t.name='一般监控导出（合肥）',t.title='一般监控导出（合肥）' where t.key in('/pmkpi/program/trace/query') and t.code='ordexpdoc';
update p#busfw_t_uifunction t set t.ordernum=20, t.name='重点监控导出（合肥）',t.title='重点监控导出（合肥）' where t.key in('/pmkpi/program/trace/query') and t.code='hfexpdoc';
update p#busfw_t_uifunction t set t.ordernum=22, t.name='重点监控导出（安徽）',t.title='重点监控导出（安徽）' where t.key in('/pmkpi/program/trace/query') and t.code='ahexpdoc';