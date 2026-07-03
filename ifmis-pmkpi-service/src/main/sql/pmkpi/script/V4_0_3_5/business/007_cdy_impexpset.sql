begin

delete from bus_t_diccolumn t where t.tablecode='PERF_T_IMPEXPSUB' and t.columncode in('COLUMNCODE','MAINGUID');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'COLUMNCODE', '1', '2016', '87', 'C450B6D0DD740554E053B11FA8C044F7', 'COLUMNCODE', 'PERF_T_IMPEXPSUB', null, 's', '50', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'MAINGUID', '1', '2016', '87', 'C450B6D0DD7B0554E053B11FA8C044F7', 'MAINGUID', 'PERF_T_IMPEXPSUB', null, 'S', '32', null, 1, 0, null, sysdate);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/setting/impexpsub');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/impexpsub', 'GUID', '主键', 0, 0, 0, 0, null, 1, 1, null, null, null, null, 38, null, 's', null, null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/impexpsub', 'COLUMNCODE', '字段编码', 1, 1, 1, 0, null, 1, 1, null, null, null, null, 100, null, 's', '{}', null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/impexpsub', 'NAME', '名称', 2, 1, 1, 0, null, 1, 1, null, null, null, null, 100, null, 's', null, null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/impexpsub', 'CSID', '数据源', 3, 1, 1, 0, null, 0, 1, null, '#code-#name', null, null, 130, 1, 'tree', '{}', null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/impexpsub', 'ORDERNUM', '排序', 4, 1, 1, 0, null, 1, 1, null, null, null, null, 50, null, 's', null, null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/impexpsub', 'HEAD', '上级表头名称', 5, 1, 1, 0, null, 0, 1, null, null, null, null, 200, null, 's', null, null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/impexpsub', 'FORMAT', '格式', 6, 1, 1, 0, null, 0, 1, null, null, null, null, 50, null, 's', null, null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/impexpsub', 'TYPE', '字段类型', 7, 1, 1, 0, null, 1, 1, null, '#code-#name', null, null, 50, 1, 'tree', '{}', null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/impexpsub', 'MAINGUID', '模板类型', 8, 0, 0, 0, null, 0, 1, null, null, null, null, 32, null, 's', null, null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/impexpsub', 'COLWIDTH', '列宽', 9, 1, 1, 0, null, 0, 1, null, null, null, null, 50, null, 's', null, null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/impexpsub', 'PROVINCE', '区划', 10, 0, 0, 0, null, 0, 1, null, null, null, null, 9, null, 's', null, null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/impexpsub', 'YEAR', '年度', 11, 0, 0, 0, null, 0, 1, null, null, null, null, 4, null, 's', null, null, null, null);

delete from fasp_t_dicdssource t where t.guid='PMKPICSIDS';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPICSIDS', 'PMKPICSIDS', 'PMKPICSIDS', '数据源', '1', '20210901113621631', '20150901', null, '2016', '87', null, null, null, '2', 'select guid,code,name,status from  fasp_t_dicdssource where appid = ''pmkpi''
union
select guid,code,name,status from  fasp_t_dicds', null, 1, 'pmkpi');

delete from perf_t_impexpmain t where t.guid in('program','dept');
insert into perf_t_impexpmain (GUID, CODE, NAME, PROVINCE, YEAR, TABLECODE, BEANID)
values ('dept', 'dept', '绩效目标评审（部门整体）', '87', '2016', 'dual', 'pmkpi.perfreview.PerfReviewBOTX');

insert into perf_t_impexpmain (GUID, CODE, NAME, PROVINCE, YEAR, TABLECODE, BEANID)
values ('program', 'program', '绩效目标评审（项目支出）', '87', '2016', 'dual', 'pmkpi.perfreview.PerfReviewBOTX');