begin

delete from busfw_t_uitabpage t where t.key in('/pmkpi/deptperformance/report/edit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C641AA5E82A2482C82FAE97F00B51962', 'pmkpi', '/pmkpi/deptperformance/report/edit', '部门基本信息', 'deptinfo', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '部门基本信息', null, null, '{busguid:''C6CA191547FE416AB3C5694B2BCEA6E7''}', null, '0', 'formaleditform', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('74A652FB74804776B8045BBE186B74D5', 'pmkpi', '/pmkpi/deptperformance/report/edit', '主要任务', 'depttask', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '主要任务', null, null, '{busguid:''BB27AE971C71426EA4691F989CE61504''}', null, '0', 'perftaskdatatable', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('AA1CB9CAD6784E7F80E29057B9399D9C', 'pmkpi', '/pmkpi/deptperformance/report/edit', '绩效目标', 'deptgoal', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效目标', null, null, '{busguid:''6584F846CE6D4CB8BF105577F0DC4C8C''}', null, '0', 'deptgoaleditform', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('072A10673CB144C4A171A85DD8BF6E6F', 'pmkpi', '/pmkpi/deptperformance/report/edit', '年度绩效指标', 'yearindex', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '年度绩效指标', null, null, '{url:''/pmkpi/deptperformance/report/perfindex.page'',action:''deptindex.save'',busguid:''4060E895AFB94626A13210D720A18E31''}', null, '0', 'indexiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('2ADBD526B0124C559511C082DEFD306F', 'pmkpi', '/pmkpi/deptperformance/report/edit', '附件管理', 'file', 1, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '附件管理', null, '保存', '{url:''/pmkpi/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('4CCF04B44A0D46638095CF709ADE94A1', 'pmkpi', '/pmkpi/deptperformance/report/edit', '整体绩效目标', 'depttarget', 0, 7, 'nomal', 'tabfreamedit.clickTabpage', null, '整体绩效目标', null, null, '{busguid:''E0902146244E4BB8B33B3225FF34604C''}', null, '0', 'targetdatatable', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('9C01A08F9FD648158ABDF5D0CB32B01D', 'pmkpi', '/pmkpi/deptperformance/report/edit', '年度绩效指标', 'deptindex', 0, 8, 'nomal', 'tabfreamedit.clickTabpage', null, '年度绩效指标', null, null, '{url:''/pmkpi/deptperformance/report/hnindex.page'',action:''depthnindex.save'',busguid:''75BBE7B861194B809EA57D2EC61256A9''}', null, '0', 'hnindexiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('67F400F6D1DF458095B6F0C0A40942E3', 'pmkpi', '/pmkpi/deptperformance/report/edit', '部门职能活动', 'deptfun', 0, 11, 'nomal', 'tabfreamedit.clickTabpage', null, '部门职能活动', null, null, '{url:''/pmkpi/deptperformance/report/funcd.page'',action:''deptfunc.save'',busguid:''15F7B8C868E54306A2FDE7CCC32726FC''}', null, '0', 'funciframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('234AD87E066A4568A825C2DC753AABCF', 'pmkpi', '/pmkpi/deptperformance/report/edit', '考评一类指标', 'oneindex', 0, 12, 'nomal', 'tabfreamedit.clickTabpage', null, '考评一类指标', null, null, '{busguid:''022DDAA447DA4644ABD1E49811961F78''}', null, '0', 'auditindexdatatable', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D0E18D173E38461C9EA56BF9870D12D0', 'pmkpi', '/pmkpi/deptperformance/report/edit', '绩效指标情况表', 'indexsituation', 0, 13, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效指标情况表', null, '保存', '{reporttype:''word''}', null, '0', 'mancereport', null, null, null, null, null, null);


--指标
delete from busfw_t_uitable t where key in('/pmkpi/deptperformance/report/perfindex');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('E87BEB6E7A9E43EF80C804621F49FCA1', '/pmkpi/deptperformance/report/perfindex', 'V_BGT_PERF_INDICATOR', 0, 1, 0, null, null, 'pmkpi', null);

delete from busfw_t_uicolumn t where key in('/pmkpi/deptperformance/report/perfindex');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('6084AC2734C14AC696BD7572044502AE', '/pmkpi/deptperformance/report/perfindex', 'OBLIGATE1', '操作', 1, 1, 0, 0, null, 0, null, null, null, null, null, 50, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('27C7BAE71B1C4B35B1E3A28DB597C575', '/pmkpi/deptperformance/report/perfindex', 'OBLIGATE3', '操作', 2, 0, 0, 0, null, 0, null, null, null, null, null, 50, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('889F9D8555F843CE885DC6855D469814', '/pmkpi/deptperformance/report/perfindex', 'NAME', '指标名称', 3, 1, 1, 0, null, 1, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B702F46ED33B46D9935D8BF777FC430A', '/pmkpi/deptperformance/report/perfindex', 'EXPLAIN', '公式或说明', 4, 0, 0, 0, null, 0, null, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF38D1AA46AC4BA3B5A538F7557CD49D', '/pmkpi/deptperformance/report/perfindex', 'COMPUTESIGN', '计算符号', 9, 1, 1, 1, null, 1, null, null, '#name', null, null, 100, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('7B3F59ADEA6C45049EC952721531866E', '/pmkpi/deptperformance/report/perfindex', 'INDEXVAL', '指标值', 10, 1, 1, 0, null, 1, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF38D1AA46AC4BA3B5A538F7557CD49D', '/pmkpi/deptperformance/report/perfindex', 'METERUNIT', '计量单位', 11, 1, 1, 1, null, 0, null, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9DCFD26CF9C6498A96DD311837227500', '/pmkpi/deptperformance/report/perfindex', 'LEVELNO', '级次', 12, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF38D1AA46AC4BA3B5A538F7557CD49D', '/pmkpi/deptperformance/report/perfindex', 'WEIGHT', '权重', 16, 0, 0, 1, null, 0, null, null, null, null, null, 100, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('FF8DC160AE5541C48092AD7963F0910A', '/pmkpi/deptperformance/report/perfindex', 'ISLINKED', '是否为与预算总额挂钩产出指标', 17, 0, 0, 0, null, 0, null, null, '#name', null, null, 120, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('09ED2441FA764B0BB920A8C6F392F245', '/pmkpi/deptperformance/report/perfindex', 'RULE', '赋分原则', 18, 0, 0, 0, null, 0, 6, null, null, null, null, 180, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA05A5D75D263E5BE053B11FA8C0B8FC', '/pmkpi/deptperformance/report/perfindex', 'KPI_REMARK', '目标值说明', 19, 1, 1, 0, null, 0, null, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('769BB16DDF704A928C6F72AC9F9A6D23', '/pmkpi/deptperformance/report/perfindex', 'FINDEX', '一级指标', 22, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1AC4534F52D84FCC80CFF1B6C69DBE2A', '/pmkpi/deptperformance/report/perfindex', 'SINDEX', '二级指标', 23, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('E6F657C3A2FB4378889CC4F8E9552CB1', '/pmkpi/deptperformance/report/perfindex', 'GUID', 'GUID', 25, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CA1D390B4D79475D97213EFD5DED5779', '/pmkpi/deptperformance/report/perfindex', 'SUPERID', 'SUPERID', 26, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B412538AB50962E3E0535164A8C0C98B', '/pmkpi/deptperformance/report/perfindex', 'KPI_CONTENT', '指标内容', 27, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B412538AB50A62E3E0535164A8C0C98B', '/pmkpi/deptperformance/report/perfindex', 'KPI_EVALSTD', '扣分标准', 28, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

delete from busfw_t_uifunction t where key in('/pmkpi/deptperformance/report/perfindex');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BA05A5D75CB13E5BE053B11FA8C0B8FC', '/pmkpi/deptperformance/report/perfindex', '精准推荐', 0, 1, 'keepicon', 'deptindex.recom', null, '精准推荐', 'pmkpi', 'recom', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BA05A5D75CB03E5BE053B11FA8C0B8FC', '/pmkpi/deptperformance/report/perfindex', '新增指标', 1, 2, 'keepicon', 'deptindex.add', null, '新增指标', 'pmkpi', 'add', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BA05A5D75CAF3E5BE053B11FA8C0B8FC', '/pmkpi/deptperformance/report/perfindex', '修改指标', 1, 3, 'keepicon', 'deptindex.mod', null, '修改指标', 'pmkpi', 'mod', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BA05A5D75CAE3E5BE053B11FA8C0B8FC', '/pmkpi/deptperformance/report/perfindex', '删除指标', 1, 4, 'keepicon', 'deptindex.del', null, '删除指标', 'pmkpi', 'del', null, null);

delete from busfw_t_uifunction t where key in('/pmkpi/deptperformance/report/editindex');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BA05A5D75CEA3E5BE053B11FA8C0B8FC', '/pmkpi/deptperformance/report/editindex', '保存', 1, 1, 'Keepicon', 'pmkpieditindex.save', null, '保存', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BA05A5D75CEB3E5BE053B11FA8C0B8FC', '/pmkpi/deptperformance/report/editindex', '取消', 1, 2, 'Nofinishicon', 'pmkpieditindex.close', null, '取消', 'pmkpi', null, null, null);

delete from busfw_t_uieditform t where key in('/pmkpi/deptperformance/report/editindex');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA05A5D75D0C3E5BE053B11FA8C0B8FC', '/pmkpi/deptperformance/report/editindex', 'V_BGT_PERF_INDICATOR', 's', '主键', 'GUID', 0, null, 0, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA05A5D75D0B3E5BE053B11FA8C0B8FC', '/pmkpi/deptperformance/report/editindex', 'V_BGT_PERF_INDICATOR', 's', '指标名称', 'NAME', 1, null, 1, null, 2, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA05A5D75D0A3E5BE053B11FA8C0B8FC', '/pmkpi/deptperformance/report/editindex', 'V_BGT_PERF_INDICATOR', 'tree', '计算符号', 'COMPUTESIGN', 1, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{format:''#name''}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA05A5D75D093E5BE053B11FA8C0B8FC', '/pmkpi/deptperformance/report/editindex', 'V_BGT_PERF_INDICATOR', 's', '指标值', 'INDEXVAL', 1, null, 1, null, 4, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA05A5D75D083E5BE053B11FA8C0B8FC', '/pmkpi/deptperformance/report/editindex', 'V_BGT_PERF_INDICATOR', 's', '计量单位', 'METERUNIT', 1, null, 1, null, 5, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA05A5D75D0D3E5BE053B11FA8C0B8FC', '/pmkpi/deptperformance/report/editindex', 'V_BGT_PERF_INDICATOR', 'textarea', '目标值说明', 'KPI_REMARK', 1, null, 0, null, 6, 3, '2', 'pmkpi', 1, null, '{}', 0, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA05A5D75D0E3E5BE053B11FA8C0B8FC', '/pmkpi/deptperformance/report/editindex', 'V_BGT_PERF_INDICATOR', 's', '主建', 'KPI_ID', 0, null, 0, null, 20, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA05A5D75D0F3E5BE053B11FA8C0B8FC', '/pmkpi/deptperformance/report/editindex', 'V_BGT_PERF_INDICATOR', 's', '区划', 'MOF_DIV_CODE', 0, null, 0, null, 21, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA05A5D75D103E5BE053B11FA8C0B8FC', '/pmkpi/deptperformance/report/editindex', 'V_BGT_PERF_INDICATOR', 's', '年度', 'FISCAL_YEAR', 0, null, 0, null, 22, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA05A5D75D113E5BE053B11FA8C0B8FC', '/pmkpi/deptperformance/report/editindex', 'V_BGT_PERF_INDICATOR', 's', '项目编码', 'PRO_CODE', 0, null, 0, null, 23, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA05A5D75D123E5BE053B11FA8C0B8FC', '/pmkpi/deptperformance/report/editindex', 'V_BGT_PERF_INDICATOR', 's', '一级指标', 'KPI_LV1', 0, null, 0, null, 24, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA05A5D75D133E5BE053B11FA8C0B8FC', '/pmkpi/deptperformance/report/editindex', 'V_BGT_PERF_INDICATOR', 's', '二级指标', 'KPI_LV2', 0, null, 0, null, 25, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA05A5D75D143E5BE053B11FA8C0B8FC', '/pmkpi/deptperformance/report/editindex', 'V_BGT_PERF_INDICATOR', 's', '三级指标', 'KPI_LV3', 0, null, 0, null, 30, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA05A5D75D173E5BE053B11FA8C0B8FC', '/pmkpi/deptperformance/report/editindex', 'V_BGT_PERF_INDICATOR', 's', '指标值', 'KPI_VAL', 0, null, 0, null, 32, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA05A5D75D153E5BE053B11FA8C0B8FC', '/pmkpi/deptperformance/report/editindex', 'V_BGT_PERF_INDICATOR', 'textarea', '指标内容', 'KPI_CONTENT', 0, null, 0, '1', 32, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA05A5D75D163E5BE053B11FA8C0B8FC', '/pmkpi/deptperformance/report/editindex', 'V_BGT_PERF_INDICATOR', 's', '评（扣）分标准', 'KPI_EVALSTD', 0, null, 0, '1', 33, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA05A5D75D1D3E5BE053B11FA8C0B8FC', '/pmkpi/deptperformance/report/editindex', 'V_BGT_PERF_INDICATOR', 's', '是否删除', 'IS_DELETED', 0, null, 0, '2', 41, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA05A5D75D1C3E5BE053B11FA8C0B8FC', '/pmkpi/deptperformance/report/editindex', 'V_BGT_PERF_INDICATOR', 's', '更新时间', 'UPDATE_TIME', 0, null, 0, null, 42, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA05A5D75D203E5BE053B11FA8C0B8FC', '/pmkpi/deptperformance/report/editindex', 'V_BGT_PERF_INDICATOR', 's', '一级指标', 'FINDEX', 0, null, 0, null, 44, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA05A5D75D1F3E5BE053B11FA8C0B8FC', '/pmkpi/deptperformance/report/editindex', 'V_BGT_PERF_INDICATOR', 's', '单位编码', 'AGENCY_CODE', 0, null, 0, null, 45, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA05A5D75D1E3E5BE053B11FA8C0B8FC', '/pmkpi/deptperformance/report/editindex', 'V_BGT_PERF_INDICATOR', 's', '创建时间', 'CREATE_TIME', 0, null, 0, null, 46, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA05A5D75D213E5BE053B11FA8C0B8FC', '/pmkpi/deptperformance/report/editindex', 'V_BGT_PERF_INDICATOR', 's', '二级指标', 'SINDEX', 0, null, 0, null, 48, null, null, 'pmkpi', 1, null, '{}', null, null, null);

--年度任务
delete from busfw_t_uitable t where key in('/pmkpi/deptperformance/report/perftask');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('65F6B23DD77F4F3290D7E99ACDE3C2F9', '/pmkpi/deptperformance/report/perftask', 'V_PERF_T_DEPTTASK', 0, 1, 0, null, null, 'pmkpi', null);

delete from busfw_t_uicolumn t where key in('/pmkpi/deptperformance/report/perftask');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('876D9A31D2F84B1999CB44836B72ADF4', '/pmkpi/deptperformance/report/perftask', 'NAME', '任务名称', 1, 1, 1, 0, null, null, 1, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD567A4E20D8476C9543BC9B184BECC2', '/pmkpi/deptperformance/report/perftask', 'CONTEXT', '主要内容', 2, 1, 1, 0, null, null, 0, null, null, null, null, 300, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('91813EE2641D4DB7840240446873890B', '/pmkpi/deptperformance/report/perftask', 'TOTALAMT', '总金额', 3, 1, 1, 1, null, null, 0, '[''预算金额'']', null, null, null, 150, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D87FCE4FB2164A33823EC0C6E1353430', '/pmkpi/deptperformance/report/perftask', 'FINANCIALFUND', '财政资金', 4, 1, 1, 1, null, null, 0, '[''预算金额'']', null, null, null, 150, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2FBDFA115CE14FE4982636B4CBC6A155', '/pmkpi/deptperformance/report/perftask', 'OTHERFUND', '其他资金', 5, 1, 1, 1, null, null, 0, '[''预算金额'']', null, null, null, 150, 0, 'amt', null, null);
