begin
--流程
delete from p#busfw_t_dcworkflowplan where guid in ('ACB7014749AFD762BBFD99D8304BA3FA','ACB7014749AFD762BBFD99D8304BA3FC','ACB7014749AFD762BBFD99D8304BA3FB');
insert into busfw_t_dcworkflowplan (GUID, CODE, TABLECODE, NAME, STATUS, YEAR, PROVINCE, VERSION, DBVERSION, REMARK, CREATER, CREATETIME, TYPE)
values ('ACB7014749AFD762BBFD99D8304BA3FA', 'PERF_T_SUPERVISION', 'PERF_T_SUPERVISION', '绩效目标监审-转移支付', '1', '2016', '87', null, '', '', '', '20200827225021776', 'B876713347C31372A297A0234F30FFB8');


insert into busfw_t_dcworkflowplan (GUID, CODE, TABLECODE, NAME, STATUS, YEAR, PROVINCE, VERSION, DBVERSION, REMARK, CREATER, CREATETIME, TYPE)
values ('ACB7014749AFD762BBFD99D8304BA3FC', 'PERF_T_SUPERVISION', 'PERF_T_SUPERVISION', '绩效目标监审-二级项目', '1', '2016', '87', null, '', '', '', '20200827225021776', 'B876713347C31372A297A0234F30FFB8');

insert into busfw_t_dcworkflowplan (GUID, CODE, TABLECODE, NAME, STATUS, YEAR, PROVINCE, VERSION, DBVERSION, REMARK, CREATER, CREATETIME, TYPE)
values ('ACB7014749AFD762BBFD99D8304BA3FB', 'PERF_T_SUPERVISION', 'PERF_T_SUPERVISION', '绩效目标监审-一级项目', '1', '2016', '87', null, '', '', '', '20200827225021776', 'B876713347C31372A297A0234F30FFB8');


--目标监审
delete from p#busfw_t_uitable where key = '/pmkpi/supervision/index';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('54FE255E2CCF47419A4CF733271A2FDA', '/pmkpi/supervision/index', 'PERF_T_SUPERVISION', 100, 1, 0, '', '', 'pmkpi', '{}');


delete from p#busfw_t_uicolumn where key = '/pmkpi/supervision/index';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CF187E2685E9271032D58DA985FE11F1', '/pmkpi/supervision/index', 'GUID', 'GUID', 1, 0, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');


delete from p#busfw_t_uifunction where key = '/pmkpi/supervision/index';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('227F66E0D5874E5B8CB48AB02514F267', '/pmkpi/supervision/index', '送审', 1, 3, 'searchicon', 'supervision.sendtoAudit', null, '送审', 'pmkpi', 'audit', '', '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('227F66E0D5874E5B8CB48AB02514F268', '/pmkpi/supervision/index', '审核情况', 1, 4, 'searchicon', 'supervision.showwfinfo', null, '审核情况', 'pmkpi', 'showwfinfo', '', '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('227F66E0D5874E5B8CB48AB02514F269', '/pmkpi/supervision/index', '批量修改', 1, 5, 'searchicon', 'supervision.update', null, '批量修改', 'pmkpi', 'update', '', '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('227F66E0D5874E5B8CB48AB02514F266', '/pmkpi/supervision/index', '保存', 1, 2, 'searchicon', 'supervision.save', null, '保存', 'pmkpi', 'save', '', '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('227F62E0D5874E5B8CB48AB02514F266', '/pmkpi/supervision/index', '项目详情', 1, 6, 'searchicon', 'supervision.showProjView', null, '项目详情', 'pmkpi', 'showProjView', '', '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('8FF836B81212192FE053B1100A0A5AE6', '/pmkpi/supervision/index', '导出列表', 1, 7, 'searchicon', 'supervision.exportProj', null, '导出列表', 'pmkpi', 'exportProj', '', '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('8FF836B81312192FE053B1100A0A5AE6', '/pmkpi/supervision/index', '导入监审结果', 1, 8, 'searchicon', 'supervision.importProj', null, '导入监审结果', 'pmkpi', 'importProj', '', '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('8FF836B81412192FE053B1100A0A5AE6', '/pmkpi/supervision/index', '项目打捆查询', 1, 9, 'searchicon', 'supervision.bundquery', null, '项目打捆查询', 'pmkpi', 'bundquery', '', '{}');


delete from p#busfw_t_uitabpage where key = '/pmkpi/supervision/index';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('9D171EA06B9A94BF9AB24CCF862CCF33', 'pmkpi', '/pmkpi/supervision/index', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'supervision.clickTabpage', 0, '已送审', '', '保存提交批量修改监审意见', '{}', '', 'done', '', '', '', '', '', '', '');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('7867D574E59B9B11AB3EBA64313FD4E4', 'pmkpi', '/pmkpi/supervision/index', '曾经办', 'alldeals', 1, 3, 'nomal', 'supervision.clickTabpage', 0, '曾经办', '', '保存提交批量修改监审意见', '{}', '', 'ever', '', '', '', '', '', '', '');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('324B3F3A174C195E1948FA395E44ED32', 'pmkpi', '/pmkpi/supervision/index', '待送审', 'waitaudit', 1, 1, 'choosed', 'supervision.clickTabpage', 0, '待送审', '', '', '{}', '', 'wait', '', '', '', '', '', '', '');


--二级
delete from p#busfw_t_uitable where key = '/pmkpi/prodetail/supervision/index';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('54FE255E2CCF47319A5CF733271A2FDA', '/pmkpi/prodetail/supervision/index', 'V_PERF_T_SUPERVISIONVIEW', 100, 1, 0, '', '', 'pmkpi', '{}');


delete from p#busfw_t_uicolumn where key = '/pmkpi/prodetail/supervision/index';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CFF1E07B176424875C715124E0A13410', '/pmkpi/prodetail/supervision/index', 'ADJOPTION', '监审意见', 1, 1, 1, null, '', null, null, '', '#name', '', null, null, 1, 'terr', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('39A6DFDFC6C4F1A89A1568D98DDE4AAB', '/pmkpi/prodetail/supervision/index', 'AGENCYGUID', '预算单位', 13, 0, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('312B6DB46563392FAAD5031E75A3BC29', '/pmkpi/prodetail/supervision/index', 'DEPT', '部门', 14, 0, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9794546DE8FD1CC5957DCD877AB84521', '/pmkpi/prodetail/supervision/index', 'KPI_LV2', '二级指标', 7, 1, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CF187E2885E9271932D58DA985FE11F1', '/pmkpi/prodetail/supervision/index', 'GUID', 'GUID', 22, 0, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('A0864219DA1EFACCE7073E0E937924ED', '/pmkpi/prodetail/supervision/index', 'WEIGHT', '权重', 10, 1, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('6E085F5E4606EABAB883A148E852977C', '/pmkpi/prodetail/supervision/index', 'OPTIONS', '其他意见', 2, 1, 1, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2940CADD1CC335F7C53DEF7B22E410CA', '/pmkpi/prodetail/supervision/index', 'PRO_CODE', '项目编码', 4, 0, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D8F64A9C1656306C924B64D78764FD42', '/pmkpi/prodetail/supervision/index', 'MAINGUID', '项目guid', 21, 0, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0B42850D9F09F720C5AB4EDAE2585EAA', '/pmkpi/prodetail/supervision/index', 'PROJTYPE', 'PROJTYPE', 18, 0, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1C2E3F8C1EB349901144BE53D738E72D', '/pmkpi/prodetail/supervision/index', 'PRONAME', '项目名称', 3, 1, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6EF3E3D76AA49E171ECA94007CCA0E', '/pmkpi/prodetail/supervision/index', 'KPI_VAL', '指标值', 9, 1, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D789B1D840DABFE12A758CD70185EAAD', '/pmkpi/prodetail/supervision/index', 'ADDINDEX', '入库状态', 11, 1, 0, null, '', null, null, '', '', '', null, null, 1, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('38E0AE2E79A15D27172E5E317CF2BD9E', '/pmkpi/prodetail/supervision/index', 'KPI_LV3', '三级指标', 8, 1, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('AA0C56E96DEF89D225E502722FF8743A', '/pmkpi/prodetail/supervision/index', 'WFID', '流程id', 17, 0, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('3496DAF673697FFB9E0062A5722420E5', '/pmkpi/prodetail/supervision/index', 'PROAMT', '预算资金(万元)', 5, 1, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{style:''text-align:right''}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BCC6657E889C8F81E9111777D478E22E', '/pmkpi/prodetail/supervision/index', 'YJPRONAME', '一级项目名称', 16, 1, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('FF93A52E4AAEFDA4B12BBD83718E5D4A', '/pmkpi/prodetail/supervision/index', 'ISPEREVAL', '是否事前评估', 20, 1, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CFF1E07B176424875C755124E0A13410', '/pmkpi/prodetail/supervision/index', 'WFSTATUS', '流程状态', 19, 0, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{format:''#name''}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CFF1E07BA76424875C755124E0A13410', '/pmkpi/prodetail/supervision/index', 'WFSTATUSNAME', '流程状态', 19, 1, 0, null, '', null, null, '', '', '', null, null, 0, 'S', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9794546DE8FD1CC5957DCD877AB84521', '/pmkpi/prodetail/supervision/index', 'KPI_LV1', '一级指标', 6, 1, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('39A6DF98C6C4F1A89A1568D98DDE4AAB', '/pmkpi/prodetail/supervision/index', 'AGENCYNAME', '预算单位', 12, 1, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('39A6DF98C6C4F1089A1568D98DDE4AAB', '/pmkpi/prodetail/supervision/index', 'FININTIRGNAME', '处室', 15, 1, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{}', '');


delete from p#busfw_t_uiqueryform where key = '/pmkpi/prodetail/supervision/index';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('6B704435771CF13CE053D100A8C04522', '/pmkpi/prodetail/supervision/index', 'PRONAME', '项目名称', 2, 1, 's', '', null, null, 'pmkpi', 'V_PERF_T_SUPERVISIONVIEW', '{}', null);

--一级

delete from p#busfw_t_uitable where key = '/pmkpi/promain/supervision/index';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('54FE255E2CCF47319A6CF733271A2FDA', '/pmkpi/promain/supervision/index', 'V_PERF_T_SUPERVISIONVIEW', 100, 1, 0, '', '', 'pmkpi', '{}');


delete from p#busfw_t_uicolumn where key = '/pmkpi/promain/supervision/index';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CFF1E07B176124875C715124E0A13410', '/pmkpi/promain/supervision/index', 'ADJOPTION', '监审意见', 1, 1, 1, null, '', null, null, '', '#name', '', null, null, 1, 'terr', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('39A6DF98C6C2F1089A1568D98DDE4AAB', '/pmkpi/promain/supervision/index', 'FININTIRGNAME', '处室', 14, 1, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('39A6DF98C6C3F1A89A1568D98DDE4AAB', '/pmkpi/promain/supervision/index', 'AGENCYNAME', '预算单位', 13, 0, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('39A6DFDFC6C441A89A1568D98DDE4AAB', '/pmkpi/promain/supervision/index', 'AGENCYGUID', '预算单位', 12, 0, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('312B6DB46563592FAAD5031E75A3BC29', '/pmkpi/promain/supervision/index', 'DEPTNAME', '部门', 15, 1, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9794546DE8FD17C5957DCD877AB84521', '/pmkpi/promain/supervision/index', 'KPI_LV2', '二级指标', 7, 1, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CF187E2885E9971932D58DA985FE11F1', '/pmkpi/promain/supervision/index', 'GUID', 'GUID', 21, 0, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('A0864219DA1EF81CE7073E0E937924ED', '/pmkpi/promain/supervision/index', 'WEIGHT', '权重', 10, 1, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('6E085F5E4606EA2AB883A148E852977C', '/pmkpi/promain/supervision/index', 'OPTIONS', '其他意见', 2, 1, 1, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2940CADD1CC33537C53DEF7B22E410CA', '/pmkpi/promain/supervision/index', 'PRO_CODE', '项目编码', 4, 0, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D8F64A9C1656304C924B64D78764FD42', '/pmkpi/promain/supervision/index', 'MAINGUID', '项目guid', 22, 0, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0B42850D9F09F755C5AB4EDAE2585EAA', '/pmkpi/promain/supervision/index', 'PROJTYPE', 'PROJTYPE', 18, 0, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1C2E3F8C1EB349961144BE53D738E72D', '/pmkpi/promain/supervision/index', 'PRONAME', '项目名称', 3, 1, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6EF3E3D76AA49E771ECA94007CCA0E', '/pmkpi/promain/supervision/index', 'KPI_VAL', '指标值', 9, 1, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D789B1D840DABFE18A758CD70185EAAD', '/pmkpi/promain/supervision/index', 'ADDINDEX', '入库状态', 11, 1, 0, null, '', null, null, '', '', '', null, null, 1, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('38E0AE2E79A15D27972E5E317CF2BD9E', '/pmkpi/promain/supervision/index', 'KPI_LV3', '三级指标', 8, 1, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('AA0C56E96DEF89D220E502722FF8743A', '/pmkpi/promain/supervision/index', 'WFID', '流程id', 17, 0, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('3496DAF673697FFB910062A5722420E5', '/pmkpi/promain/supervision/index', 'PROAMT', '预算资金(万元)', 5, 1, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{style:''text-align:right''}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BCC6657E889C8F81E2111777D478E22E', '/pmkpi/promain/supervision/index', 'YJPRONAME', '一级项目名称', 16, 0, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('FF93A52E4AAEFDA4B32BBD83718E5D4A', '/pmkpi/promain/supervision/index', 'ISPEREVAL', '是否事前评估', 20, 1, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CFF1E07B1764248754755124E0A13410', '/pmkpi/promain/supervision/index', 'WFSTATUS', '流程状态', 19, 0, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{format:''#name''}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CFF1E07BA7642C875C755124E0A13410', '/pmkpi/promain/supervision/index', 'WFSTATUSNAME', '流程状态', 19, 1, 0, null, '', null, null, '', '', '', null, null, 0, 'S', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9794546DE8FD1CC5967DCD877AB84521', '/pmkpi/promain/supervision/index', 'KPI_LV1', '一级指标', 6, 1, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{}', '');


delete from p#busfw_t_uiqueryform where key = '/pmkpi/promain/supervision/index';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('6B704435772CF13CE053D100A8C04522', '/pmkpi/promain/supervision/index', 'PRONAME', '项目名称', 2, 1, 's', '', null, null, 'pmkpi', 'V_PERF_T_SUPERVISIONVIEW', '{}', null);


--转移支付

delete from p#busfw_t_uitable where key = '/pmkpi/propay/supervision/index';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('54FE255E2CCF47319A6CF733271A2FDA', '/pmkpi/propay/supervision/index', 'V_PERF_T_SUPERVISIONVIEW', 100, 1, 0, '', '', 'pmkpi', '{}');


delete from p#busfw_t_uicolumn where key = '/pmkpi/propay/supervision/index';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CFF1E07B176424875C715124E0A13410', '/pmkpi/propay/supervision/index', 'ADJOPTION', '监审意见', 1, 1, 1, null, '', null, null, '', '', '', null, null, 1, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('39A6DFDFC6C4F1A89A1568D98DDE4AAB', '/pmkpi/propay/supervision/index', 'AGENCYCODE', '单位代码', 7, 0, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('312B6DB46563392FAAD5031E75A3BC29', '/pmkpi/propay/supervision/index', 'DEPT', '部门', 12, 1, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('A4973E94DCF4BB181D5850A00DB71E0F', '/pmkpi/propay/supervision/index', 'CS', '处室', 13, 0, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9794546DE8FD1CC5957DCD877AB84521', '/pmkpi/propay/supervision/index', 'FINDEX', '二级指标', 6, 1, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CF187E2885E9271932D58DA985FE11F1', '/pmkpi/propay/supervision/index', 'GUID', 'GUID', 1, 0, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('A0864219DA1EFACCE7073E0E937924ED', '/pmkpi/propay/supervision/index', 'WEIGHT', '权重', 10, 1, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('6E085F5E4606EABAB883A148E852977C', '/pmkpi/propay/supervision/index', 'OPTIONS', '其他意见', 2, 1, 1, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2940CADD1CC335F7C53DEF7B22E410CA', '/pmkpi/propay/supervision/index', 'PROCODE', '项目编码', 3, 0, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D8F64A9C1656306C924B64D78764FD42', '/pmkpi/propay/supervision/index', 'PROJGUID', '项目guid', 1, 0, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0B42850D9F09F720C5AB4EDAE2585EAA', '/pmkpi/propay/supervision/index', 'PROJTYPE', 'PROJTYPE', 18, 0, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1C2E3F8C1EB349901144BE53D738E72D', '/pmkpi/propay/supervision/index', 'PRONAME', '项目名称', 3, 1, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA6EF3E3D76AA49E171ECA94007CCA0E', '/pmkpi/propay/supervision/index', 'REFERENCEPOLE', '指标值', 9, 1, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D789B1D840DABFE12A758CD70185EAAD', '/pmkpi/propay/supervision/index', 'ADDINDEX', '入库状态', 11, 1, 0, null, '', null, null, '', '', '', null, null, 1, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('38E0AE2E79A15D27172E5E317CF2BD9E', '/pmkpi/propay/supervision/index', 'MEASURESNAME', '三级指标', 8, 1, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('5A34175E23A27019DA559A5D3B3A3491', '/pmkpi/propay/supervision/index', 'UNITS', '计算单位', 16, 0, 0, null, '', null, null, '', '', '', null, null, 1, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('AA0C56E96DEF89D225E502722FF8743A', '/pmkpi/propay/supervision/index', 'WFID', '流程id', 17, 0, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('3496DAF673697FFB9E0062A5722420E5', '/pmkpi/propay/supervision/index', 'XMZJ', '预算资金(万元)', 4, 1, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{style:''text-align:right''}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BCC6657E889C8F81E9111777D478E22E', '/pmkpi/propay/supervision/index', 'YJPRONAME', '一级项目名称', 15, 0, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('3B881788D1BCCA0365A0D1DABB515984', '/pmkpi/propay/supervision/index', 'ZBXS', '计算符号', 14, 0, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('FF93A52E4AAEFDA4B12BBD83718E5D4A', '/pmkpi/propay/supervision/index', 'ISPEREVAL', '是否事前评估', 20, 1, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CFF1E07B176424875C755124E0A13410', '/pmkpi/propay/supervision/index', 'WFSTUTAS', '流程状态', 19, 0, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CFF1E07BA7642C875C755124E0C13410', '/pmkpi/propay/supervision/index', 'WFSTATUSNAME', '流程状态', 19, 1, 0, null, '', null, null, '', '', '', null, null, 0, 'S', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9794546DE8FD1CC5957DCD877AB84521', '/pmkpi/propay/supervision/index', 'SINDEX', '一级指标', 5, 1, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');


delete from p#busfw_t_uiqueryform where key = '/pmkpi/propay/supervision/index';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('6B704435772CF13CE053D100A8C04522', '/pmkpi/propay/supervision/index', 'PRONAME', '项目名称', 2, 1, 's', '', null, null, 'pmkpi', 'V_PERF_T_SUPERVISIONVIEW', '{}', null);


--批量修改
delete from p#busfw_t_uieditform where key = '/pmkpi/supervision/multiUpdate';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('DAC99E6AA09F4092B7E621E973B4E083', '/pmkpi/supervision/multiUpdate', 'PERF_T_SUPERVISION', 'tree', '监审意见', 'ADJOPTION', 1, '', 0, '', 1, 1, '', 'pmkpi', 1, null, '{"format":"#name"}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B2C7B2E8D14B4E64AA1B610E361C6BC0', '/pmkpi/supervision/multiUpdate', 'PERF_T_SUPERVISION', 's', '其他意见', 'OPTIONS', 1, '', 0, '', 2, 1, '', 'pmkpi', 1, null, '{}', null, null, null);

delete from p#busfw_t_uifunction where key = '/pmkpi/supervision/multiUpdate';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('6F8B6BBAFBD944A49D005B9452F63B7D', '/pmkpi/supervision/multiUpdate', '确定', 1, 1, 'searchicon', 'supervisionUpdate.save', null, '确定', 'pmkpi', 'save', '', '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('64B6F7EE80CB4398AAD8F09C7849D3B5', '/pmkpi/supervision/multiUpdate', '取消', 1, 2, 'searchicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', 'closeModalWindow', '', '{}');
