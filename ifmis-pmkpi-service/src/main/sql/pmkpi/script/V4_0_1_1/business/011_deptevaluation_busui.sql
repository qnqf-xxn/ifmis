begin
--
delete from p#busfw_t_uitable where key = '/pmkpi/evaluation/dept/deptcheck';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('PPPA3B90E5163AC1E053B11FA8C06F54', '/pmkpi/evaluation/dept/deptcheck', 'PMKPI_FASP_T_PUBAGENCY', 100, 0, 0, 'code', 'isleaf<>1 and levelno=1', 'pmkpi', null);

delete from p#busfw_t_uitable where key = '/pmkpi/evaluation/dept/program';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BD25F32C9EA677B9EPP3B11FA8C041P0', '/pmkpi/evaluation/dept/program', 'V_PERF_T_DEPTEVALUATION', 100, 0, null, null, null, 'pmkpi', '{}' );

delete from p#busfw_t_uitable where key = '/pmkpi/evaluation/dept/program/audit';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BD672DCPPP398602E053B11FA8C0BE47', '/pmkpi/evaluation/dept/program/audit', 'V_PERF_T_DEPTEVALUATION', 0, 0, null, null, null, 'pmkpi', '{}');



delete from p#busfw_t_uicolumn where key = '/pmkpi/evaluation/dept/deptcheck';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('PPPP3B90E5273AC1E053B11FA8C06F54', '/pmkpi/evaluation/dept/deptcheck', 'GUID', 'guid', 1, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('PPPP3B90E5283AC1E053B11FA8C06F54', '/pmkpi/evaluation/dept/deptcheck', 'NAME', '名称', 3, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('PPPP3B90E5293AC1E053B11FA8C06F54', '/pmkpi/evaluation/dept/deptcheck', 'CODE', '编码', 2, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('PPPP3B90E52A3AC1E053B11FA8C06F54', '/pmkpi/evaluation/dept/deptcheck', 'FININTORGGUID', '业务科室', 4, 1, 0, 0, null, 0, 6, null, '#name', null, null, 100, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('PPPP3B90E5323AC1E053B11FA8C06F54', '/pmkpi/evaluation/dept/deptcheck', 'AGENCYGUID', '单位', 11, 0, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', null, null);



delete from p#busfw_t_uicolumn where key = '/pmkpi/evaluation/dept/program';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BDPPP32C9EAE77B9E053B11FA8C041F0', '/pmkpi/evaluation/dept/program', 'WFSTATUS', '审核状态', 1, 1, 0, null, null, null, null, null, '#name', null, null, 80, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BDPPP32C9EA777B9E053B11FA8C041F0', '/pmkpi/evaluation/dept/program', 'NAME', '项目名称', 2, 1, 0, null, null, null, 1, null, null, null, null, 150, 0, 's', '{ispro:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BDPPPB90E4FC3AC1E053B11FA8C06F54', '/pmkpi/evaluation/dept/program', 'CODE', '单位编码', 3, 1, 0, null, null, null, 6, null, null, null, null, 80, 0, 's', '{isdept:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BDPPPB90E4FD3AC1E053B11FA8C06F54', '/pmkpi/evaluation/dept/program', 'NAME', '单位名称', 4, 1, 0, null, null, null, 6, null, null, null, null, 150, 0, 's', '{isdept:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BDPPPp2C9EA877B9E053B11FA8C041F0', '/pmkpi/evaluation/dept/program', 'AGENCYGUID', '预算单位', 6, 1, 0, null, null, null, null, null, '#code-#name', null, null, 150, 1, 'tree', '{ispro:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD2A3PPPE4FE3AC1E053B11FA8C06F54', '/pmkpi/evaluation/dept/program', 'YEAR', '预算年度', 7, 1, 0, null, null, null, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD25F3PPPEAB77B9E053B11FA8C041F0', '/pmkpi/evaluation/dept/program', 'FININTORGGUID', '业务科室', 12, 1, 0, null, null, null, null, null, '#name', null, null, 90, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD25F32C9EAPPPB9E053B11FA8C041F0', '/pmkpi/evaluation/dept/program', 'CREATER', '填报人', 13, 1, 0, null, null, null, null, null, '#name', null, null, 90, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD25F3PPPEAD77B9E053B11FA8C041F0', '/pmkpi/evaluation/dept/program', 'GUID', '主键', 15, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD25F32C9EAFPPP9E053B11FA8C041F0', '/pmkpi/evaluation/dept/program', 'WFID', '工作流id', 20, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);


delete from p#busfw_t_uicolumn where key = '/pmkpi/evaluation/dept/program/audit';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD672DCCPPP98602E053B11FA8C0BE47', '/pmkpi/evaluation/dept/program/audit', 'WFSTATUS', '状态', 1, 1, 0, null, null, null, null, null, '#name', null, null, 80, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BDPPPDCCF3358602E053B11FA8C0BE47', '/pmkpi/evaluation/dept/program/audit', 'NAME', '单位名称', 2, 1, 0, null, null, null, 6, null, null, null, null, 150, 0, 's', '{isdept:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BDPPPDCCF32A8602E053B11FA8C0BE47', '/pmkpi/evaluation/dept/program/audit', 'NAME', '项目名称', 3, 1, 0, null, null, null, 1, null, null, null, null, 150, 0, 's', '{ispro:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BDPPPDCCF32B8602E053B11FA8C0BE47', '/pmkpi/evaluation/dept/program/audit', 'AGENCYGUID', '预算单位', 4, 1, 0, null, null, null, null, null, '#code-#name', null, null, 150, 1, 'tree', '{ispro:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BDPPPDCCF3348602E053B11FA8C0BE47', '/pmkpi/evaluation/dept/program/audit', 'CODE', '单位编码', 5, 1, 0, null, null, null, 6, null, null, null, null, 80, 0, 's', '{isdept:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BDPPPDCCF32C8602E053B11FA8C0BE47', '/pmkpi/evaluation/dept/program/audit', 'YEAR', '预算年份', 6, 1, 0, null, null, null, 1, null, null, null, null, 80, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BDPPPDCCF3378602E053B11FA8C0BE47', '/pmkpi/evaluation/dept/program/audit', 'FININTORGGUID', '业务科室', 7, 1, 0, null, null, null, null, null, '#name', null, null, 90, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BDPPPDCCF32E8602E053B11FA8C0BE47', '/pmkpi/evaluation/dept/program/audit', 'CREATER', '填报人', 9, 1, 0, null, null, null, null, null, '#name', null, null, 90, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BDPPPDCCF3328602E053B11FA8C0BE47', '/pmkpi/evaluation/dept/program/audit', 'ISRELEASE', '是否下达', 11, 0, 0, null, null, null, null, null, '#name', null, null, 80, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BDPPPDCCF36B8602E053B11FA8C0BE47', '/pmkpi/evaluation/dept/program/audit', 'ISNOTICE', '是否接收通知', 12, 0, 0, null, null, null, null, null, '#name', null, null, 80, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BDPPPDCCF32F8602E053B11FA8C0BE47', '/pmkpi/evaluation/dept/program/audit', 'GUID', '主键', 15, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{ispro:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BDPPPDCCF3308602E053B11FA8C0BE47', '/pmkpi/evaluation/dept/program/audit', 'WFID', '工作流id', 20, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{ispro:1}', null);



--uifunction
delete from p#busfw_t_uifunction where key = '/pmkpi/evaluation/dept/resultaudit';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('PPPPD19B03492359E053B11FA8C0BCA2', '/pmkpi/evaluation/dept/resultaudit', '审核', 1, 1, 'searchicon', 'deptevaluationresult.wfAudit', null, '审核', 'pmkpi', 'audit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('PPPPD19B034A2359E053B11FA8C0BCA2', '/pmkpi/evaluation/dept/resultaudit', '取消审核', 1, 2, 'searchicon', 'deptevaluationresult.wfAudit', null, '取消审核', 'pmkpi', 'cancelaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('PPPPD19B034C2359E053B11FA8C0BCA2', '/pmkpi/evaluation/dept/resultaudit', '查看评价成果', 1, 4, 'searchicon', 'deptevaluationresult.resultupload', null, '查看评价成果', 'pmkpi', 'queryresult', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('PPPPD19B034B2359E053B11FA8C0BCA2', '/pmkpi/evaluation/dept/resultaudit', '审核情况', 1, 5, 'searchicon', 'deptevaluationresult.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('ppp3D19B02762359E053B11FA8CPBCPP', '/pmkpi/evaluation/dept/resultaudit', '查看项目明细', 1, 7, 'searchicon', 'deptevaluationresult.detailed', null, '查看项目明细', 'pmkpi', 'detailed', null, '{}');





delete from p#busfw_t_uifunction where key = '/pmkpi/evaluation/dept/resultquery';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('PPPPp19B034C2359E053B11FA8C0BCA2', '/pmkpi/evaluation/dept/resultquery', '查看评价成果', 1, 4, 'searchicon', 'deptevaluationresult.resultupload', null, '查看评价成果', 'pmkpi', 'queryresult', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('PPPPp19B034B2359E053B11FA8C0BCA2', '/pmkpi/evaluation/dept/resultquery', '审核情况', 1, 5, 'searchicon', 'deptevaluationresult.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('ppp3D19B02762359E053B11FA8C0BCPP', '/pmkpi/evaluation/dept/resultquery', '查看项目明细', 1, 7, 'searchicon', 'deptevaluationresult.detailed', null, '查看项目明细', 'pmkpi', 'detailed', null, '{}');




delete from p#busfw_t_uifunction where key = '/pmkpi/evaluation/dept/audit';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('PPPB52A3C9C42PPPPP53B11FA8C0173F', '/pmkpi/evaluation/dept/audit', '查看未选择项目', 1, 8, 'searchicon', 'deptaudit.noselect', null, '查看未选择项目', 'pmkpi', 'noselect', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('PPPB52A3C9C12407E053B11FA8C0173F', '/pmkpi/evaluation/dept/audit', '审核', 1, 1, 'searchicon', 'deptaudit.wfAudit', null, '审核', 'pmkpi', 'audit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('PPPB52A3C9C22407E053B11FA8C0173F', '/pmkpi/evaluation/dept/audit', '取消审核', 1, 2, 'searchicon', 'deptaudit.wfAudit', null, '取消审核', 'pmkpi', 'cancelaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('PPPB52A3C9C42407E053B11FA8C0173F', '/pmkpi/evaluation/dept/audit', '查看项目明细', 1, 8, 'searchicon', 'deptaudit.detailed', null, '查看项目明细', 'pmkpi', 'detailed', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('PPPB52A3C9C52407E053B11FA8C0173F', '/pmkpi/evaluation/dept/audit', '审核情况', 1, 9, 'searchicon', 'deptaudit.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}');

delete from p#busfw_t_uifunction where key = '/pmkpi/evaluation/dept/auditedit';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BPPP5F9FB2977ECEE053B11FA8C00129', '/pmkpi/evaluation/dept/auditedit', '取消', 1, 2, 'searchicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', 'cancle', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BPPP5F9FB2987ECEE053B11FA8C00129', '/pmkpi/evaluation/dept/auditedit', '确认', 1, 1, 'searchicon', 'deptauditedit.save', null, '确认', 'pmkpi', 'save', null, '{}');

delete from p#busfw_t_uifunction where key = '/pmkpi/evaluation/dept/result';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('ppp3D19B02732359E053B11FA8C0BCA2', '/pmkpi/evaluation/dept/result', '评价成果上传', 1, 1, 'searchicon', 'deptevaluationresult.resultupload', null, '评价成果上传', 'pmkpi', 'resultupload', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('ppp3D19B02742359E053B11FA8C0BCA2', '/pmkpi/evaluation/dept/result', '送审', 1, 2, 'searchicon', 'deptevaluationresult.wfAudit', null, '送审', 'pmkpi', 'audit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('pppPD19B02752359E053B11FA8C0BCA2', '/pmkpi/evaluation/dept/result', '取消送审', 1, 3, 'searchicon', 'deptevaluationresult.wfAudit', null, '取消送审', 'pmkpi', 'cancelaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('ppp3D19B02762359E053B11FA8C0BCA2', '/pmkpi/evaluation/dept/result', '查看项目明细', 1, 7, 'searchicon', 'deptevaluationresult.detailed', null, '查看项目明细', 'pmkpi', 'detailed', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('ppp3D19B02772359E053B11FA8C0BCA2', '/pmkpi/evaluation/dept/result', '审核情况', 1, 8, 'searchicon', 'deptevaluationresult.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('ppp3D19B02732359E053B11FA8C0PPPP', '/pmkpi/evaluation/dept/result', '查看评价成果', 1, 6, 'searchicon', 'deptevaluationresult.resultupload', null, '查看评价成果', 'pmkpi', 'queryresult', null, '{}');




delete from p#busfw_t_uifunction where key = '/pmkpi/evaluation/dept/report';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD25F32C9EF577B9EPP3B11FA8C041F0', '/pmkpi/evaluation/dept/report', '审核情况', 1, 15, 'searchicon', 'deptproconfirm.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD25F32C9EED77B9E053B11FPPC041F0', '/pmkpi/evaluation/dept/report', '选择项目', 1, 1, 'searchicon', 'deptproconfirm.checkprogram', null, '选择项目', 'pmkpi', 'checkprogram', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD25F32C9EF077B9E053B11FPPC041F0', '/pmkpi/evaluation/dept/report', '删除项目', 1, 4, 'searchicon', 'deptproconfirm.del', null, '删除项目', 'pmkpi', 'del', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD25F32C9EF177B9E053B11FPPC041F0', '/pmkpi/evaluation/dept/report', '送审', 1, 7, 'searchicon', 'deptproconfirm.wfAudit', null, '送审', 'pmkpi', 'sendaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD25F32C9EF277B9E053B11FPPP041F0', '/pmkpi/evaluation/dept/report', '取消送审', 1, 8, 'searchicon', 'deptproconfirm.wfAudit', null, '取消送审', 'pmkpi', 'cancelsendaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD25F32C9EF477B9E053B11FPPC041F0', '/pmkpi/evaluation/dept/report', '查看项目明细', 1, 14, 'searchicon', 'deptproconfirm.detailed', null, '查看项目明细', 'pmkpi', 'detailed', null, '{}');

delete from p#busfw_t_uifunction where key = '/pmkpi/evaluation/dept/check';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD2APP90E5113AC1E053B11FA8C06F54', '/pmkpi/evaluation/dept/check', '确定', 1, 1, 'Keepicon', 'deptprocheck.save', null, '确定', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD2APP90E5123AC1E053B11FA8C06F54', '/pmkpi/evaluation/dept/check', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', null, null, null);

delete from p#busfw_t_uifunction where key = '/pmkpi/evaluation/dept/result/deptedit';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('PPPD4038AF63192EE053B11FA8C0ACB2', '/pmkpi/evaluation/dept/result/deptedit', '保存', 1, 1, 'Keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('PPPD4038AF66192EE053B11FA8C0ACB2', '/pmkpi/evaluation/dept/result/deptedit', '关闭', 1, 2, 'Nofinishicon', 'tabfreamedit.close', null, '关闭', 'pmkpi', null, null, null);

delete from p#busfw_t_uifunction where key = '/pmkpi/evaluation/dept/result/edit';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('PPP3D19B029C2359E053B11FA8C0BCA2', '/pmkpi/evaluation/dept/result/edit', '保存', 1, 1, 'Keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('PPP3D19B029D2359E053B11FA8C0BCA2', '/pmkpi/evaluation/dept/result/edit', '关闭', 1, 2, 'Nofinishicon', 'tabfreamedit.close', null, '关闭', 'pmkpi', null, null, null);

delete from p#busfw_t_uifunction where key = '/pmkpi/evaluation/deptreport/deptedit';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('PPP3D19B02D32359E053B11FA8C0BCA2', '/pmkpi/evaluation/deptreport/deptedit', '保存', 1, 1, 'Keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('PPP3D19B02D42359E053B11FA8C0BCA2', '/pmkpi/evaluation/deptreport/deptedit', '关闭', 1, 2, 'Nofinishicon', 'tabfreamedit.close', null, '关闭', 'pmkpi', null, null, null);


delete from p#busfw_t_uifunction where key = '/pmkpi/evaluation/deptreport/proedit';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('PPPA3B90E5413AC1E053B11FA8C06F54', '/pmkpi/evaluation/deptreport/proedit', '保存', 1, 1, 'Keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('PPPA3B90E5423AC1E053B11FA8C06F54', '/pmkpi/evaluation/deptreport/proedit', '关闭', 1, 2, 'Nofinishicon', 'tabfreamedit.close', null, '关闭', 'pmkpi', null, null, null);






delete from p#busfw_t_uiqueryform where key = '/pmkpi/evaluation/dept/deptcheck';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('PP2A3B90E52B3AC1E053B11FA8C06F54', '/pmkpi/evaluation/dept/deptcheck', 'NAME', '名称', 2, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_DEPTPERFDECLARE', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('PP2A3B90E52C3AC1E053B11FA8C06F54', '/pmkpi/evaluation/dept/deptcheck', 'CODE', '编码', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_DEPTPERFDECLARE', null, null);
delete from p#busfw_t_uiqueryform where key = '/pmkpi/evaluation/dept/program';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('BD25F32C9EB177B9E053B11FA8C041F0', '/pmkpi/evaluation/dept/program', 'NAME', '名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_DEPTEVALUATION', '{}', null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('BD25F32C9EB277B9E053B11FA8C041F0', '/pmkpi/evaluation/dept/program', 'FININTORGGUID', '业务处室', 1, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_DEPTEVALUATION', '{format:''#name''}', null);






delete from p#busfw_t_uieditform where key = '/pmkpi/evaluation/dept/result/edit';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('PPP3D19B028F2359E053B11FA8C0BCA2', '/pmkpi/evaluation/dept/result/edit', 'V_PERF_T_DEPTEVALUATION', 's', 'guid', 'GUID', 0, null, 0, null, 1, 0, '0', 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('PPP3D19B028E2359E053B11FA8C0BCA2', '/pmkpi/evaluation/dept/result/edit', 'V_PERF_T_DEPTEVALUATION', 'textarea', '存在问题', 'EXISTQUESTION', 1, null, 1, null, 2, 3, '3', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('PPP3D19B02902359E053B11FA8C0BCA2', '/pmkpi/evaluation/dept/result/edit', 'V_PERF_T_DEPTEVALUATION', 'textarea', '整改措施和建议', 'FEEDBACK', 1, null, 1, null, 3, 3, '3', 'pmkpi', 1, null, '{}', null, null, null);

delete from p#busfw_t_uieditform where key = '/pmkpi/evaluation/dept/auditedit';
insert into  busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('PPPE5F9FB2997ECEE053B11FA8C00129', '/pmkpi/evaluation/dept/auditedit', 'PERF_T_EVALUATEAUDIT', 'textarea', '审核意见', 'OPINION', 1, null, 1, null, 2, 2, '3', 'pmkpi', 1, null, '{}', null, null, null);

insert into  busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('PP3E5F9FB29A7ECEE053B11FA8C00129', '/pmkpi/evaluation/dept/auditedit', 'PERF_T_EVALUATEAUDIT', 'tree', '常用审核意见', 'OLDOPINION', 1, null, 0, null, 3, null, null, 'pmkpi', 1, null, '{format:''#name''}', 0, null, null);

insert into  busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('PPPP5F9FB29B7ECEE053B11FA8C00129', '/pmkpi/evaluation/dept/auditedit', 'PERF_T_EVALUATEAUDIT', 'tree', '审核操作', 'ORDINARYTYPE', 1, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{format:''#name''}', 0, null, null);

delete from p#busfw_t_uieditform where key = '/pmkpi/evaluation/deptreport/deptedit';
insert into  busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD5PPP9B02D02359E053B11FA8C0BCA2', '/pmkpi/evaluation/deptreport/deptedit', 'V_PERF_T_DEPTEVALUATION', 's', '项目guid', 'PROGUID', 0, null, 1, null, 2, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into  busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BPPPD19B02CD2359E053B11FA8C0BCA2', '/pmkpi/evaluation/deptreport/deptedit', 'V_PERF_T_DEPTEVALUATION', 's', '部门编码', 'CODE', 1, null, 1, null, 3, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into  busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BPPPP19B02CE2359E053B11FA8C0BCA2', '/pmkpi/evaluation/deptreport/deptedit', 'V_PERF_T_DEPTEVALUATION', 's', '部门名称', 'NAME', 1, null, 1, null, 4, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into  busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('PPP3D19B02CF2359E053B11FA8C0BCA2', '/pmkpi/evaluation/deptreport/deptedit', 'V_PERF_T_DEPTEVALUATION', 's', 'guid', 'GUID', 0, null, 1, null, 1, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0);


delete from p#busfw_t_uieditform where key = '/pmkpi/evaluation/deptreport/edit';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('PPPCBF7062DA2AC8E053B11FA8C05B8C', '/pmkpi/evaluation/deptreport/edit', 'V_PERF_T_DEPTEVALUATION', 'tree', '牵头处室', 'FININTORGGUID', 0, null, 1, null, 17, null, null, 'pmkpi', 1, 0, '{"format":"#name"}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('PPPA3B90E5843AC1E053B11FA8C06F54', '/pmkpi/evaluation/deptreport/edit', 'V_PERF_T_DEPTEVALUATION', 's', 'guid', 'GUID', 0, null, 1, null, 1, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('PPPA3B90E5853AC1E053B11FA8C06F54', '/pmkpi/evaluation/deptreport/edit', 'V_PERF_T_DEPTEVALUATION', 's', '项目guid', 'PROGUID', 0, null, 1, null, 2, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('PPPA3B90E5863AC1E053B11FA8C06F54', '/pmkpi/evaluation/deptreport/edit', 'V_PERF_T_DEPTEVALUATION', 's', '项目名称', 'NAME', 0, null, 1, null, 3, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('PPPA3B90E5873AC1E053B11FA8C06F54', '/pmkpi/evaluation/deptreport/edit', 'V_PERF_T_DEPTEVALUATION', 'tree', '预算单位', 'AGENCYGUID', 0, null, 0, null, 4, null, null, 'pmkpi', 1, 0, '{"format":"#code-#name"}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('PPPA3B90E5883AC1E053B11FA8C06F54', '/pmkpi/evaluation/deptreport/edit', 'V_PERF_T_DEPTEVALUATION', 'd', '开始日期', 'PRO_START_YEAR', 0, null, 1, null, 6, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('PPPA3B90E5893AC1E053B11FA8C06F54', '/pmkpi/evaluation/deptreport/edit', 'V_PERF_T_DEPTEVALUATION', 'd', '截止日期', 'ENDTIME', 0, null, 0, null, 7, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('PPPA3B90E58B3AC1E053B11FA8C06F54', '/pmkpi/evaluation/deptreport/edit', 'V_PERF_T_DEPTEVALUATION', 's', '项目负责人', 'LEADER_NAME', 0, null, 0, null, 9, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('PPPA3B90E58C3AC1E053B11FA8C06F54', '/pmkpi/evaluation/deptreport/edit', 'V_PERF_T_DEPTEVALUATION', 's', '项目联系人', 'PROJECTCON', 0, null, 1, null, 10, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('PPPA3B90E58D3AC1E053B11FA8C06F54', '/pmkpi/evaluation/deptreport/edit', 'V_PERF_T_DEPTEVALUATION', 's', '联系人电话', 'LEADER_PHONE', 0, null, 0, null, 11, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('PPPA3B90E58E3AC1E053B11FA8C06F54', '/pmkpi/evaluation/deptreport/edit', 'V_PERF_T_DEPTEVALUATION', 'amt', '项目总金额', 'PRO_TOTAL_AMT', 0, null, 1, null, 12, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('PPPA3B90E58F3AC1E053B11FA8C06F54', '/pmkpi/evaluation/deptreport/edit', 'V_PERF_T_DEPTEVALUATION', 'amt', '当年预算金额', 'PROJAMT', 0, null, 1, null, 13, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('PPPC08690B222973E053B11FA8C01253', '/pmkpi/evaluation/deptreport/edit', 'V_PERF_T_DEPTEVALUATION', 'tree', '绩效类型', 'CATEGORY', 0, null, 1, null, 16, null, null, 'pmkpi', 1, 0, '{"format":"#name"}', 0, 0, 0);






delete from p#busfw_t_uitabpage where key = '/pmkpi/evaluation/dept/resultaudit';
insert into  busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53D19B03142359E053B11FA8C0Bppp', 'pmkpi', '/pmkpi/evaluation/dept/resultaudit', '待审核', 'waitaudit', 1, 1, 'choosed', 'deptevaluationresult.clickTabpage', 0, '待审核', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into  busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53D19B03152359E053B11FA8C0Bppp', 'pmkpi', '/pmkpi/evaluation/dept/resultaudit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'deptevaluationresult.clickTabpage', 0, '已审核', null, '审核,退回', '{}', null, '0', null, null, null, null, null, null, null);

insert into  busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53D19B03162359E053B11FA8C0Bppp', 'pmkpi', '/pmkpi/evaluation/dept/resultaudit', '曾经办', 'allconfirm', 1, 3, 'nomal', 'deptevaluationresult.clickTabpage', 0, '曾经办', null, '审核,取消审核,退回', '{}', null, '0', null, null, null, null, null, null, null);


delete from p#busfw_t_uitabpage where key = '/pmkpi/evaluation/dept/audit';
insert into  busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PPPB52A3C9BE2407E053B11FA8C0173F', 'pmkpi', '/pmkpi/evaluation/dept/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'deptaudit.clickTabpage', 0, '待审核', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into  busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PPPB52A3C9BF2407E053B11FA8C0173F', 'pmkpi', '/pmkpi/evaluation/dept/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'deptaudit.clickTabpage', 0, '已审核', null, '审核,退回', '{}', null, '0', null, null, null, null, null, null, null);

insert into  busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PPPB52A3C9C02407E053B11FA8C0173F', 'pmkpi', '/pmkpi/evaluation/dept/audit', '曾经办', 'allconfirm', 1, 3, 'nomal', 'deptaudit.clickTabpage', 0, '曾经办', null, '审核,取消审核,退回', '{}', null, '0', null, null, null, null, null, null, null);



delete from p#busfw_t_uitabpage where key = '/pmkpi/evaluation/dept/result';
insert into  busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PPP3D19B02702359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/dept/result', '待提交', 'waitaudit', 1, 1, 'choosed', 'deptevaluationresult.clickTabpage', 0, '待提交', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into  busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PPP3D19B02712359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/dept/result', '已提交', 'alreadyaudit', 1, 2, 'nomal', 'deptevaluationresult.clickTabpage', 0, '已提交', null, '评价成果上传,送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into  busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PPP3D19B02722359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/dept/result', '曾经办', 'allconfirm', 1, 3, 'nomal', 'deptevaluationresult.clickTabpage', 0, '曾经办', null, '评价成果上传,送审,取消送审', '{}', null, '0', null, null, null, null, null, null, null);




delete from p#busfw_t_uitabpage where key = '/pmkpi/evaluation/dept/report';
insert into  busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PP25F32C9EBD77B9E053B11FA8C041F0', 'pmkpi', '/pmkpi/evaluation/dept/report', '已确认', 'alreadyaudit', 1, 2, 'nomal', 'deptproconfirm.clickTabpage', 0, '已确认', null, '送审,选择项目,新增项目,修改项目,删除项目', '{}', null, '0', null, null, null, null, null, null, null);

insert into  busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PP25F32C9EBE77B9E053B11FA8C041F0', 'pmkpi', '/pmkpi/evaluation/dept/report', '曾经办', 'allconfirm', 1, 3, 'nomal', 'deptproconfirm.clickTabpage', 0, '曾经办', null, '送审,取消提交,选择项目,新增项目,修改项目,删除项目', '{}', null, '0', null, null, null, null, null, null, null);

insert into  busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PP25F32C9EBC77B9E053B11FA8C041F0', 'pmkpi', '/pmkpi/evaluation/dept/report', '待确认', 'waitaudit', 1, 1, 'choosed', 'deptproconfirm.clickTabpage', 0, '待确认', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);



delete from p#busfw_t_uitabpage where key = '/pmkpi/evaluation/dept/result/deptedit';
insert into  busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PPPPD19B02E52359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/dept/result/deptedit', '基本信息', 'info', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, '保存', '{viewtype:''query''}', null, '0', 'infoeditform', null, null, null, null, null, null);

insert into  busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PPPPD19B02E62359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/dept/result/deptedit', '评价成果', 'file', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '评价成果', null, '保存', '{filebustype:''deptevadeptresult'',url:''/pmkpi/upload/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);

insert into  busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PPPPD19B02E32359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/dept/result/deptedit', '评估结论', 'info', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '评估结论', null, null, '{busguid:''BD53D19B028A2359E053B11FA8C0BCA2''}', null, '0', 'editform', null, null, null, null, null, null);

insert into  busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PPPPD19B02E42359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/dept/result/deptedit', '项目附件', 'file', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '项目附件', null, '保存', '{filebustype:''deptevadept'',url:''/pmkpi/upload/file/index.page'',viewtype:''query''}', null, '0', 'manceiframe', null, null, null, null, null, null);


delete from p#busfw_t_uitabpage where key = '/pmkpi/evaluation/dept/result/edit';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PP53D19B02D72359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/dept/result/edit', '基本信息', 'info', 0, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, '保存', '{viewtype:''query''}', null, '0', 'infoeditform', null, null, null, null, null,  null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PP53D19B02872359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/dept/result/edit', '项目附件', 'file', 0, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '项目附件', null, '保存', '{filebustype:''deptevapro'',url:''/pmkpi/upload/file/index.page'',viewtype:''query''}', null, '0', 'manceiframe', null, null, null, null, null,  null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PPP3D19B02862359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/dept/result/edit', '评估结论', 'info', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '评估结论', null, null, '{busguid:''BD53D19B028A2359E053B11FA8C0BCA2''}', null, '0', 'editform', null, null, null, null, null,  null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PPP3D19B02D82359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/dept/result/edit', '评价成果', 'file', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '评价成果', null, '保存', '{filebustype:''deptevaproresult'',url:''/pmkpi/upload/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null,  null);




delete from p#busfw_t_uitabpage where key = '/pmkpi/evaluation/deptreport/deptedit';
insert into  busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53D19PP2D12359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/deptreport/deptedit', '基本信息', 'info', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, null, '{busguid:''BD2A3B90E5403AC1E053B11FA8C06F54''}', null, '0', 'infoeditform', null, null, null, null, null, null);

insert into  busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53D19PP2D22359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/deptreport/deptedit', '附件管理', 'file', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '附件管理', null, '保存', '{filebustype:''deptevadept'',url:''/pmkpi/upload/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);


delete from p#busfw_t_uitabpage where key = '/pmkpi/evaluation/deptreport/proedit';
insert into  busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PPPA3B90E53D3AC1E053B11FA8C06F54', 'pmkpi', '/pmkpi/evaluation/deptreport/proedit', '基本信息', 'info', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, null, '{busguid:''BD2A3B90E5403AC1E053B11FA8C06F54''}', null, '0', 'infoeditform', null, null, null, null, null, null);

insert into  busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('PPPA3B90E53E3AC1E053B11FA8C06F54', 'pmkpi', '/pmkpi/evaluation/deptreport/proedit', '附件管理', 'file', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '附件管理', null, '保存', '{filebustype:''deptevapro'',url:''/pmkpi/upload/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);

