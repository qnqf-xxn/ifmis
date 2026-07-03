begin
delete from p#busfw_t_uitable where key = '/pmkpi/prorevision/report/proedit/index';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B9C975E5APECF59EE053B11FA8C05A36', '/pmkpi/prorevision/report/proedit/index', 'V_PERF_PROVISION_INDICATOR', 0, 1, 0, null, ' (yearflag <> 1 or yearflag is null)', 'pmkpi', null);

delete from p#busfw_t_uitable where key = '/pmkpi/prorevision/report/program';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B98F5984660DB918E053B11FA8C0831D', '/pmkpi/prorevision/report/program', 'V_PERF_T_PROVISIONDECLARE', 100, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uitable where key = '/pmkpi/prorevision/report/dept';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B98F5984660DB918E053B11FA8C0831D', '/pmkpi/prorevision/report/dept', 'V_PERF_T_PROVISIONDECLARE', 100, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uitable where key = '/pmkpi/prorevision/power';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('49A79A8302714308B34D4D0AF286B6PP', '/pmkpi/prorevision/power', 'PMKPI_FASP_T_PUBAGENCY', 0, 0, 0, null, null, 'pmkpi', null);


delete from p#busfw_t_uicolumn where key = '/pmkpi/prorevision/power';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BC8DF02C1F1FF3B8E053B11FA8C0DPA2', '/pmkpi/prorevision/power', 'LEVELNO', '层级', 10, 0, 1, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('P9B741DB5783PC5190A9CB5B04E0B3E1', '/pmkpi/prorevision/power', 'SUPERID', '父级guid', 1, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('p974E6D88C5AP61FAA4A55491C66695C', '/pmkpi/prorevision/power', 'UPDATE_TIME', '更新时间', 5, 1, 0, null, null, null, null, null, 'yyyy-MM-dd', null, null, null, 0, 'd', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('PE8906064B404P27B883FA79F2831410', '/pmkpi/prorevision/power', 'CODE', '单位编码', 2, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('P75057AA28CP40BAA58A50F44131D6C1', '/pmkpi/prorevision/power', 'STATUS', '状态', 7, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('P67FAB677FCP4677AAB49A8BC335ED8C', '/pmkpi/prorevision/power', 'FININTORGGUID', '业务处室', 8, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('PB39AF56EB90P813B7663AE629E9580F', '/pmkpi/prorevision/power', 'CREATE_TIME', '填报时间', 4, 1, 0, null, null, null, 1, null, 'yyyy-MM-dd', null, null, null, 0, 'd', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('PAFAA20A5DE4PA068BFDDEAAED65980B', '/pmkpi/prorevision/power', 'NAME', '单位名称', 3, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('P9B741DB5783PC5190A9CB5B04E0B3E8', '/pmkpi/prorevision/power', 'GUID', '单位guid', 1, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);





delete from p#busfw_t_uicolumn where key = '/pmkpi/prorevision/report/dept';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('p9ED1F7009C02EC2E053B11FA8C00E35', '/pmkpi/prorevision/report/dept', 'REVISIONNUM', '调整次数', 1, 1, 0, 0, null, 0, 6, null, null, null, null, 60, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('p9A266E250F2383EE053B11FA8C05B3C', '/pmkpi/prorevision/report/dept', 'GUID', 'guid', 10, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('p9A266E250F3383EE053B11FA8C05B3C', '/pmkpi/prorevision/report/dept', 'CODE', '单位编码', 3, 0, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('p9A266E250F4383EE053B11FA8C05B3C', '/pmkpi/prorevision/report/dept', 'NAME', '单位名称', 4, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('p9A266E250F5383EE053B11FA8C05B3C', '/pmkpi/prorevision/report/dept', 'LINKMAN', '联系人', 5, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('p9A266E250F6383EE053B11FA8C05B3C', '/pmkpi/prorevision/report/dept', 'YEAR', '预算年度', 6, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('pC8673863AE8D5B8E053B11FA8C03A82', '/pmkpi/prorevision/report/dept', 'WFSTATUS', '状态', 2, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null);






delete from p#busfw_t_uicolumn where key = '/pmkpi/prorevision/report/proedit/index';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('prorevision/report/indexcolum008', '/pmkpi/prorevision/report/proedit/index', 'WEIGHT', '权重', 16, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('prorevision/report/indexcolum007', '/pmkpi/prorevision/report/proedit/index', 'LEVELNO', '级次', 12, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('prorevision/report/indexcolum006', '/pmkpi/prorevision/report/proedit/index', 'METERUNIT', '计量单位', 11, 1, 1, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('prorevision/report/indexcolum005', '/pmkpi/prorevision/report/proedit/index', 'INDEXVAL', '指标值', 10, 1, 1, 0, null, 1, 6, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('prorevision/report/indexcolum004', '/pmkpi/prorevision/report/proedit/index', 'COMPUTESIGN', '计算符号', 9, 1, 1, 0, null, 1, 6, null, '#name', null, null, 100, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('prorevision/report/indexcolum003', '/pmkpi/prorevision/report/proedit/index', 'EXPLAIN', '公式或说明', 4, 0, 1, 0, null, 0, 6, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('prorevision/report/indexcolum002', '/pmkpi/prorevision/report/proedit/index', 'NAME', '指标名称', 3, 1, 1, 0, null, 1, 6, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('prorevision/report/indexcolum001', '/pmkpi/prorevision/report/proedit/index', 'OBLIGATE1', '操作', 1, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('prorevision/report/indexcolum012', '/pmkpi/prorevision/report/proedit/index', 'FINDEX', '一级指标', 22, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('prorevision/report/indexcolum013', '/pmkpi/prorevision/report/proedit/index', 'SINDEX', '二级指标', 23, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('prorevision/report/indexcolum014', '/pmkpi/prorevision/report/proedit/index', 'GUID', 'GUID', 25, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('prorevision/report/indexcolum015', '/pmkpi/prorevision/report/proedit/index', 'SUPERID', 'SUPERID', 26, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('prorevision/report/Indexcolum016', '/pmkpi/prorevision/report/proedit/index', 'KPI_CONTENT', '指标内容', 27, 0, 1, 0, null, 1, 6, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('prorevision/report/indexcolum017', '/pmkpi/prorevision/report/proedit/index', 'KPI_EVALSTD', '扣分标准', 28, 0, 1, 0, null, 1, 6, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('prorevision/report/indexcolum099', '/pmkpi/prorevision/report/proedit/index', 'KPI_REMARK', '备注', 29, 1, 1, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);



delete from p#busfw_t_uicolumn where key = '/pmkpi/prorevision/report/program';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B98F5984660FB918E053B11FA8C0831D', '/pmkpi/prorevision/report/program', 'PRO_CODE', '项目编码', 4, 1, 0, 0, null, null, null, null, null, null, null, 150, 1, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('p98F59846612B918E053B11FA8C0831D', '/pmkpi/prorevision/report/program', 'PRO_NAME', '项目名称', 5, 1, 0, 0, null, null, 1, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('p98F5984660EB918E053B11FA8C0831D', '/pmkpi/prorevision/report/program', 'AGENCYGUID', '预算单位', 6, 1, 0, 0, null, null, null, null, '#code-#name', null, null, 200, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('p98F59846615B918E053B11FA8C0831D', '/pmkpi/prorevision/report/program', 'YEAR', '预算年份', 7, 1, 0, 0, null, null, 1, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('p98F59846610B918E053B11FA8C0831D', '/pmkpi/prorevision/report/program', 'CREATETIME', '填报时间', 9, 1, 0, 0, null, null, 1, null, 'yyyy-MM-dd hh:mm:ss', null, null, 100, 0, 'd', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('p98F59846611B918E053B11FA8C0831D', '/pmkpi/prorevision/report/program', 'FININTORGGUID', '业务处室', 13, 1, 0, 0, null, null, null, null, '#name', null, null, 100, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('p98F59846616B918E053B11FA8C0831D', '/pmkpi/prorevision/report/program', 'GUID', '主键', 15, 0, 0, 0, null, null, null, null, null, null, null, null, 1, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('p98F59846614B918E053B11FA8C0831D', '/pmkpi/prorevision/report/program', 'WFSTATUS', '审核状态', 15, 0, 0, 0, null, null, null, null, '#name', null, null, 100, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('p98F59846613B918E053B11FA8C0831D', '/pmkpi/prorevision/report/program', 'WFID', '工作流id', 20, 0, 0, 0, null, null, 1, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('pC8673863AE9D5B8E053B11FA8C03A82', '/pmkpi/prorevision/report/program', 'WFSTATUS', '状态', 2, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9ED1F7009BF2EC2E053B11FA8C00E35', '/pmkpi/prorevision/report/program', 'REVISIONNUM', '修订次数', 1, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);





delete from p#busfw_t_uifunction where key in('/pmkpi/prorevision/power','/pmkpi/prorevision/report','/pmkpi/prorevision/report/proedit','/pmkpi/prorevision/report/procheck','/pmkpi/prorevision/report/proedit/editindex','/pmkpi/prorevision/report/edit/editindex','/pmkpi/prorevision/audit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('P9DD48E616964744E053B11FA8C01BA3', '/pmkpi/prorevision/audit', '审核情况', 1, 3, 'searchicon', 'prorevisionaudit.queryaudit', null, '审核情况', 'pmkpi', 'showwfinfo', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('P9DD48E616994744E053B11FA8C01BA3', '/pmkpi/prorevision/audit', '取消审核', 1, 2, 'searchicon', 'prorevisionaudit.wfAudit', null, '取消审核', 'pmkpi', 'cancelaudit', null, '{"action":"audit_cancel"}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('P9DD48E616974744E053B11FA8C01BA3', '/pmkpi/prorevision/audit', '审核', 1, 1, 'searchicon', 'prorevisionaudit.audit', null, '审核', 'pmkpi', 'audit', null, '{"action":"audit"}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('P9DD48E6169A4744E053B11FA8C01BA3', '/pmkpi/prorevision/audit', '查看明细', 1, 4, 'searchicon', 'prorevisionaudit.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('9B1AA405F8894B12B69D5D328AEF1C67', '/pmkpi/prorevision/power', '授权', 1, 2, 'Keepicon', 'revisionpower.power', null, '授权', 'pmkpi', 'power', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('18417BF749F04EC38FFA93EF7310C2DF', '/pmkpi/prorevision/power', '取消授权', 1, 1, 'Nofinishicon', 'revisionpower.cancelpower', null, '取消授权', 'pmkpi', 'cancelpower', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('P98F5984661BB918E053B11FA8C08PPP', '/pmkpi/prorevision/report', '删除项目', 1, 7, 'searchicon', 'revisionreport.delrevision', null, '删除项目', 'pmkpi', 'delrevision', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('P9DD48E616324744E053B11FA8C01BA3', '/pmkpi/prorevision/report', '查看明细', 1, 6, 'searchicon', 'revisionreport.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('P98F5984661BB918E053B11FA8C0831D', '/pmkpi/prorevision/report', '取消送审', 1, 4, 'searchicon', 'revisionreport.wfAudit', null, '取消送审', 'pmkpi', 'cancelsendaudit', null, '{"action":"audit_cancel"}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('P98F59846619B918E053B11FA8C0831D', '/pmkpi/prorevision/report', '送审', 1, 3, 'searchicon', 'revisionreport.wfAudit', null, '送审', 'pmkpi', 'sendaudit', null, '{"action":"audit"}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('P98F5984661AB918E053B11FA8C0831D', '/pmkpi/prorevision/report', '修订', 1, 2, 'searchicon', 'revisionreport.revisionment', null, '修订', 'pmkpi', 'toEdit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('P9C6AF05E29E637CE053B11FA8C06B90', '/pmkpi/prorevision/report', '选择项目', 1, 1, 'searchicon', 'revisionreport.checkprogram', null, '选择项目', 'pmkpi', 'checkprogram', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('P98F59846618B918E053B11FA8C0831D', '/pmkpi/prorevision/report', '审核情况', 1, 5, 'searchicon', 'revisionreport.queryaudit', null, '审核情况', 'pmkpi', 'showwfinfo', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('pA0A0BDBBC25FD6DE053B11FA8C09B70', '/pmkpi/prorevision/report/edit/editindex', '保存', 1, 1, 'Keepicon', 'prorevisioneditindex.save', null, '保存', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('pA0A0BDBBC26FD6DE053B11FA8C09B70', '/pmkpi/prorevision/report/edit/editindex', '取消', 1, 2, 'Nofinishicon', 'prorevisioneditindex.close', null, '取消', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9C975E5A7F3F59EE053B11FA8C00A31', '/pmkpi/prorevision/report/procheck', '确定', 1, 1, 'Keepicon', 'revisionreportcheck.save', null, '确定', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9C975E5A7F3F59EE053B11FA8C00A32', '/pmkpi/prorevision/report/procheck', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('P9B1886CA7B800A1E053B11FA8C0DBA4', '/pmkpi/prorevision/report/proedit', '保存', 1, 1, 'Keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('P9B1886CA7B900A1E053B11FA8C0DBA4', '/pmkpi/prorevision/report/proedit', '取消', 1, 2, 'Nofinishicon', 'tabfreamedit.close', null, '取消', 'pmkpi', null, null, null);

delete from p#busfw_t_uifunction where key = '/pmkpi/prorevision/report/check';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('PPC975E5A7F3F59EE053B11FA8C00A31', '/pmkpi/prorevision/report/check', '确定', 1, 1, 'Keepicon', 'revisionreportcheck.save', null, '确定', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('PPC975E5A7F3F59EE053B11FA8C00A32', '/pmkpi/prorevision/report/check', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', null, null, null);






delete from p#busfw_t_uiqueryform where key = '/pmkpi/prorevision/power';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('1D47F123B7D64F059CFFD06PP03E75EC', '/pmkpi/prorevision/power', 'CODE', '单位编码', 1, 1, 's', null, null, null, 'pmkpi', 'PERF_PROREVISION_AGENCY', '{}', null);

delete from p#busfw_t_uiqueryform where key = '/pmkpi/prorevision/report';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('07APD9D6FF9C417B01EBEA44A6B4063F', '/pmkpi/prorevision/report', 'WFSTATUS', '审核状态', 2, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_PROVISIONDECLARE', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('2C8PEF5C446344A59J3B4B83A3885DBC', '/pmkpi/prorevision/report', 'PRO_NAME', '名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_PROVISIONDECLARE', null, null);

delete from p#busfw_t_uiqueryform where key = '/pmkpi/prorevision/report/dept';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('Bp8F5984661EB918E053B11FA8C0831D', '/pmkpi/prorevision/report/dept', 'PRO_NAME', '单位名称', 2, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_PROVISIONDECLARE', '{}', null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('BpED1F7009C52EC2E053B11FA8C00E35', '/pmkpi/prorevision/report/dept', 'PRO_CODE', '单位编码', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_PROVISIONDECLARE', '{}', null);

delete from p#busfw_t_uiqueryform where key = '/pmkpi/prorevision/report/program';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('B98F59846620B918E053B11FA8C0831D', '/pmkpi/prorevision/report/program', 'PRO_NAME', '项目名称', 2, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_PROVISIONDECLARE', '{}', null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('B9ED1F7009C32EC2E053B11FA8C00E35', '/pmkpi/prorevision/report/program', 'PRO_CODE', '项目编码', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_PROVISIONDECLARE', '{}', null);




delete from p#busfw_t_uieditform where key = '/pmkpi/prorevision/report/proedit/goal';

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('P07C8252F57B39BAE053B11FA8C05F65', '/pmkpi/prorevision/report/proedit/goal', 'V_PERF_PROVISION_GOAL_INFO', 's', '创建人', 'CREATER', 0, null, 1, null, 14, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('P07C8252F58539BAE053B11FA8C05F65', '/pmkpi/prorevision/report/proedit/goal', 'V_PERF_PROVISION_GOAL_INFO', 's', '版本说明', 'VERSION_NAME', 0, null, 1, null, 25, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('P08C672A373023C2E053B11FA8C0E800', '/pmkpi/prorevision/report/proedit/goal', 'V_PERF_PROVISION_GOAL_INFO', 's', '是否年度指标', 'YEARFLAG', 0, null, 1, null, 31, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('P07C8252F57239BAE053B11FA8C05F65', '/pmkpi/prorevision/report/proedit/goal', 'V_PERF_PROVISION_GOAL_INFO', 's', 'guid', 'GUID', 0, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('P07C8252F57439BAE053B11FA8C05F65', '/pmkpi/prorevision/report/proedit/goal', 'V_PERF_PROVISION_GOAL_INFO', 's', '更新时间', 'UPDATE_TIME', 0, null, 1, null, 27, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('P07C8252F57539BAE053B11FA8C05F65', '/pmkpi/prorevision/report/proedit/goal', 'V_PERF_PROVISION_GOAL_INFO', 's', '是否删除1是2否', 'IS_DELETED', 0, null, 1, '2', 28, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('P07C8252F57639BAE053B11FA8C05F65', '/pmkpi/prorevision/report/proedit/goal', 'V_PERF_PROVISION_GOAL_INFO', 's', '创建时间', 'CREATE_TIME', 0, null, 1, null, 29, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('P07C8252F57739BAE053B11FA8C05F65', '/pmkpi/prorevision/report/proedit/goal', 'V_PERF_PROVISION_GOAL_INFO', 's', '单位', 'AGENCY_CODE', 0, null, 1, null, 30, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('P07C8252F57839BAE053B11FA8C05F65', '/pmkpi/prorevision/report/proedit/goal', 'V_PERF_PROVISION_GOAL_INFO', 's', '单位', 'AGENCYGUID', 0, null, 1, null, 11, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('P07C8252F57939BAE053B11FA8C05F65', '/pmkpi/prorevision/report/proedit/goal', 'V_PERF_PROVISION_GOAL_INFO', 's', '主单guid', 'MAINGUID', 0, null, 1, null, 12, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('P07C8252F57A39BAE053B11FA8C05F65', '/pmkpi/prorevision/report/proedit/goal', 'V_PERF_PROVISION_GOAL_INFO', 's', '创建时间', 'CREATETIME', 0, null, 1, null, 13, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('P07C8252F58639BAE053B11FA8C05F65', '/pmkpi/prorevision/report/proedit/goal', 'V_PERF_PROVISION_GOAL_INFO', 's', '下级财政区划代码', 'SUB_MOF_CODE', 0, null, 1, null, 26, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('P07C8252F57C39BAE053B11FA8C05F65', '/pmkpi/prorevision/report/proedit/goal', 'V_PERF_PROVISION_GOAL_INFO', 's', '区划', 'PROVINCE', 0, null, 1, null, 15, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('P07C8252F57D39BAE053B11FA8C05F65', '/pmkpi/prorevision/report/proedit/goal', 'V_PERF_PROVISION_GOAL_INFO', 's', '年度', 'YEAR', 0, null, 1, null, 16, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('P07C8252F57E39BAE053B11FA8C05F65', '/pmkpi/prorevision/report/proedit/goal', 'V_PERF_PROVISION_GOAL_INFO', 's', '项目绩效目标主键', 'KPI_PER_ID', 0, null, 1, null, 22, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('P07C8252F57F39BAE053B11FA8C05F65', '/pmkpi/prorevision/report/proedit/goal', 'V_PERF_PROVISION_GOAL_INFO', 's', '财政区划代码', 'MOF_DIV_CODE', 0, null, 1, null, 17, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('P07C8252F58039BAE053B11FA8C05F65', '/pmkpi/prorevision/report/proedit/goal', 'V_PERF_PROVISION_GOAL_INFO', 's', '预算年度', 'FISCAL_YEAR', 0, null, 1, null, 20, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('P07C8252F58139BAE053B11FA8C05F65', '/pmkpi/prorevision/report/proedit/goal', 'V_PERF_PROVISION_GOAL_INFO', 's', '项目代码', 'PRO_CODE', 0, null, 1, null, 21, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('P07C8252F58239BAE053B11FA8C05F65', '/pmkpi/prorevision/report/proedit/goal', 'V_PERF_PROVISION_GOAL_INFO', 'textarea', '年度绩效目标', 'KPI_TARGET', 1, null, 1, null, 2, 3, '3', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('P07C8252F58339BAE053B11FA8C05F65', '/pmkpi/prorevision/report/proedit/goal', 'V_PERF_PROVISION_GOAL_INFO', 's', '业务类型代码', 'BUSI_TYPE_CODE', 0, null, 1, null, 23, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('P07C8252F58439BAE053B11FA8C05F65', '/pmkpi/prorevision/report/proedit/goal', 'V_PERF_PROVISION_GOAL_INFO', 's', '版本号', 'VERSION', 0, null, 1, null, 24, null, null, 'pmkpi', 1, null, '{}', null, null, null);


delete from p#busfw_t_uieditform where key = '/pmkpi/prorevision/report/proedit/info';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('p9B4E70E0FE342E9E053B11FA8C0D47C', '/pmkpi/prorevision/report/proedit/info', 'V_PERF_T_PROVISIONDECLARE', 's', '项目guid', 'PROGUID', 0, null, 1, null, 2, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('p9B4E70E0FE242E9E053B11FA8C0D47C', '/pmkpi/prorevision/report/proedit/info', 'V_PERF_T_PROVISIONDECLARE', 's', 'GUID', 'GUID', 0, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null);







delete from p#busfw_t_uitabpage where key = '/pmkpi/prorevision/audit';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('P98F5984662BB918E053B11FA8C0831D', 'pmkpi', '/pmkpi/prorevision/audit', '曾经办', 'alldeals', 1, 3, 'nomal', 'prorevisionaudit.clickTabpage', 0, '曾经办', '', '审核,取消审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('P98F5984662DB918E053B11FA8C0831D', 'pmkpi', '/pmkpi/prorevision/audit', '审核', 'waitaudit', 1, 1, 'choosed', 'prorevisionaudit.clickTabpage', 0, '待审核', '', '取消审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('P98F5984662CB918E053B11FA8C0831D', 'pmkpi', '/pmkpi/prorevision/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'prorevisionaudit.clickTabpage', 0, '已审核', '', '审核', '{}', null, '0', null, null, null, null, null, null, null);

delete from p#busfw_t_uitabpage where key = '/pmkpi/prorevision/power';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('6F55700063D445P0PLL38EC1D7069D37', 'pmkpi', '/pmkpi/prorevision/power', '已授权', 'alreadypower', 1, 2, 'nomal', 'revisionpower.clickTabpage', null, '已授权', null, '授权', '{tablecode:''PERF_PROREVISION_AGENCY''}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('E339E58352B644APA711A4BPBPO43D0', 'pmkpi', '/pmkpi/prorevision/power', '未授权', 'waitpower', 1, 1, 'choosed', 'revisionpower.clickTabpage', null, '未授权', null, '取消授权', '{tablecode:''PMKPI_FASP_T_PUBAGENCY''}', null, '0', null, null, null, null, null, null, null);

delete from p#busfw_t_uitabpage where key = '/pmkpi/prorevision/report';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('P98F5984662DB918E053B11FA8C0831D', 'pmkpi', '/pmkpi/prorevision/report', '未送审', 'waitaudit', 1, 1, 'choosed', 'revisionreport.clickTabpage', 1, '未送审', '', '取消送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('P98F5984662CB918E053B11FA8C0831D', 'pmkpi', '/pmkpi/prorevision/report', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'revisionreport.clickTabpage', 1, '已送审', '', '修订,送审,删除项目,选择项目', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('P98F5984662BB918E053B11FA8C0831D', 'pmkpi', '/pmkpi/prorevision/report', '曾经办', 'alldeals', 1, 3, 'nomal', 'revisionreport.clickTabpage', 1, '曾经办', '', '修订,送审,取消送审,删除项目,选择项目', '{}', null, '0', null, null, null, null, null, null, null);


delete from p#busfw_t_uitabpage where key = '/pmkpi/prorevision/report/proedit';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('P9B1886CA78A00A1E053B11FA8C0DBA4', 'pmkpi', '/pmkpi/prorevision/report/proedit', '附件管理', 'file', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '附件管理', null, '保存', '{filebustype:''revisioneport'',url:''/pmkpi/upload/file/index.page''}', null, '0', 'iframemance', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('P9B1886CA78900A1E053B11FA8C0DBA4', 'pmkpi', '/pmkpi/prorevision/report/proedit', '绩效指标修订', 'proindex', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效指标修订', null, null, '{busguid:''B9B1886CA7A700A1E053B11FA8C0DBA4'',url:''/pmkpi/prorevision/report/proedit/index.page?showtab=1'',action:''revisionindex.save''}', null, '0', 'iframeindextable', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('P9B1886CA78800A1E053B11FA8C0DBA4', 'pmkpi', '/pmkpi/prorevision/report/proedit', '绩效目标修订', 'progoal', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效目标修订', null, null, '{busguid:''B9B1886CA7A600A1E053B11FA8C0DBA4'',url:''/pmkpi/prorevision/report/proedit/goal.page?showtab=1'||chr(38)||'isedittotal=0'',action:''revisiongoal.save''}', null, '0', 'iframegoaltable', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('P9B1886CA78600A1E053B11FA8C0DBA4', 'pmkpi', '/pmkpi/prorevision/report/proedit', '基本信息', 'proinfo', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, '保存', '{busguid:''B9B1886CA7A400A1E053B11FA8C0DBA4'',url:''/pmkpi/prorevision/report/proedit/info.page''}', null, '0', 'infoiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('P9B1886CA78700A1E053B11FA8C0DBA4', 'pmkpi', '/pmkpi/prorevision/report/proedit', '资金明细', 'bugamt', 0, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '资金明细', null, '保存', '{busguid:''B9B1886CA7A500A1E053B11FA8C0DBA4'',url:''/pmkpi/adjust/report/proedit/bgtamt.page''}', null, '0', 'bgtamtiframe', null, null, null, null, null, null);


delete from p#busfw_t_uitabpage where key = '/pmkpi/prorevision/report/proedit/goal';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('P07BE778599325B6E053B11FA8C0B323', 'pmkpi', '/pmkpi/prorevision/report/proedit/goal', '中期绩效目标', 'total', 1, 1, 'choosed', 'revisiongoal.clickTabpage', 0, '中期绩效目标', null, null, '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('P07BE778599225B6E053B11FA8C0B323', 'pmkpi', '/pmkpi/prorevision/report/proedit/goal', '年度绩效目标', 'year', 1, 2, 'nomal', 'revisiongoal.clickTabpage', 0, '年度绩效目标', null, null, '{}', null, '0', null, null, null, null, null, null, null);


delete from p#busfw_t_uitabpage where key = '/pmkpi/prorevision/report/proedit/index';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('prorevision/report/treeindex002', 'pmkpi', '/pmkpi/prorevision/report/proedit/index', '年度绩效指标', 'year', 1, 2, 'nomal', 'revisionindex.clickTabpage', 0, '年度绩效指标', null, null, '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('prorevision/report/treeindex001', 'pmkpi', '/pmkpi/prorevision/report/proedit/index', '总体绩效指标', 'total', 1, 1, 'choosed', 'revisionindex.clickTabpage', 0, '总体绩效指标', null, null, '{}', null, '0', null, null, null, null, null, null, null);



delete from p#busfw_t_uifunction where key = '/pmkpi/prorevision/report/edit/index';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('PA0A0BDBBC07FD6DE053B11FA8C09B70', '/pmkpi/prorevision/report/edit/index', '指标推荐', 1, 1, 'keepicon', 'revisionindex.recom', null, '指标推荐', 'pmkpi', 'recom', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('PA0A0BDBBC08FD6DE053B11FA8C09B70', '/pmkpi/prorevision/report/edit/index', '新增指标', 1, 2, 'keepicon', 'revisionindex.add', null, '新增指标', 'pmkpi', 'add', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('PA0A0BDBBC09FD6DE053B11FA8C09B70', '/pmkpi/prorevision/report/edit/index', '修改指标', 1, 3, 'keepicon', 'revisionindex.mod', null, '修改指标', 'pmkpi', 'mod', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('PA0A0BDBBC0AFD6DE053B11FA8C09B70', '/pmkpi/prorevision/report/edit/index', '删除指标', 1, 4, 'keepicon', 'revisionindex.del', null, '删除指标', 'pmkpi', 'del', null, null);
