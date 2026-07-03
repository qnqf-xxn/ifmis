begin
  --SELECT global_multyear_cz.Secu_f_GLOBAL_SetPARM('','340000000','2021','') FROM dual; 
--绩效自评整合-busui   
--1.绩效自评查询   
--1-1.展示列注册 
delete from p#Busfw_t_Uicolumn where key = '/pmkpi/perfself/query';
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0F2BE7D8713141F58367EE399DBD2F22', '/pmkpi/perfself/query', 'GUID', 'guid', 0, 0, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('ABEF0528549E40AB92B9F3DA53A9E3D5', '/pmkpi/perfself/query', 'WFSTATUS', '状态', 1, 1, 0, 0, null, 0, 6, null, '#name', null, null, 100, 1, 'tree', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0692F1785EFD47478E5C992C9A8ACABE', '/pmkpi/perfself/query', 'CODE', '部门编码', 2, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', '{isdept:1}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('09DF08825E3B4D60A2848441AD8B5B3F', '/pmkpi/perfself/query', 'NAME', '项目名称', 3, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', '{ispro:1}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('77FD9D72E6FF4E3591610D684B56E0D7', '/pmkpi/perfself/query', 'AGENCYGUID', '预算单位', 4, 1, 0, 0, null, 0, 6, null, '#name', null, null, 200, 1, 'tree', '{ispro:1}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('6D6D2DE14D93421DADE1947AB3DC5C1B', '/pmkpi/perfself/query', 'NAME', '部门名称', 5, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', '{isdept:1}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0AC6E8C79F094A44B73BA654CCCD2AF1', '/pmkpi/perfself/query', 'FININTORGGUID', '业务处室', 6, 1, 0, 0, null, 0, 6, null, '#name', null, null, 100, 1, 'tree', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C3F421BFB0C54D229C2287FEE5A00F78', '/pmkpi/perfself/query', 'BUDGETAMOUNT', '全年预算数', 7, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', '{ispro:1}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('A2CCE33173D6432EA1F127D94A046134', '/pmkpi/perfself/query', 'EXECRATENUM', '调整后预算数', 8, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1ACDD06A64E741D98CEDBD40A52E413E', '/pmkpi/perfself/query', 'EXECAMOUNT', '全年执行数', 9, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BB4894A330D3480A9BDBA7FB83086957', '/pmkpi/perfself/query', 'EXECRATE', '预算执行率', 10, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0B77A5405D12418FB66B8AD3500AEB02', '/pmkpi/perfself/query', 'SCORE', '得分', 11, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DC8371A80AFD4A52ACE3FE28BF14DB68', '/pmkpi/perfself/query', 'SELFRESULT', '自评结论', 12, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('432CEEBB0733401B819670A8FC561209', '/pmkpi/perfself/query', 'WARN', '自评预警', 13, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('F2A1374262CC458FB4906F21C88BB3CA', '/pmkpi/perfself/query', 'REMAININGDAYS', '截止天数', 14, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('F2A1374262CC458FB4906F21C88BB3CA', '/pmkpi/perfself/query', 'PRO_CODE', '项目编码', 15, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

--1-2.ui表注册
delete from p#busfw_t_uitable where key = '/pmkpi/perfself/query';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('D9CB1846C5F54DECB52C6EA582CD3986', '/pmkpi/perfself/query', 'V_PERF_V_SELFEVALTASK', 20, 0, 0, null, null, 'pmkpi', '{}');

--1-3.按钮注册（增加查看明细、查看项目）
delete from p#busfw_t_uifunction where key ='/pmkpi/perfself/query/index' and GUID in('C8162BCB85CF11FAE0533315A8C0819D','C8163FECE45112A1E0533315A8C0ACDB');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C8162BCB85CF11FAE0533315A8C0819D', '/pmkpi/perfself/query/index', '查看明细', 1, 5, 'searchicon', 'perfselfquery.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C8163FECE45112A1E0533315A8C0ACDB', '/pmkpi/perfself/query/index', '查看项目', 1, 6, null, 'perfselfquery.showProjView', null, '查看项目', 'pmkpi', 'showProjView', null, null);


--2.绩效自评审核
--2-1.页签注册
delete from p#busfw_t_uitabpage where key = '/pmkpi/perfself/audit';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('A413F308AE8B4BA097F39E769E2143C9', 'pmkpi', '/pmkpi/perfself/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'perfselfaudit.clickTabpage', null, '已审核', null, '审核', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('2FC387D05EF04635BE5FE816DC091BA6', 'pmkpi', '/pmkpi/perfself/audit', '曾经办', 'alldeals', 1, 3, 'nomal', 'perfselfaudit.clickTabpage', null, '曾经办', null, '审核,取消审核', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('A0F28592F09140409A956B692C8AA06B', 'pmkpi', '/pmkpi/perfself/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'perfselfaudit.clickTabpage', null, '待审核', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);

--2-2.按钮注册（增加查看明细、查看项目、隐藏审核信息按钮）
delete from p#busfw_t_uifunction where key = '/pmkpi/perfself/audit/index' and guid in('C8163FECE45212A1E0533315A8C0ACDB','C8163FECE45312A1E0533315A8C0ACDB','S4314B2E451149C08234D60BB31729FE');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C8163FECE45212A1E0533315A8C0ACDB', '/pmkpi/perfself/audit/index', '查看明细', 1, 4, 'searchicon', 'perfselfaudit.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C8163FECE45312A1E0533315A8C0ACDB', '/pmkpi/perfself/audit/index', '查看项目', 1, 5, null, 'perfselfaudit.showProjView', null, '查看项目', 'pmkpi', 'showProjView', null, null);
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('S4314B2E451149C08234D60BB31729FE', '/pmkpi/perfself/audit/index', '审核信息', 0, 7, 'searchicon', 'perfselfaudit.auditinfo', null, '审核信息', 'pmkpi', 'auditinfo', null, null);


--3.自评工作布置
--3-1.展示列注册
delete from p#Busfw_t_Uicolumn where key = '/pmkpi/perfself/taskmanage'; 
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('42C5B7D2F837492E8D9E359D65172BE2', '/pmkpi/perfself/taskmanage', 'PRO_CODE', '项目编码', 0, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{ispro:1}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('115B297F3F984A98A0178115943DDE8E', '/pmkpi/perfself/taskmanage', 'PRO_CODE', '部门编码', 1, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{isdept:1}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('7B5007224B5C41418D1E30C6972EB39F', '/pmkpi/perfself/taskmanage', 'NAME', '部门名称', 2, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', '{isdept:1}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('08AF794356DE45A496CC4E5D84D926DA', '/pmkpi/perfself/taskmanage', 'NAME', '项目名称', 3, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', '{ispro:1}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('EF0A5321A7C643C6BACC0B6C80039E06', '/pmkpi/perfself/taskmanage', 'AGENCYGUID', '预算单位', 4, 1, 0, 0, null, 0, 6, null, '#name', null, null, 200, 1, 'tree', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('EE9A1E2E76464480A9741EA59855918C', '/pmkpi/perfself/taskmanage', 'FININTORGGUID', '业务处室', 5, 1, 0, 0, null, 0, 6, null, '#name', null, null, 200, 1, 'tree', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('33406A2509654C62A003C4DE9FC4BE46', '/pmkpi/perfself/taskmanage', 'BUDGETAMOUNT', '全年预算数', 6, 0, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C89F77F069A62E90E0533315A8C0A9BE', '/pmkpi/perfself/taskmanage', 'EXECRATENUM', '调整后预算数', 7, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0D9F9AF47A1544A7840B79D4ECA82DD6', '/pmkpi/perfself/taskmanage', 'EXECAMOUNT', '全年执行数', 8, 0, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('89ABE20F736340F195264F9CF5720580', '/pmkpi/perfself/taskmanage', 'EXECRATE', '预算执行率', 9, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('A2D576F94193449DA7F652B8DCFE44D5', '/pmkpi/perfself/taskmanage', 'EVALSTART', '开始时间', 10, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DDF3DD3050564C61934176867E159BDC', '/pmkpi/perfself/taskmanage', 'EVALEND', '截止时间', 11, 1, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{}', null);

--3-2.ui表注册
delete from p#busfw_t_uitable where key = '/pmkpi/perfself/taskmanage';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('68D79B22EF8F4D8F9DCB51E51910A02F', '/pmkpi/perfself/taskmanage', 'V_PERF_V_SELFEVALPROGRAMS', 20, 0, 0, null, ' t.wfstatus=011 and exists(select 1 from pm_perf_goal_info gl where gl.mainguid=t.projguid and gl.yearflag=0)', 'pmkpi', '{}');

--3-3.页签注册
delete from p#busfw_t_uitabpage where key = '/pmkpi/perfself/taskmanage';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C7C157131290464FE0533315A8C0A90F', 'pmkpi', '/pmkpi/perfself/taskmanage', '已完成', 'alldeals', 1, 3, 'nomal', 'perfselfmanage.clickTabpage', null, '已完成', 't.evalstatus =2', '任务下达,取消下达', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C7C157131291464FE0533315A8C0A90F', 'pmkpi', '/pmkpi/perfself/taskmanage', '已下达', 'alldeals', 1, 2, 'nomal', 'perfselfmanage.clickTabpage', null, '已下达', 't.evalstatus =1', '任务下达', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C7C15713128F464FE0533315A8C0A90F', 'pmkpi', '/pmkpi/perfself/taskmanage', '未下达', 'create', 1, 1, 'choosed', 'perfselfmanage.clickTabpage', null, '未下达', 'not exists(select 1 from v_perf_t_selfevaltask d where t.pro_code = d.pro_code)', '取消下达', '{}', null, '0', null, null, null, null, null, null, null);

--3-4.按钮注册-查看项目
delete from p#busfw_t_uifunction where key = '/pmkpi/perfselftaskmanage/index' and guid = 'P741373EEFFA4A188E42D1B7621AC3CB';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('P741373EEFFA4A188E42D1B7621AC3CB', '/pmkpi/perfselftaskmanage/index', '查看项目', 1, 3, null, 'perfselfmanage.showProjView', null, '查看项目', 'pmkpi', 'showProjView', null, null);


--4.绩效自评填报 
--4-1.页签注册
delete from p#busfw_t_uitabpage where key = '/pmkpi/perfself/apply';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C7C15713129D464FE0533315A8C0A90F', 'pmkpi', '/pmkpi/perfself/apply', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'perfselfapply.clickTabpage', null, '已送审', null, '填报/修改,删除,送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C7C15713129E464FE0533315A8C0A90F', 'pmkpi', '/pmkpi/perfself/apply', '曾经办', 'alldeals', 1, 3, 'nomal', 'perfselfapply.clickTabpage', null, '曾经办', null, '填报/修改,删除,送审,取消送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C7C15713129F464FE0533315A8C0A90F', 'pmkpi', '/pmkpi/perfself/apply', '未送审', 'waitaudit', 1, 1, 'choosed', 'perfselfapply.clickTabpage', null, '未送审', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);

--4-2.按钮注册（增加查看明细、查看项目）
delete from p#busfw_t_uifunction where key = '/pmkpi/perfself/apply/index' and guid in('C8163FECE45512A1E0533315A8C0ACDB','C8163FECE45612A1E0533315A8C0ACDB');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C8163FECE45512A1E0533315A8C0ACDB', '/pmkpi/perfself/apply/index', '查看明细', 1, 6, 'searchicon', 'perfselfapply.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C8163FECE45612A1E0533315A8C0ACDB', '/pmkpi/perfself/apply/index', '查看项目', 1, 7, null, 'perfselfapply.showProjView', null, '查看项目', 'pmkpi', 'showProjView', null, null);

--5.填报页面-指标完成情况完成值必填
--5-1.项目指标完成情况-实际完成值必填
update p#Busfw_t_Uicolumn set REQUIREMENT = '1'  where key = '/pmkpi/perfself/apply/edit/selfindex' and COLUMNCODE = 'ACTUALVALUE';
--5-2.部门指标完成情况-实际完成值必填
update p#Busfw_t_Uicolumn set REQUIREMENT = '1'  where key = '/pmkpi/perfself/apply/editdept/selfindex' and COLUMNCODE = 'ACTUALVALUE';
