begin
--公式编辑区配置
delete from p#busfw_t_uitable where key = '/pmkpi/setting/editformal';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('1CDE90EB509F40E597Dss4A3E8A31FH0', '/pmkpi/setting/editformal', 'PERF_T_EDITFORMAL', 0, 0, 0, null, null, 'pmkpi', null);
--财政重点评价评分表
delete from p#busfw_t_uitable where key = '/pmkpi/setting/tempdataset';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B84E9D5606117E4AE0530100007F3871', '/pmkpi/setting/tempdataset', 'PERF_T_EVALUATETEMP', 0, 0, 0, null, null, 'pmkpi', null);
--绩效枚举配置
delete from p#busfw_t_uitable where key = '/pmkpi/setting/perfenumset';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B84E9D5606117E4AE0530100007F3871', '/pmkpi/setting/perfenumset', 'PERF_ENUM', 0, 0, 0, null, null, 'pmkpi', null);

--审核定义下级菜单
delete from p#busfw_t_uitable where key = '/pmkpi/setting/auditdefinemenu';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('1CDE90EB509F40E597D464A3E8A31FH0', '/pmkpi/setting/auditdefinemenu', 'PERF_T_AUDITDEFINEMENU', 0, 0, 0, null, null, 'pmkpi', null);

--预警规则配置
delete from p#busfw_t_uitable where key = '/pmkpi/setting/warnset';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('1CDE90EB527F40E597D464A3E8A31FH0', '/pmkpi/setting/warnset', 'PERF_T_WARNSET', 0, 0, 0, null, null, 'pmkpi', null);




--公式编辑区配置
delete from p#busfw_t_uicolumn where key = '/pmkpi/setting/editformal';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('4259B5A225C84819BC68sdsf684F1709', '/pmkpi/setting/editformal', 'GUID', '主键', 1, 0, 0, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2F45AC072B4548dsA1F55154SF78A224', '/pmkpi/setting/editformal', 'TABLECODE', '表编码', 2, 1, 1, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('40818C18fg2609ED9SD8E66719D46885', '/pmkpi/setting/editformal', 'NAME', '名称', 3, 1, 1, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1442E0995FC40sf6A5B0D9GJ97A4A513', '/pmkpi/setting/editformal', 'COLUMNCODE', '字段编码', 4, 1, 1, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2A7E5B6B4F9640sdSGE224sf6E3DB144', '/pmkpi/setting/editformal', 'QUERYSQL', '查询语句', 5, 1, 1, 0, null, 1, null, null, null, null, null, 100, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0F25EC493F494sd8B09S879D0BD5D33A', '/pmkpi/setting/editformal', 'YEAR', '年度', 10, 0, 0, 0, null, 0, null, null, null, null, null, 100, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9ABDF69E58764asD9AS099C854D41D8D', '/pmkpi/setting/editformal', 'PROVINCE', '区划', 11, 0, 0, 0, null, 0, null, null, null, null, null, 100, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9ABDF69E58764BCD9Aas99C854DsiD8D', '/pmkpi/setting/editformal', 'ORDERNUM', '排序', 9, 1, 1, 0, null, 1, null, null, null, null, null, 100, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0F25EC493F494BA8B09S879gdBD5D33A', '/pmkpi/setting/editformal', 'VALUE', '值', 8, 0, 0, 0, null, 0, null, null, null, null, null, 100, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0F25EC493F494BA8B0gd879D0BD5D33A', '/pmkpi/setting/editformal', 'SUMCOL', '合计列', 7, 1, 1, 0, null, 0, null, null, null, null, null, 100, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2A7E5B6B4F964093SGE2246gdE3DB144', '/pmkpi/setting/editformal', 'AGENCYGUID', '单位编码', 6, 0, 1, 0, null, 0, null, null, null, null, null, 100, null, 's', null, null);
--财政重点评价评分表
delete from p#busfw_t_uicolumn where key = '/pmkpi/setting/tempdataset';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BC8DF02C1F1FF3B8E053B11FA8C0D3A2', '/pmkpi/setting/tempdataset', 'ISLEAF', '是否末节点', 14, 0, 1, 0, null, 0, null, null, null, null, null, 280, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BC8DF02C1F20F3B8E053B11FA8C0D3A3', '/pmkpi/setting/tempdataset', 'LEVELNO', '层级', 16, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D16BE33B81DF486FBB1609F691CA6408', '/pmkpi/setting/tempdataset', 'SUPERID', 'superid', 12, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B84E9D56D6137E4AE0530100207F3871', '/pmkpi/setting/tempdataset', 'CODE', '编码', 4, 1, 1, 0, null, 0, null, null, null, null, null, 120, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('FC62689EB81347298F1EDCC26D24DE47', '/pmkpi/setting/tempdataset', 'SCORE', '得分', 7, 1, 1, 0, null, 0, null, null, null, null, null, 100, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('29284FC3B4C5434CBB147C9BD779A00B', '/pmkpi/setting/tempdataset', 'NAME', '指标名称', 5, 1, 1, 0, null, 1, null, null, null, null, null, 280, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('39C1152FC12A450C82D4B8614A942882', '/pmkpi/setting/tempdataset', 'GUID', 'guid', 3, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('889F9D8555F843CE8856C6855D469814', '/pmkpi/setting/tempdataset', 'ISADD', '操作', 1, 1, 0, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B84E9D56D6127E4AE0730100076F3871', '/pmkpi/setting/tempdataset', 'REMARK', '备注', 23, 1, 1, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B84E9D56D612764AE0730100077F3871', '/pmkpi/setting/tempdataset', 'EVALSTD', '评分标准', 24, 1, 1, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B84E9D56D6127E46E0730100077F3871', '/pmkpi/setting/tempdataset', 'EXPLAIN', '指标解释', 25, 1, 1, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B84E9D56s6127E46E07301p0077F3871', '/pmkpi/setting/tempdataset', 'BUSTYPE', '业务类型', 26, 1, 1, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B84E0D56Dc127E46E0730100077F3871', '/pmkpi/setting/tempdataset', 'AUDITTYPE', '审核类型', 27, 1, 1, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B84E0D56D6127E46E0730100077F8871', '/pmkpi/setting/tempdataset', 'ORDERNUM', '排序', 22, 1, 1, 0, null, 1, null, null, null, null, null, 50, 0, 's', null, null);
--绩效枚举配置
delete from p#busfw_t_uicolumn where key = '/pmkpi/setting/perfenumset';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BC8DF02C1F1FF3B8E053B11FA8C0D3A2', '/pmkpi/setting/perfenumset', 'APPID', 'appid', 11, 0, 1, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BC8DF02C1F1FF3B8E053B11FA8C0D3A2', '/pmkpi/setting/perfenumset', 'CODE', '编码', 2, 1, 1, 0, null, 1, null, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BC8DF02C1F1FF3B8E053B11FA8C0D3A2', '/pmkpi/setting/perfenumset', 'ELEMENTCODE', '类型', 4, 1, 1, 0, null, 1, null, null, null, null, null, 250, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BC8DF02C1F1FF3B8E053B11FA8C0D3A2', '/pmkpi/setting/perfenumset', 'GUID', '主键', 0, 0, 0, 0, null, 1, null, null, null, null, null, 0, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BC8DF02C1F1FF3B8E053B11FA8C0D3A2', '/pmkpi/setting/perfenumset', 'ISLEAF', '是否末节点', 9, 1, 1, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BC8DF02C1F1FF3B8E053B11FA8C0D3A2', '/pmkpi/setting/perfenumset', 'LEVELNO', '层级', 10, 0, 1, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BC8DF02C1F1FF3B8E053B11FA8C0D3A2', '/pmkpi/setting/perfenumset', 'NAME', '名称', 3, 1, 1, 0, null, 1, null, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BC8DF02C1F1FF3B8E053B11FA8C0D3A2', '/pmkpi/setting/perfenumset', 'ORDERNUM', '排序', 8, 1, 1, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BC8DF02C1F1FF3B8E053B11FA8C0D3A2', '/pmkpi/setting/perfenumset', 'VERSION', '版本', 5, 0, 1, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BC8DF02C1F1FF3B8E053B11FA8C0D3A2', '/pmkpi/setting/perfenumset', 'REMARK', '备注', 6, 1, 1, 0, null, 0, null, null, null, null, null, 300, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BC8DF02C1F1FF3B8E053B11FA8C0D3A2', '/pmkpi/setting/perfenumset', 'STATUS', '状态', 7, 0, 1, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BC8DF02C1F1FF3B8E053B11FA8C0D3A2', '/pmkpi/setting/perfenumset', 'SUPERID', '父级', 12, 0, 0, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BC8DF02C1F1FF3B8E053B11FA8C0D3A1', '/pmkpi/setting/perfenumset', 'ISADD', '操作', 1, 1, 0, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null);
--审核定义下级菜单
delete from p#busfw_t_uicolumn where key = '/pmkpi/setting/auditdefinemenu';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('4259B5A225C84819BC6810sf684F1709', '/pmkpi/setting/auditdefinemenu', 'GUID', '主键', 1, 0, 0, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2F45AC072B4548C2A1F55154SF78A224', '/pmkpi/setting/auditdefinemenu', 'CODE', '编码', 2, 1, 1, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('40818C18ED2609ED9SD8E66719D46885', '/pmkpi/setting/auditdefinemenu', 'NAME', '名称', 3, 1, 1, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1442E0995FC40936A5B0D9GJ97A4A513', '/pmkpi/setting/auditdefinemenu', 'SUPERID', '父级菜单', 4, 1, 1, 0, null, 1, null, null, '#code-#name', null, null, 150, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2A7E5B6B4F964093SGE224626E3DB144', '/pmkpi/setting/auditdefinemenu', 'REMARK', '备注', 5, 1, 1, 0, null, 0, null, null, null, null, null, 200, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0F25EC493F494BA8B09S879D0BD5D33A', '/pmkpi/setting/auditdefinemenu', 'YEAR', '年度', 10, 1, 0, 0, null, 0, null, null, null, null, null, 100, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9ABDF69E58764BCD9AS099C854D41D8D', '/pmkpi/setting/auditdefinemenu', 'PROVINCE', '区划', 11, 1, 0, 0, null, 0, null, null, null, null, null, 100, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9ABDF69E58764BCD9AS099C854DsiD8D', '/pmkpi/setting/auditdefinemenu', 'ORDERNUM', '排序', 6, 1, 1, 0, null, 0, null, null, null, null, null, 100, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9ABDF69E58764BCD9AS09sd854DsiD8D', '/pmkpi/setting/auditdefinemenu', 'LEVELNO', '层级', 7, 0, 1, 0, null, 0, null, null, null, null, null, 100, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1442E0995FC40936A5Bok9GJ97A4A513', '/pmkpi/setting/auditdefinemenu', 'ISLEAF', '是否是叶子节点', 8, 0, 0, 0, null, 0, null, null, null, null, null, 100, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1442E0995FC40936A5B0olGJ97A4A513', '/pmkpi/setting/auditdefinemenu', 'STATUS', '状态', 9, 0, 0, 0, null, 0, null, null, null, null, null, 100, null, 's', null, null);
--预警规则
delete from p#busfw_t_uicolumn where key = '/pmkpi/setting/warnset';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('4259B5A225C84819BC6810sf684F1791', '/pmkpi/setting/warnset', 'GUID', '主键', 1, 0, 0, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2F45AC072B4548C2A1F55154SF78A224', '/pmkpi/setting/warnset', 'CODE', '编码', 2, 1, 1, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('40818C18ED264EED9SD8E66719D46885', '/pmkpi/setting/warnset', 'NAME', '名称', 3, 1, 1, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1442E0995FC44D36A5B0D9GJ97A4A513', '/pmkpi/setting/warnset', 'TYPE', '类别', 4, 1, 1, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2A7E5B6B4F964343SGE224626E3DB144', '/pmkpi/setting/warnset', 'WARNSQL', 'SQL语句', 5, 1, 1, 0, null, 1, null, null, null, null, null, 200, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0F25EC493F494BA8B5GS879D0BD5D33A', '/pmkpi/setting/warnset', 'YEAR', '年度', 8, 1, 0, 0, null, 0, null, null, null, null, null, 100, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9ABDF69E58764BCD9ASB19C854D41D8D', '/pmkpi/setting/warnset', 'PROVINCE', '区划', 9, 1, 0, 0, null, 0, null, null, null, null, null, 100, null, 's', null, null);

--公式编辑区配置
delete from p#busfw_t_uifunction where key = '/pmkpi/setting/editformal';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('43B3D3E65D7F479afKOAAC7C9E57052D', '/pmkpi/setting/editformal', '初始化', 1, 2, 'openstat', 'perfdataset.initset', null, '初始化', 'pmkpi', 'initset', '1', '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('E16E33sf5834461EA5A1E96CAF1KK3E', '/pmkpi/setting/editformal', '保存', 1, 1, 'searchicon', 'perfdataset.savemajorkey', null, '保存', 'pmkpi', 'savemajorkey', null, '{}');

--财政重点评价评分表

delete from p#busfw_t_uifunction where key = '/pmkpi/setting/tempdataset';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B84E9D56D6107E4AE0530100007F3871', '/pmkpi/setting/tempdataset', '保存', 1, 1, 'Keepicon', 'tempdataset.savemajorkey', null, '保存', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('9B1F32F777464B52B82597A16C090F9E', '/pmkpi/setting/tempdataset', '初始化', 1, 2, 'Keepicon', 'tempdataset.copy', null, '初始化指标层级', 'pmkpi', null, null, null);

--绩效枚举配置

delete from p#busfw_t_uifunction where key = '/pmkpi/setting/perfenumset';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B84E9D56D6107E4AE0530100007F3871', '/pmkpi/setting/perfenumset', '保存', 1, 1, 'Keepicon', 'tempdataset.savemajorkey', null, '保存', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('9B1F32F777464B52B82597A16C090F9E', '/pmkpi/setting/perfenumset', '初始化', 1, 2, 'Keepicon', 'tempdataset.initleftset', null, '初始化', 'pmkpi', null, null, null);

--审核定义下级菜单

delete from p#busfw_t_uifunction where key = '/pmkpi/setting/auditdefinemenu';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('E16E33E85834461EA5foE96CAF1KK3E', '/pmkpi/setting/auditdefinemenu', '保存', 1, 1, 'searchicon', 'perfdataset.save', null, '保存', 'pmkpi', 'save', null, '{}');

--预警规则配置
delete from p#busfw_t_uifunction where key = '/pmkpi/setting/warnset';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('E16E33E85834461EA5A1E96CAF1KK3E', '/pmkpi/setting/warnset', '保存', 1, 1, 'searchicon', 'perfdataset.savemajorkey', null, '保存', 'pmkpi', 'savemajorkey', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('43B3D3E65D7F47959KOAAC7C9E57052D', '/pmkpi/setting/warnset', '初始化', 1, 2, 'openstat', 'perfdataset.initset', null, '初始化', 'pmkpi', 'initset', '1', '{}');

--公式编辑区配置
delete from p#busfw_t_uiqueryform where key = '/pmkpi/setting/editformal';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('EC995AD6884E5EECB0DA7DB633B07718', '/pmkpi/setting/editformal', 'NAME', '名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'PERF_T_EDITFORMAL', '{}', null);

--财政重点评价评分表
delete from p#busfw_t_uiqueryform where key = '/pmkpi/setting/tempdataset';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('EC995AD6884E5EECB00A7DB633B07718', '/pmkpi/setting/tempdataset', 'NAME', '名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'PERF_T_EVALUATETEMP', '{}', null);

--绩效枚举配置
delete from p#busfw_t_uiqueryform where key = '/pmkpi/setting/perfenumset';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('EC999AL6884E5EECB0DA7DB633B07718', '/pmkpi/setting/perfenumset', 'ELEMENTCODE', '类型', 1, 1, 's', null, null, null, 'pmkpi', 'PERF_ENUM', '{}', null);
--审核定义下级菜单
delete from p#busfw_t_uiqueryform where key = '/pmkpi/setting/auditdefinemenu';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('EC994AD6884E5EECB0DA7DB633B07718', '/pmkpi/setting/auditdefinemenu', 'NAME', '名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'PERF_T_AUDITDEFINEMENU', '{}', null);

--预警规则配置
delete from p#busfw_t_uiqueryform where key = '/pmkpi/setting/warnset';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('EC999AD6884E5EECB0DA7DB633B07718', '/pmkpi/setting/warnset', 'NAME', '名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'PERF_T_WARNSET', '{}', null);
