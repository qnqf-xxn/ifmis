begin

--1-财政评价菜单：项目支出-查看项目明细、查看评价成果 添加项目关联页签
--财政评价项目确定新增/修改按钮、财政评价项目审核-查看项目明细、财政评价项目查询-查看项目明细
delete from p#busfw_t_uitabpage where key = '/pmkpi/evaluation/finconfirm/proedit' and code = 'relation';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD2A3B90E53E3AC1E053B11FAPPP6F54', 'pmkpi', '/pmkpi/evaluation/finconfirm/proedit', '关联项目', 'relation', 0, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '关联项目', null, null, '{url:''/pmkpi/evaluation/finconfirm/prorelation.page''}', null, '0', 'relationiframe', null, null, null, null, null, null);
--预算部门自评-查看项目明细
delete from p#busfw_t_uitabpage where key = '/pmkpi/evaluation/financial/deptfill/proedit' and code = 'relation';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('DC6CDA3FCA99298EE0533315A8C0D61D', 'pmkpi', '/pmkpi/evaluation/financial/deptfill/proedit', '关联项目', 'relation', 0, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '关联项目', null, null, '{url:''/pmkpi/evaluation/finconfirm/prorelation.page?viewtype=query''}', null, '0', 'relationiframe', null, null, null, null, null, null);
--财政评价成果上传-查看评价成果、财政评价成果审核-查看评价成果、预算部门接收通知-查看项目成果、预算部门反馈意见-查看评价成果
delete from p#busfw_t_uitabpage where key = '/pmkpi/evaluation/financial/result/edit' and code = 'relation';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('DC6CDA3FCA9A298EE0533315A8C0D61D', 'pmkpi', '/pmkpi/evaluation/financial/result/edit', '关联项目', 'relation', 0, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '关联项目', null, null, '{url:''/pmkpi/evaluation/finconfirm/prorelation.page?viewtype=query''}', null, '0', 'relationiframe', null, null, null, null, null, null);

--2-财政评价关联项目-busui
--UI表注册
delete from p#busfw_t_uitable where key ='/pmkpi/evaluation/finconfirm/prorelation';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('D4D3D3E30FA1274CE0533315A8C0ACDD', '/pmkpi/evaluation/finconfirm/prorelation', 'V_PERF_T_FINEVARELATION', 100, 0, null, 'order by t.setup_year desc, t.agencyguid asc', null, 'pmkpi', '{}');
--展示列注册
delete from p#busfw_t_uicolumn where key ='/pmkpi/evaluation/finconfirm/prorelation';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DA61946DC9ED101EE0533315A8C0D73D', '/pmkpi/evaluation/finconfirm/prorelation', 'GUID', '主键', 0, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DB945A81696A5CA5E0533315A8C001F3', '/pmkpi/evaluation/finconfirm/prorelation', 'PROJECTKIND', '支出项目类别', 1, 1, 0, 0, null, 0, 1, null, '#code-#name', null, null, 150, 1, 'tree', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DB945A81696B5CA5E0533315A8C001F3', '/pmkpi/evaluation/finconfirm/prorelation', 'PRO_CODE', '项目编码', 2, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DB945A81696C5CA5E0533315A8C001F3', '/pmkpi/evaluation/finconfirm/prorelation', 'PRO_NAME', '项目名称', 3, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DB945A81696D5CA5E0533315A8C001F3', '/pmkpi/evaluation/finconfirm/prorelation', 'PRO_TOTAL_AMT', '项目总额（元）', 4, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DB945A81696E5CA5E0533315A8C001F3', '/pmkpi/evaluation/finconfirm/prorelation', 'AGENCYGUID', '预算单位', 5, 1, 0, 0, '0', 0, 1, null, '#code-#name', null, 0, 0, 1, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DB945A81696F5CA5E0533315A8C001F3', '/pmkpi/evaluation/finconfirm/prorelation', 'MANAGE_DEPT_CODE', '主管部门', 6, 1, 0, null, null, null, 1, null, '#code-#name', null, null, 170, 1, 'tree', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DB945A8169705CA5E0533315A8C001F3', '/pmkpi/evaluation/finconfirm/prorelation', 'MANAGE_MOF_DEP_CODE', '主管处室', 7, 1, 0, null, null, null, 1, null, '#code-#name', null, null, 180, 1, 'tree', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DB945A8169715CA5E0533315A8C001F3', '/pmkpi/evaluation/finconfirm/prorelation', 'SETUP_YEAR', '设立年度', 8, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DB945A8169725CA5E0533315A8C001F3', '/pmkpi/evaluation/finconfirm/prorelation', 'PRO_START_YEAR', '起始时间', 9, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DB945A8169735CA5E0533315A8C001F3', '/pmkpi/evaluation/finconfirm/prorelation', 'PRO_TERM', '项目期限', 10, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);
--按钮注册
delete from p#busfw_t_uifunction where key ='/pmkpi/evaluation/finconfirm/prorelation';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E36BCC274CE0533315A8C0ACDD', '/pmkpi/evaluation/finconfirm/prorelation', '选择关联项目', 1, 1, 'searchicon', 'pmkpifinprorelation.checkprogram', null, '选择关联项目', 'pmkpi', 'checkprogram', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E36BCD274CE0533315A8C0ACDD', '/pmkpi/evaluation/finconfirm/prorelation', '取消关联', 1, 2, 'searchicon', 'pmkpifinprorelation.del', null, '取消关联', 'pmkpi', 'del', null, '{}');
--查询区注册
delete from p#busfw_t_uiqueryform where key ='/pmkpi/evaluation/finconfirm/prorelation';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values ('D4D3D3E35BA3274CE0533315A8C0ACDD', '/pmkpi/evaluation/finconfirm/prorelation', 'PRO_NAME', '项目名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_FINEVARELATION', '{}', null, null);
-- insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
-- values ('D4D3D3E35BA4274CE0533315A8C0ACDD', '/pmkpi/evaluation/finconfirm/prorelation', 'AGENCY_CODE', '预算单位', 1, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_FINEVARELATION', '{format:''#code-name''}', null, null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values ('D4D3D3E35BA5274CE0533315A8C0ACDD', '/pmkpi/evaluation/finconfirm/prorelation', 'PRO_CODE', '项目编码', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_FINEVARELATION', '{}', null, null);

--3-财政评价关联项目-选择关联项目-busui
--UI表注册
delete from p#busfw_t_uitable where key = '/pmkpi/evaluation/finconfirm/prorelation/procheck';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('DC6CDA3FCA8C298EE0533315A8C0D61D', '/pmkpi/evaluation/finconfirm/prorelation/procheck', 'V_PERF_PROJECT_INFO', 100, 1, 0, 'order by t.setup_year desc, t.agencyguid asc', ' (PRO_CAT_CODE like ''22%'' or PRO_CAT_CODE like ''3%'') and pro_lev = ''2'' and not exists (select 1 from v_perf_t_finevarelation r where r.pro_code = t.pro_code) ', 'pmkpi', null);
--展示列注册
delete from p#busfw_t_uicolumn where key = '/pmkpi/evaluation/finconfirm/prorelation/procheck';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DC858495CAB071D1E0533315A8C0AF24', '/pmkpi/evaluation/finconfirm/prorelation/procheck', 'PROJECTKIND', '支出项目类别', 1, 1, 0, 0, null, 0, null, null, '#code-#name', null, null, 150, 1, 'tree', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DC858495CAB171D1E0533315A8C0AF24', '/pmkpi/evaluation/finconfirm/prorelation/procheck', 'PRO_CODE', '项目编码', 2, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DC858495CAB271D1E0533315A8C0AF24', '/pmkpi/evaluation/finconfirm/prorelation/procheck', 'PRO_NAME', '项目名称', 3, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DC858495CAB371D1E0533315A8C0AF24', '/pmkpi/evaluation/finconfirm/prorelation/procheck', 'PRO_TOTAL_AMT', '项目总额（元）', 4, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DC858495CAB471D1E0533315A8C0AF24', '/pmkpi/evaluation/finconfirm/prorelation/procheck', 'AGENCYGUID', '预算单位', 5, 1, 0, 0, '0', 0, 1, null, '#code-#name', null, 0, 0, 1, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DC858495CAB571D1E0533315A8C0AF24', '/pmkpi/evaluation/finconfirm/prorelation/procheck', 'MANAGE_DEPT_CODE', '主管部门', 6, 1, 0, null, null, null, 1, null, '#code-#name', null, null, 170, 1, 'tree', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DC858495CAB671D1E0533315A8C0AF24', '/pmkpi/evaluation/finconfirm/prorelation/procheck', 'MANAGE_MOF_DEP_CODE', '主管处室', 7, 1, 0, null, null, null, 1, null, '#code-#name', null, null, 180, 1, 'tree', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DC858495CAB771D1E0533315A8C0AF24', '/pmkpi/evaluation/finconfirm/prorelation/procheck', 'SETUP_YEAR', '设立年度', 8, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DC858495CAB871D1E0533315A8C0AF24', '/pmkpi/evaluation/finconfirm/prorelation/procheck', 'PRO_START_YEAR', '起始时间', 9, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DC858495CAB971D1E0533315A8C0AF24', '/pmkpi/evaluation/finconfirm/prorelation/procheck', 'PRO_TERM', '项目期限', 10, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DC858495CAAF71D1E0533315A8C0AF24', '/pmkpi/evaluation/finconfirm/prorelation/procheck', 'GUID', '主键', 0, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);
--按钮注册
delete from p#busfw_t_uifunction where key = '/pmkpi/evaluation/finconfirm/prorelation/procheck';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DC584D4C9C087BCBE0533315A8C07F77', '/pmkpi/evaluation/finconfirm/prorelation/procheck', '确定', 1, 1, 'Keepicon', 'finprorelationcheck.save', null, '确定', 'pmkpi', null, null, null);
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DC584D4C9C097BCBE0533315A8C07F77', '/pmkpi/evaluation/finconfirm/prorelation/procheck', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', null, null, null);
--查询区注册
--delete from p#busfw_t_uiqueryform where key = '/pmkpi/evaluation/finconfirm/prorelation/procheck';
-- insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
-- values ('DC6CDA3FCA97298EE0533315A8C0D61D', '/pmkpi/evaluation/finconfirm/prorelation/procheck', 'PRO_NAME', '项目名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFO', '{}', null, null);
-- insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
-- values ('DC6CDA3FCA98298EE0533315A8C0D61D', '/pmkpi/evaluation/finconfirm/prorelation/procheck', 'AGENCYGUID', '单位名称', 2, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFO', '{}', null, null);

--财政评价项目确定-新增、修改项目-基本信息-预算单位必填
update p#busfw_t_uieditform set requirement = 1 where key = '/pmkpi/evaluation/finconfirm/edit' and columncode in('AGENCYGUID');

