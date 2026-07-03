begin

delete from p#busfw_t_uitable t where t.key in('/pmkpi/deptperformance/report/index');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('F6D7BF7C823E4566994D3C9AC11D5238', '/pmkpi/deptperformance/report/index', 'V_PERF_T_DEPTPERFDECLARE', 0, 0, 0, '', '', 'pmkpi', '');

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/deptperformance/report/index');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0DFA2B36C7E348178F798AFC3F2991ED', '/pmkpi/deptperformance/report/index', 'CREATETIME', '创建人', 6, 0, 0, 0, '', 0, 6, '', '', '', null, 100, 0, 's', '', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('E41CC19ADBEC4C19B379ECE9C3926ADF', '/pmkpi/deptperformance/report/index', 'GUID', 'guid', 1, 0, 0, 0, '', 0, 6, '', '', '', null, null, 0, 's', '', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('203D2DE5FC2640659DAEDF61C84AA9CE', '/pmkpi/deptperformance/report/index', 'LINKMAN', '联系人', 4, 1, 0, 0, '', 0, 6, '', '', '', null, 100, 0, 's', '', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('5D0F2AE8E8F14D20B2680DC244360D7E', '/pmkpi/deptperformance/report/index', 'NAME', '名称', 3, 1, 0, 0, '', 0, 6, '', '', '', null, 200, 0, 's', '', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('4F945D56719A4732836B0D252049467A', '/pmkpi/deptperformance/report/index', 'TELEPHONE', '联系电话', 5, 1, 0, 0, '', 0, 6, '', '', '', null, 150, 0, 's', '', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('3542944054710b0edbbcea02fd20ac8b', '/pmkpi/deptperformance/report/index', 'WFSTATUS', '工作流状态', 2, 1, 0, 0, '', 0, 6, '', '#name', '', null, 80, 1, 'tree', '', '');

delete from p#busfw_t_uifunction t where key in('/pmkpi/deptperformance/report/index');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('3AC298FDEB0A4CC481BD82489EAE8E5A', '/pmkpi/deptperformance/report/index', '送审', 1, 4, 'searchicon', 'tabfreamlist.wfAudit', null, '送审', 'pmkpi', 'sendaudit', '', '{remark:true}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('556A55C748CC41859B28CFBFF7BE9A7B', '/pmkpi/deptperformance/report/index', '审核情况', 1, 6, 'searchicon', 'tabfreamlist.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', '', '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('93116150B8A34BCB8654E0F922FE8983', '/pmkpi/deptperformance/report/index', '取消送审', 1, 5, 'searchicon', 'tabfreamlist.wfAudit', null, '取消送审', 'pmkpi', 'cancelsendaudit', '', '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('15CE63D25473440689219988DC6F6C58', '/pmkpi/deptperformance/report/index', '查询', 1, 7, 'searchicon', 'tabfreamlist.query', null, '查询', 'pmkpi', 'query', '', '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('327161EF43A54320B7A216E47ED03C2E', '/pmkpi/deptperformance/report/index', '删除', 1, 3, 'searchicon', 'tabfreamlist.del', null, '删除', 'pmkpi', 'del', '', '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('6E8BA708BED14EC185CB4D94A295DC43', '/pmkpi/deptperformance/report/index', '填报/修改', 1, 2, 'searchicon', 'tabfreamlist.addOredit', null, '填报/修改', 'pmkpi', 'save', '', '{}');


delete from p#busfw_t_uiqueryform t where key in('/pmkpi/deptperformance/report/index');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('6D584E09BCCD41F7A5FFD98B0C0AC7E9', '/pmkpi/deptperformance/report/index', 'NAME', '名称', 1, 1, 's', '', null, null, 'pmkpi', 'V_PERF_T_DEPTPERFDECLARE', '', null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('1c3a8c221558c32b68a9d9c81bfad06c', '/pmkpi/deptperformance/report/index', 'WFSTATUS', '审核状态', 2, 1, 'tree', '', null, null, 'pmkpi', 'V_PERF_T_DEPTPERFDECLARE', '', null);

delete from p#busfw_t_uitabpage t where key in('/pmkpi/deptperformance/report/index');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('2B2B30B02D93405EBEFBAF9CEE879E47', 'pmkpi', '/pmkpi/deptperformance/report/index', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'tabfreamlist.clickTabpage', null, '已送审', '', '填报/修改,删除,送审', '{}', '', '0', '', '', '', '', '', '', '');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('CB4B8BC284E545E281404F19A9BD1335', 'pmkpi', '/pmkpi/deptperformance/report/index', '曾经办', 'alldeals', 1, 3, 'nomal', 'tabfreamlist.clickTabpage', null, '曾经办', '', '填报/修改,删除,送审,取消送审', '{}', '', '0', '', '', '', '', '', '', '');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('82C6CD4B7B79451A87DC622477C5C435', 'pmkpi', '/pmkpi/deptperformance/report/index', '待送审', 'waitaudit', 1, 1, 'choosed', 'tabfreamlist.clickTabpage', null, '待送审', '', '取消送审', '{}', '', '0', '', '', '', '', '', '', '');

delete from p#busfw_t_uieditform t where key in('/pmkpi/deptperformance/report/edit');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('e622e19ff98b47444d10c893b78975e8', '/pmkpi/deptperformance/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 's', '主键', 'GUID', 0, '', 0, '', 5, null, '', 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('79beace2f9ef6d03abacb81e0f87f5bd', '/pmkpi/deptperformance/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 's', '部门编号', 'CODE', 1, '', 1, '', 1, null, '', 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('57067c6345a3a3b972dd627a23774081', '/pmkpi/deptperformance/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 's', '部门名称', 'NAME', 1, '', 0, '', 2, null, '', 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('219ff73ff870eea8ecabed2f3952ad20', '/pmkpi/deptperformance/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 's', '联系人', 'LINKMAN', 1, '', 1, '', 3, null, '', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('110ca017fa06755393685baa83ba3655', '/pmkpi/deptperformance/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 's', '联系电话', 'TELEPHONE', 1, '', 0, '', 4, null, '', 'pmkpi', 1, null, '{}', null, null, null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/deptperformance/report/edit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('e16486c7792f5c2a84cc923256817aa9', '/pmkpi/deptperformance/report/edit', '保存', 1, 1, 'Keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', '', '', '');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('e00e52e9fa72be3a5ee9b4ca0864d373', '/pmkpi/deptperformance/report/edit', '取消', 1, 2, 'Nofinishicon', 'tabfreamedit.close', null, '取消', 'pmkpi', '', '', '');


delete from p#busfw_t_uitabpage t where key in('/pmkpi/deptperformance/report/edit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('2ADBD526B0124C559511C082DEFD306F', 'pmkpi', '/pmkpi/deptperformance/report/edit', '附件管理', 'file', 1, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '附件管理', null, '保存', '{url:''/pmkpi/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C641AA5E82A2482C82FAE97F00B51962', 'pmkpi', '/pmkpi/deptperformance/report/edit', '部门基本信息', 'deptinfo', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '部门基本信息', null, null, '{busguid:''C6CA191547FE416AB3C5694B2BCEA6E7''}', null, '0', 'formaleditform', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('67F400F6D1DF458095B6F0C0A40942E3', 'pmkpi', '/pmkpi/deptperformance/report/edit', '部门职能活动', 'deptfun', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '部门职能活动', null, null, '{url:''/pmkpi/deptperformance/report/funcd.page'',action:''deptfunc.save'',busguid:''15F7B8C868E54306A2FDE7CCC32726FC''}', null, '0', 'funciframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('072A10673CB144C4A171A85DD8BF6E6F', 'pmkpi', '/pmkpi/deptperformance/report/edit', '年度绩效目标', 'yearindex', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '年度绩效目标', null, null, '{url:''/pmkpi/deptperformance/report/perfindex.page'',action:''deptindex.save'',busguid:''4060E895AFB94626A13210D720A18E31''}', null, '0', 'indexiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('234AD87E066A4568A825C2DC753AABCF', 'pmkpi', '/pmkpi/deptperformance/report/edit', '考评一类指标', 'oneindex', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '考评一类指标', null, null, '{busguid:''022DDAA447DA4644ABD1E49811961F78''}', null, '0', 'auditindexdatatable', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D0E18D173E38461C9EA56BF9870D12D0', 'pmkpi', '/pmkpi/deptperformance/report/edit', '绩效指标情况表', 'indexsituation', 1, 6, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效指标情况表', null, '保存', '{reporttype:''word''}', null, '0', 'mancereport', null, null, null, null, null, null);


delete from p#busfw_t_uitable t where t.key in('/pmkpi/deptperformance/report/auditindex');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('4a697fa7ee001ef446db5e4764977849', '/pmkpi/deptperformance/report/auditindex', 'V_PERF_T_DEPTAUDITINDEX', 0, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/deptperformance/report/auditindex');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('7620cb9961b05f3e20978c6d076d5fbd', '/pmkpi/deptperformance/report/auditindex', 'EXPLAIN', '公示或说明', 3, 1, 1, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('ef363d21f466f1f92a31be15828e4f47', '/pmkpi/deptperformance/report/auditindex', 'GUID', '主键', 0, 0, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('5dd6940e0bdfdb116bce80865a2c362c', '/pmkpi/deptperformance/report/auditindex', 'INDEXVAL', '指标值', 4, 1, 1, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('a0fd3b07a59a264ea2a3e844a463063f', '/pmkpi/deptperformance/report/auditindex', 'NAME', '指标名称', 2, 1, 1, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('42161be458c9a28b3f0d86e9811b7dfc', '/pmkpi/deptperformance/report/auditindex', 'OBLIGATE2', '操作', 1, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('8b97ebe2f763e1d638bb5a918b11977b', '/pmkpi/deptperformance/report/auditindex', 'RULE', '赋分原则', 6, 1, 1, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('db8510443148d1e886f5787f0c898bad', '/pmkpi/deptperformance/report/auditindex', 'WEIGHT', '权重', 5, 1, 1, 1, null, 0, 6, null, null, null, null, null, 0, 'amt', null, null);

delete from p#busfw_t_uitable t where t.key in('/pmkpi/deptperformance/report/perfindex');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('E87BEB6E7A9E43EF80C804621F49FCA1', '/pmkpi/deptperformance/report/perfindex', 'V_BGT_PERF_INDICATOR', 0, 1, 0, '', '', 'pmkpi', '');

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/deptperformance/report/perfindex');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF38D1AA46AC4BA3B5A538F7557CD49D', '/pmkpi/deptperformance/report/perfindex', 'COMPUTESIGN', '计算符号', 9, 1, 1, 1, '', 0, null, '', '#name', '', null, 100, 1, 'tree', '', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B702F46ED33B46D9935D8BF777FC430A', '/pmkpi/deptperformance/report/perfindex', 'EXPLAIN', '公式或说明', 4, 1, 1, 0, '', 0, null, '', '', '', null, 280, 0, 's', '', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('769BB16DDF704A928C6F72AC9F9A6D23', '/pmkpi/deptperformance/report/perfindex', 'FINDEX', '一级指标', 22, 0, 0, 0, '', 0, null, '', '', '', null, 150, 0, 's', '', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('E6F657C3A2FB4378889CC4F8E9552CB1', '/pmkpi/deptperformance/report/perfindex', 'GUID', 'GUID', 25, 0, 0, 0, '', 0, null, '', '', '', null, 150, 0, 's', '', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('7B3F59ADEA6C45049EC952721531866E', '/pmkpi/deptperformance/report/perfindex', 'INDEXVAL', '指标值', 10, 1, 1, 0, '', 0, null, '', '', '', null, 150, 0, 's', '', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('FF8DC160AE5541C48092AD7963F0910A', '/pmkpi/deptperformance/report/perfindex', 'ISLINKED', '是否为与预算总额挂钩产出指标', 17, 1, 1, 0, '', 0, null, '', '#name', '', null, 120, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9DCFD26CF9C6498A96DD311837227500', '/pmkpi/deptperformance/report/perfindex', 'LEVELNO', '级次', 12, 0, 0, 0, '', 0, null, '', '', '', null, 150, 0, 's', '', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF38D1AA46AC4BA3B5A538F7557CD49D', '/pmkpi/deptperformance/report/perfindex', 'METERUNIT', '计量单位', 11, 1, 1, 1, '', 0, null, '', '', '', null, 100, 0, 's', '', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('889F9D8555F843CE885DC6855D469814', '/pmkpi/deptperformance/report/perfindex', 'NAME', '指标名称', 3, 1, 1, 0, '', 1, null, '', '', '', null, 280, 0, 's', '', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('6084AC2734C14AC696BD7572044502AE', '/pmkpi/deptperformance/report/perfindex', 'OBLIGATE1', '操作', 1, 0, 0, 0, '', 0, null, '', '', '', null, 80, 0, 's', '', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('27C7BAE71B1C4B35B1E3A28DB597C575', '/pmkpi/deptperformance/report/perfindex', 'OBLIGATE3', '操作', 2, 1, 0, 0, '', 0, null, '', '', '', null, 80, 0, 's', '', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('09ED2441FA764B0BB920A8C6F392F245', '/pmkpi/deptperformance/report/perfindex', 'RULE', '赋分原则', 18, 1, 1, 0, '', 0, 6, '', '', '', null, 180, 0, 's', '', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1AC4534F52D84FCC80CFF1B6C69DBE2A', '/pmkpi/deptperformance/report/perfindex', 'SINDEX', '二级指标', 23, 0, 0, 0, '', 0, null, '', '', '', null, 150, 0, 's', '', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CA1D390B4D79475D97213EFD5DED5779', '/pmkpi/deptperformance/report/perfindex', 'SUPERID', 'SUPERID', 26, 0, 0, 0, '', 0, null, '', '', '', null, 150, 0, 's', '', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF38D1AA46AC4BA3B5A538F7557CD49D', '/pmkpi/deptperformance/report/perfindex', 'WEIGHT', '权重', 16, 1, 1, 1, '', 0, null, '', '', '', null, 100, 0, 'amt', '', '');

delete from p#busfw_t_uitable t where t.key in('/pmkpi/deptperformance/report/funcd');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('90F1EE804D064750A2E6001FCD8F5663', '/pmkpi/deptperformance/report/funcd', 'V_PERF_T_DEPTFUNCTION', 0, 0, 0, '', '', 'pmkpi', '');

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/deptperformance/report/funcd');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD57D724EFB8460180DC2C2D22D45DEF', '/pmkpi/deptperformance/report/funcd', 'GUID', 'guid', 0, 0, 0, 0, '', 0, null, '', '', '', null, null, 0, 's', '', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('7380C66BB36146BAA5A192306526D529', '/pmkpi/deptperformance/report/funcd', 'NAME', '部门职能', 2, 1, 1, 0, '', 0, null, '', '', '', null, 300, 0, 's', '', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B13D047C52F848FDAEA54F5B9D9E2A9B', '/pmkpi/deptperformance/report/funcd', 'OBLIGATE', '操作', 1, 0, 0, 0, '', 0, null, '', '', '', null, 100, 0, 's', '', '');

delete from p#busfw_t_uitable t where t.key in('/pmkpi/deptperformance/report/indexcheck');

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('86743d61d7a73224dbb45a95b547499e', '/pmkpi/deptperformance/report/indexcheck', 'V_BAS_PERF_INDICATOR', 0, 0, 0, '', '', 'pmkpi', '');

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/deptperformance/report/indexcheck');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('ad95910d71e5b0f7a1f9f6e7bcf79677', '/pmkpi/deptperformance/report/indexcheck', 'COMPUTESIGN', '计算符号', 4, 1, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9d54837dec84227639027adcd8e53e6d', '/pmkpi/deptperformance/report/indexcheck', 'FINDEX', '一级指标', 1, 1, 0, null, '', 1, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('fee16710952f1233a8e5f2f123cd65aa', '/pmkpi/deptperformance/report/indexcheck', 'INDEXVALUE', '指标值', 5, 1, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('cc75c61ab8ba634344d06618523efb9d', '/pmkpi/deptperformance/report/indexcheck', 'METERUNIT', '计量单位', 6, 1, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('a9b82db2fb6cfa5955800ec9793e6cf5', '/pmkpi/deptperformance/report/indexcheck', 'NAME', '三级指标', 3, 1, 0, 0, '', 1, null, '', '', '', null, 220, 0, 's', '', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('32ad7edc60ad960ab7d3a72c3029ef5d', '/pmkpi/deptperformance/report/indexcheck', 'SINDEX', '二级指标', 2, 1, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

delete from p#busfw_t_uifunction t where key in('/pmkpi/deptperformance/report/indexcheck');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('a3577aefaca09c327356c76ba0e4904c', '/pmkpi/deptperformance/report/indexcheck', '保存', 1, 1, 'Keepicon', 'deptcheckindex.infosave', null, '保存', 'pmkpi', 'infosave', '', '');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('8cc848a2a666d1b88a6a6774cc605944', '/pmkpi/deptperformance/report/indexcheck', '取消', 1, 2, '', 'deptcheckindex.close', null, '取消', 'pmkpi', '', '', '{}');








delete from p#busfw_t_uitable t where t.key in('/pmkpi/deptperformance/audit/index');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('dfdcff7774374f051cec79914cd71ee8', '/pmkpi/deptperformance/audit/index', 'PERF_T_DEPTPERFDECLARE', 0, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/deptperformance/audit/index');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('c362cf46dd50dc2a9f399c2f620c00d8', '/pmkpi/deptperformance/audit/index', 'CREATETIME', '创建人', 6, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('b8f81f05aa2315c6ab147af1ae0f0e2a', '/pmkpi/deptperformance/audit/index', 'GUID', 'guid', 1, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('53d284217655aada1cfe9ea7e60fd33d', '/pmkpi/deptperformance/audit/index', 'LINKMAN', '联系人', 4, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('df3cc90e69fcb42bb3f4c96643604818', '/pmkpi/deptperformance/audit/index', 'NAME', '名称', 3, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('565395d9288ea72b1bacbc43c70280f5', '/pmkpi/deptperformance/audit/index', 'TELEPHONE', '联系电话', 5, 1, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('62039e117bbfd40e0ffb3ac4589fee79', '/pmkpi/deptperformance/audit/index', 'WFSTATUS', '工作流状态', 2, 1, 0, 0, null, 0, 6, null, '#name', null, null, 100, 1, 's', null, null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/deptperformance/audit/index');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('54314B2E451149C08234D60BB31729FE', '/pmkpi/deptperformance/audit/index', '审核信息', 1, 7, 'searchicon', 'deptperformanceaudit.auditinfo', null, '审核信息', 'pmkpi', 'auditinfo', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('8a21325a98ed6a0903d27fcdca051225', '/pmkpi/deptperformance/audit/index', '审核', 1, 1, null, 'deptperformanceaudit.audit', null, '审核', 'pmkpi', 'audit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('623b7993be58e07c00008dd2194b6ab2', '/pmkpi/deptperformance/audit/index', '取消审核', 1, 2, null, 'deptperformanceaudit.wfAudit', null, '取消审核', 'pmkpi', 'cancelaudit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('e9bbc1539c1d2268c7b4e902850a321d', '/pmkpi/deptperformance/audit/index', '查询', 1, 3, 'searchicon', 'deptperformanceaudit.query', null, '查询', 'pmkpi', 'query', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('0BC3AF828F8C4DE5AE5FB0C363AE182F', '/pmkpi/deptperformance/audit/index', '审核情况', 1, 6, 'searchicon', 'deptperformanceaudit.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, null);

delete from p#busfw_t_uiqueryform t where key in('/pmkpi/deptperformance/audit/index');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('0a3e4e8f748a9a38cb3ab913f4a6b343', '/pmkpi/deptperformance/audit/index', 'NAME', '名称', 1, 1, 's', null, null, null, 'pmkpi', 'busfw_t_uitable', null, null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('2c56894afe04bf1e6724d5a4aed468ea', '/pmkpi/deptperformance/audit/index', 'WFSTATUS', '审核状态', 2, 1, 'tree', '', null, null, 'pmkpi', 'PERF_T_DEPTPERFDECLARE', '', null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/audit/view');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('010BAFBB4D144F28BF585B0DFB45F40F', '/pmkpi/audit/view', '保存', 1, 1, 'searchicon', 'audit.save', null, '保存', 'pmkpi', 'save', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('E67BB9CC36694A9D9EE866052281F66D', '/pmkpi/audit/view', '审核', 1, 2, 'searchicon', 'audit.audit', null, '审核', 'pmkpi', 'audit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('00A96B3C2C504C4484EA597B7066E9EB', '/pmkpi/audit/view', '退回', 1, 3, 'searchicon', 'audit.back', null, '退回', 'pmkpi', 'back', null, '{remark:true}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('16C5C2AE33C34262B2ABE02BD08515DB', '/pmkpi/audit/view', '取消', 1, 4, 'searchicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', 'cancle', null, null);

delete from p#busfw_t_uieditform t where key in('/pmkpi/audit/index/normal');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('DB09C667716842028CCEE950368ABECE', '/pmkpi/audit/index/normal', 'PERF_T_AUDITMAIN', 'textarea', '审核意见', 'REMARK', 1, null, 0, null, 1, 2, '6', 'pmkpi', 1, null, '{}', 0, 0, 0);
delete from p#busfw_t_uitable t where t.key in('/pmkpi/deptperformance/query/index');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('73ed88cb2336faa45d28e461fe08a92b', '/pmkpi/deptperformance/query/index', 'PERF_T_DEPTPERFDECLARE', 0, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/deptperformance/query/index');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('777ea47772563f22dae0be608599de99', '/pmkpi/deptperformance/query/index', 'CREATETIME', '创建人', 6, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('b264777f47d6e0ec15498f822d5e45f1', '/pmkpi/deptperformance/query/index', 'GUID', 'guid', 1, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9838c90d486fc0b952d9483150876e92', '/pmkpi/deptperformance/query/index', 'LINKMAN', '联系人', 4, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('a34170572c9b86709d6a046a11a54a11', '/pmkpi/deptperformance/query/index', 'NAME', '名称', 3, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('fdb53f3f3d91daeefefad207a2276fc8', '/pmkpi/deptperformance/query/index', 'TELEPHONE', '联系电话', 5, 1, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('62039e117bbfd40e0ffb3ac4589fee79', '/pmkpi/deptperformance/query/index', 'WFSTATUS', '工作流状态', 2, 1, 0, 0, null, 0, 6, null, '#name', null, null, 100, 1, 's', null, null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/deptperformance/query/index');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('7c5abea7bb9bccdc81aeb72003f50d43', '/pmkpi/deptperformance/query/index', '查询', 1, 1, 'searchicon', 'deptperformancequery.query', null, '查询', 'pmkpi', 'query', null, null);
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('76670196587bbe41001c86ec9d477950', '/pmkpi/deptperformance/query/index', '审核情况', 1, 2, 'searchicon', 'deptperformancequery.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', '', '');

delete from p#busfw_t_uiqueryform t where key in('/pmkpi/deptperformance/query/index');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('59dc6dd2c395b7a58c7c6ca19c2d7ac3', '/pmkpi/deptperformance/query/index', 'NAME', '名称', 1, 1, 's', null, null, null, 'pmkpi', 'busfw_t_uitable', null, null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('9ad8df216310a868959460148791613e', '/pmkpi/deptperformance/query/index', 'WFSTATUS', '审核状态', 2, 1, 'tree', '', null, null, 'pmkpi', 'PERF_T_DEPTPERFDECLARE', '', null);

delete from p#busfw_t_uieditform t where key in('/pmkpi/deptperformance/report/addperfindex');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B94B52B29465496CB521EDE77102F43B', '/pmkpi/deptperformance/report/addperfindex', 'BGT_PERF_INDICATOR', 's', '主键', 'GUID', 0, '', 0, '', 1, null, '', 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BAABCFA93F594407A61C462552A243C0', '/pmkpi/deptperformance/report/addperfindex', 'BGT_PERF_INDICATOR', 's', '指标名称', 'NAME', 1, '', 1, '', 2, null, '', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('03E53B6DFAE64195958C74DCE51CAF37', '/pmkpi/deptperformance/report/addperfindex', 'BGT_PERF_INDICATOR', 'tree', '计算符号', 'COMPUTESIGN', 1, '', 1, '', 3, null, '', 'pmkpi', 1, null, '{format:''#name''}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('7520B1EA715044E69FB695D0633AFEB0', '/pmkpi/deptperformance/report/addperfindex', 'BGT_PERF_INDICATOR', 's', '指标值', 'INDEXVAL', 1, '', 0, '', 4, null, '', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('11AC64AF7B1949F7B8B6921CB59F28F8', '/pmkpi/deptperformance/report/addperfindex', 'BGT_PERF_INDICATOR', 's', '计量单位', 'METERUNIT', 1, '', 1, '', 5, null, '', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('AB8C0E6A647A4815BA45180B353736DF', '/pmkpi/deptperformance/report/addperfindex', 'BGT_PERF_INDICATOR', 's', '层次分类', 'SINDEX', 1, '', 0, '', 6, null, '', 'pmkpi', 0, null, '{}', null, null, null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/deptperformance/report/addperfindex');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD692ECE6A504364B1CBA7AD81D165A6', '/pmkpi/deptperformance/report/addperfindex', '保存', 1, 1, 'Keepicon', 'deptaddindex.save', null, '保存', 'pmkpi', '', '', '');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('286F474B474E4D719D8945E0198AD110', '/pmkpi/deptperformance/report/addperfindex', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', '', '', '');

delete from p#busfw_t_uitabpage t where key in('/pmkpi/deptperformance/audit/index');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('a59e8259527ead79e03b6e5d10689458', 'pmkpi', '/pmkpi/deptperformance/audit/index', '曾经办', 'alldeals', 1, 3, 'nomal', 'deptperformanceaudit.clickTabpage', null, '曾经办', '', '审核,取消审核', '{}', '', '0', '', '', '', '', '', '', '');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('7a87cd283f74364537db556a2923b794', 'pmkpi', '/pmkpi/deptperformance/audit/index', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'deptperformanceaudit.clickTabpage', null, '已审核', '', '审核', '{}', '', '0', '', '', '', '', '', '', '');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('7b7720915e55c73f4ba720caab5d5ab6', 'pmkpi', '/pmkpi/deptperformance/audit/index', '待审核', 'waitaudit', 1, 1, 'choosed', 'deptperformanceaudit.clickTabpage', null, '待审核', '', '取消审核,审核信息', '{}', '', '0', '', '', '', '', '', '', '');



delete from p#busfw_t_uitable t where t.key in('/pmkpi/auditnode/index');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('FB305D2161BD43199F1F27720C2DC9E7', '/pmkpi/auditnode/index', 'PERF_T_AUDITTYPECFG', 0, 0, 0, '', '', 'pmkpi', '{}');

delete from p#busfw_t_uifunction t where key in('/pmkpi/auditnode/index');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('7A1F241260EC4071BAFDBC95000DFF4B', '/pmkpi/auditnode/index', '保存', 1, 2, 'searchicon', 'auditnode.tablesave', null, '保存', 'pmkpi', 'tablesave', '', '{}');

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/auditnode/index');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('AF5D019628AB43A188FE4913349A9117', '/pmkpi/auditnode/index', 'AUDITTYPE', '审核类型', 3, 1, 1, null, '', 1, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B74D471ABEDB4CE1857AF039AE280555', '/pmkpi/auditnode/index', 'NAME', '节点名称', 2, 1, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('AC71B1731ED94679B039C738A5C8A4CA', '/pmkpi/auditnode/index', 'ORDERNO', '节点编码', 1, 1, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

delete from p#busfw_t_uitable t where t.key in('/pmkpi/naturesaudit/index');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('EC42E268C6044F528B16052224194EFA', '/pmkpi/naturesaudit/index', 'PERF_T_NATRUEAUDITTEMP', 0, 0, 0, '', '', 'pmkpi', '');

delete from p#busfw_t_uifunction t where key in('/pmkpi/naturesaudit/index');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('443716B8700F430BA9D1BDF65CAB8778', '/pmkpi/naturesaudit/index', '保存', 1, 2, 'searchicon', 'naturesaudit.tablesave', null, '保存', 'pmkpi', 'tablesave', '', '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('4C407E74DCFC426A90F25F36428411D2', '/pmkpi/naturesaudit/index', '查询', 0, 1, 'searchicon', 'naturesaudit.query', null, '查询', 'pmkpi', 'query', '', '{}');

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/naturesaudit/index');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('3878CD890F5E49A0B0C8DD7D38B13583', '/pmkpi/naturesaudit/index', 'CONTEXT', '内容', 2, 1, 1, 0, '', 1, null, '', '', '', null, 500, 0, 's', '', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('77C3C9C6C8BB48EB92A0C34B3D762F91', '/pmkpi/naturesaudit/index', 'NAME', '名称', 1, 1, 1, 0, '', 1, null, '', '', '', null, 220, 0, 's', '', '');

delete from p#busfw_t_uitable t where t.key in('/pmkpi/audit/index/nature');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('70C5DFD8212D42D384C8A81717F091C4', '/pmkpi/audit/index/nature', 'PERF_T_AUDITITEMS', 0, 0, 0, '', '', 'pmkpi', '{}');

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/audit/index/nature');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('14A31ED7D76B49D887384D5E25E5B4C7', '/pmkpi/audit/index/nature', 'CONTEXT', '审核内容明细', 2, 1, 0, 0, '', 1, null, '', '', '', null, 300, 0, 's', '', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('8219275AF74B42EDA27020F600251E11', '/pmkpi/audit/index/nature', 'NAME', '审核内容', 1, 1, 0, 0, '', 1, null, '', '', '', null, 220, 0, 's', '', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('8B74EAB910434C86AD9A33391FFF1AF9', '/pmkpi/audit/index/nature', 'PROPOSAL', '审核建议', 3, 1, 1, 0, '', 1, null, '', '', '', null, 300, 0, 's', '', '');

delete from p#busfw_t_uieditform t where key in('/pmkpi/audit/index/opinion');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('411B78CE93BB4FF8B80EBA7790D3D1D2', '/pmkpi/audit/index/opinion', 'PERF_T_AUDITMAIN', 'textarea', '审核意见', 'REMARK', 1, '', 0, '', 1, 2, '6', 'pmkpi', 1, null, '{}', 0, 0, 0);

