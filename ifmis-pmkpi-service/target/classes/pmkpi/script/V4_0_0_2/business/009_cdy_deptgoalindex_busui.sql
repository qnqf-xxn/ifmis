begin

delete from p#busfw_t_uitable t where t.key in('/pmkpi/deptperformance/report/perftarget');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B2F8D448E30B3591E055000000000001', '/pmkpi/deptperformance/report/perftarget', 'V_BGT_PERF_GOAL_INFO', 0, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/deptperformance/report/perftarget');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B2F8D448E30C3591E055000000000001', '/pmkpi/deptperformance/report/perftarget', 'GUID', '主键', 1, 0, 0, 0, null, null, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B2F8D448E30D3591E055000000000001', '/pmkpi/deptperformance/report/perftarget', 'KPI_TARGET', '目标', 2, 1, 1, 0, null, null, null, null, null, null, null, null, 0, 's', null, null);

delete from p#busfw_t_uitable t where t.key in('/pmkpi/deptperformance/report/perfindex');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('E87BEB6E7A9E43EF80C804621F49FCA1', '/pmkpi/deptperformance/report/perfindex', 'BGT_PERF_INDICATOR', 0, 1, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/deptperformance/report/perfindex');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF38D1AA46AC4BA3B5A538F7557CD49D', '/pmkpi/deptperformance/report/perfindex', 'COMPUTESIGN', '计算符号', 9, 1, 1, 1, null, 1, null, null, '#name', null, null, 100, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B702F46ED33B46D9935D8BF777FC430A', '/pmkpi/deptperformance/report/perfindex', 'EXPLAIN', '公式或说明', 4, 1, 1, 0, null, 0, null, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('769BB16DDF704A928C6F72AC9F9A6D23', '/pmkpi/deptperformance/report/perfindex', 'FINDEX', '一级指标', 22, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('E6F657C3A2FB4378889CC4F8E9552CB1', '/pmkpi/deptperformance/report/perfindex', 'GUID', 'GUID', 25, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('7B3F59ADEA6C45049EC952721531866E', '/pmkpi/deptperformance/report/perfindex', 'INDEXVAL', '指标值', 10, 1, 1, 0, null, 1, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('FF8DC160AE5541C48092AD7963F0910A', '/pmkpi/deptperformance/report/perfindex', 'ISLINKED', '是否为与预算总额挂钩产出指标', 17, 1, 1, 0, null, 0, null, null, '#name', null, null, 120, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9DCFD26CF9C6498A96DD311837227500', '/pmkpi/deptperformance/report/perfindex', 'LEVELNO', '级次', 12, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF5EB36C5FCF937FE053B11FA8C04F08', '/pmkpi/deptperformance/report/perfindex', 'METERUNIT', '计量单位', 11, 1, 1, 1, null, 0, null, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('889F9D8555F843CE885DC6855D469814', '/pmkpi/deptperformance/report/perfindex', 'NAME', '指标名称', 3, 1, 1, 0, null, 1, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('6084AC2734C14AC696BD7572044502AE', '/pmkpi/deptperformance/report/perfindex', 'OBLIGATE1', '操作', 1, 0, 0, 0, null, 0, null, null, null, null, null, 80, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('27C7BAE71B1C4B35B1E3A28DB597C575', '/pmkpi/deptperformance/report/perfindex', 'OBLIGATE3', '操作', 2, 1, 0, 0, null, 0, null, null, null, null, null, 80, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('09ED2441FA764B0BB920A8C6F392F245', '/pmkpi/deptperformance/report/perfindex', 'RULE', '赋分原则', 18, 1, 1, 0, null, 0, 6, null, null, null, null, 180, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1AC4534F52D84FCC80CFF1B6C69DBE2A', '/pmkpi/deptperformance/report/perfindex', 'SINDEX', '二级指标', 23, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CA1D390B4D79475D97213EFD5DED5779', '/pmkpi/deptperformance/report/perfindex', 'SUPERID', 'SUPERID', 26, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF38D1AA46AC4BA3B5A538F7557CD49D', '/pmkpi/deptperformance/report/perfindex', 'WEIGHT', '权重', 16, 1, 1, 1, null, 1, null, null, null, null, null, 100, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B412538AB50962E3E0535164A8C0C98B', '/pmkpi/deptperformance/report/perfindex', 'KPI_CONTENT', '指标内容', 27, 1, 1, 0, null, 1, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B412538AB50A62E3E0535164A8C0C98B', '/pmkpi/deptperformance/report/perfindex', 'KPI_EVALSTD', '扣分标准', 28, 1, 1, 0, null, 1, null, null, null, null, null, 150, 0, 's', null, null);

delete from p#busfw_t_uitable t where t.key in('/pmkpi/deptperformance/report/target');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('FC5022FAF0E14E1A9B03F81D92B7973F', '/pmkpi/deptperformance/report/target', 'V_BGT_PERF_GOAL_INFO', 0, 1, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/deptperformance/report/target');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B5A085C812710888E0535164A8C0487E', '/pmkpi/deptperformance/report/target', 'GUID', 'guid', 0, 0, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('8BD8BCE40B354483821885536699CAF6', '/pmkpi/deptperformance/report/target', 'KPI_TARGET', '绩效目标', 2, 1, 1, 0, null, 0, null, null, null, null, null, 300, 0, 's', null, null);

delete from p#busfw_t_uieditform t where t.key in('/pmkpi/deptperformance/report/deptgoal');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('D0A34FDD98ED48B297D646813F311152', '/pmkpi/deptperformance/report/deptgoal', 'BGT_PERF_GOAL_INFO', 's', '主建id', 'MAINGUID', 0, null, 0, null, 21, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('26841ED743B54EC08B5E6DE9F35DE944', '/pmkpi/deptperformance/report/deptgoal', 'BGT_PERF_GOAL_INFO', 's', 'guid', 'GUID', 0, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('776EEC87219841C785DB41A45184D34E', '/pmkpi/deptperformance/report/deptgoal', 'BGT_PERF_GOAL_INFO', 's', '单位', 'AGENCYGUID', 0, null, 0, null, 22, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('32724B3B597B4C9BADD72BD77DF6C8FD', '/pmkpi/deptperformance/report/deptgoal', 'BGT_PERF_GOAL_INFO', 'textarea', '绩效目标', 'ZQGOAL', 0, null, 0, null, 1, 3, '3', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('FE540DE5217B4BE5B91C0D3DBC5331E0', '/pmkpi/deptperformance/report/deptgoal', 'BGT_PERF_GOAL_INFO', 's', '创建时间', 'CREATETIME', 0, null, 0, null, 17, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('87CF83219AD24B788CD94957A82C798D', '/pmkpi/deptperformance/report/deptgoal', 'BGT_PERF_GOAL_INFO', 's', '年度', 'YEAR', 0, null, 0, null, 16, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B6DCB826FB1640C692E1AA27AA239F66', '/pmkpi/deptperformance/report/deptgoal', 'BGT_PERF_GOAL_INFO', 'textarea', '绩效目标', 'KPI_TARGET', 1, null, 1, null, 2, 3, '8', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('545AE4F54512494BA3C4A7237C5E9D81', '/pmkpi/deptperformance/report/deptgoal', 'BGT_PERF_GOAL_INFO', 's', '区划', 'PROVINCE', 0, null, 0, null, 15, null, null, 'pmkpi', 0, null, '{}', null, null, null);

delete from p#busfw_t_uitable t where t.key in('/pmkpi/deptperformance/report/perftarget');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B2F8D448E30B3591E055000000000001', '/pmkpi/deptperformance/report/perftarget', 'V_BGT_PERF_GOAL_INFO', 0, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/deptperformance/report/perftarget');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B2F8D448E30C3591E055000000000001', '/pmkpi/deptperformance/report/perftarget', 'GUID', '主键', 1, 0, 0, 0, null, null, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B2F8D448E30D3591E055000000000001', '/pmkpi/deptperformance/report/perftarget', 'KPI_TARGET', '目标', 2, 1, 1, 0, null, null, null, null, null, null, null, null, 0, 's', null, null);

delete from p#busfw_t_uitable t where t.key in('/pmkpi/deptperformance/report/hnindex');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('28C2DB4BEEDB4854B1E7A21B0913EB98', '/pmkpi/deptperformance/report/hnindex', 'BGT_PERF_INDICATOR', 0, 1, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/deptperformance/report/hnindex');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('AC642B4C187A4207B7C41CFC9383E095', '/pmkpi/deptperformance/report/hnindex', 'COMPUTESIGN', '计算符号', 9, 1, 1, 0, null, 0, null, null, '#name', null, null, 100, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('4C2E70B9F45F4066B4C0E3578B61AF27', '/pmkpi/deptperformance/report/hnindex', 'GUID', 'GUID', 25, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9730FD1375F54D7A8371BB1555FB6755', '/pmkpi/deptperformance/report/hnindex', 'LEVELNO', '级次', 12, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('06D1CBF56AEB433E8BEEBCC0BDB90438', '/pmkpi/deptperformance/report/hnindex', 'METERUNIT', '计量单位', 11, 1, 1, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DAE9967E32974B71B9B7F321A03C8054', '/pmkpi/deptperformance/report/hnindex', 'NAME', '名称', 3, 1, 1, 0, null, 1, null, null, null, null, null, 280, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('84496BDE25744FA0AE5F735E28751F47', '/pmkpi/deptperformance/report/hnindex', 'OBLIGATE3', '计算', 2, 1, 0, 0, null, 0, null, null, null, null, null, 80, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('547B6F10B07844CB96FBB0A5D706431D', '/pmkpi/deptperformance/report/hnindex', 'SINDEX', '二级指标', 23, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2B80A85236504025B38FAA209BB0FD06', '/pmkpi/deptperformance/report/hnindex', 'SUPERID', 'SUPERID', 26, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1E561BA880764982A000F0BDE919D21E', '/pmkpi/deptperformance/report/hnindex', 'WEIGHT', '权重', 16, 0, 1, 1, null, 0, null, null, null, null, null, 100, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B47721D4FA131010E0535164A8C05EF7', '/pmkpi/deptperformance/report/hnindex', 'KPI_CONTENT', '指标内容', 27, 1, 1, 0, null, 1, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B47721D4FA141010E0535164A8C05EF7', '/pmkpi/deptperformance/report/hnindex', 'KPI_EVALSTD', '扣分标准', 28, 1, 1, 0, null, 1, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B47721D4FA171010E0535164A8C05EF7', '/pmkpi/deptperformance/report/hnindex', 'INDEXVAL', '指标值', 10, 1, 1, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null);

