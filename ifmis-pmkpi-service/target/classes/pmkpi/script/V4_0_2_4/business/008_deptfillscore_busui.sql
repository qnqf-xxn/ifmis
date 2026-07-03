  i number;
begin

--财政评价管理-预算部门自评-评分表
--展示列注册-项目支出
delete from p#busfw_t_uicolumn where key = '/pmkpi/evaluation/financial/deptfill/score';
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E3262C274CE0533315A8C0ACDD', '/pmkpi/evaluation/financial/deptfill/score', 'GUID', 'guid', 0, 0, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E323AD274CE0533315A8C0ACDD', '/pmkpi/evaluation/financial/deptfill/score', 'OBLIGATE1', '操作', 1, 1, 0, 0, null, 0, 6, null, null, null, null, 30, 1, 's', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E323AE274CE0533315A8C0ACDD', '/pmkpi/evaluation/financial/deptfill/score', 'NAME', '指标名称', 2, 1, 1, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E323AF274CE0533315A8C0ACDD', '/pmkpi/evaluation/financial/deptfill/score', 'EXPLAIN', '指标解释', 3, 1, 1, 0, null, 0, 6, null, null, null, null, 180, 0, 's', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E323B0274CE0533315A8C0ACDD', '/pmkpi/evaluation/financial/deptfill/score', 'EVALSTD', '评分标准', 4, 1, 1, 0, null, 0, 6, null, null, null, null, 220, 0, 's', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E323B1274CE0533315A8C0ACDD', '/pmkpi/evaluation/financial/deptfill/score', 'SCORE', '分值', 5, 1, 1, 1, null, 0, 6, null, null, null, null, 30, 0, 'f', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E323B2274CE0533315A8C0ACDD', '/pmkpi/evaluation/financial/deptfill/score', 'SELFSCORE', '单位自评分', 6, 1, 1, 1, null, 1, 6, null, null, null, null, 40, 0, 'f', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E323B3274CE0533315A8C0ACDD', '/pmkpi/evaluation/financial/deptfill/score', 'REMARK', '单位自评完成情况描述', 7, 1, 1, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32628274CE0533315A8C0ACDD', '/pmkpi/evaluation/financial/deptfill/score', 'FILE', '附件管理', 8, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E3262B274CE0533315A8C0ACDD', '/pmkpi/evaluation/financial/deptfill/score', 'FILENAME', '附件材料', 9, 1, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{}', null);
--展示列注册-部门整体
delete from p#busfw_t_uicolumn where key = '/pmkpi/evaluation/financial/deptfill/deptedit/score';
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D5FF692197762ECDE0533315A8C010AF', '/pmkpi/evaluation/financial/deptfill/deptedit/score', 'GUID', 'guid', 0, 0, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D5FF6921976D2ECDE0533315A8C010AF', '/pmkpi/evaluation/financial/deptfill/deptedit/score', 'OBLIGATE1', '操作', 1, 1, 0, 0, null, 0, 6, null, null, null, null, 30, 1, 's', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D5FF6921976E2ECDE0533315A8C010AF', '/pmkpi/evaluation/financial/deptfill/deptedit/score', 'NAME', '指标名称', 2, 1, 1, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D5FF6921976F2ECDE0533315A8C010AF', '/pmkpi/evaluation/financial/deptfill/deptedit/score', 'EXPLAIN', '指标解释', 3, 1, 1, 0, null, 0, 6, null, null, null, null, 180, 0, 's', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D5FF692197702ECDE0533315A8C010AF', '/pmkpi/evaluation/financial/deptfill/deptedit/score', 'EVALSTD', '评价要点', 4, 1, 1, 0, null, 0, 6, null, null, null, null, 220, 0, 's', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D5FF692197772ECDE0533315A8C010AF', '/pmkpi/evaluation/financial/deptfill/deptedit/score', 'TARGETVALUE', '目标值或目标来源', 5, 0, 1, 0, null, 0, 6, null, null, null, null, 50, 0, 's', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D5FF692197782ECDE0533315A8C010AF', '/pmkpi/evaluation/financial/deptfill/deptedit/score', 'EVALUATIONRULE', '评扣分细则', 6, 0, 1, 0, null, 0, 6, null, null, null, null, 50, 0, 's', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D5FF692197712ECDE0533315A8C010AF', '/pmkpi/evaluation/financial/deptfill/deptedit/score', 'SCORE', '分值', 7, 1, 1, 1, null, 0, 6, null, null, null, null, 30, 0, 'f', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D5FF692197722ECDE0533315A8C010AF', '/pmkpi/evaluation/financial/deptfill/deptedit/score', 'SELFSCORE', '自评得分', 8, 1, 1, 1, null, 1, 6, null, null, null, null, 40, 0, 'f', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D5FF692197732ECDE0533315A8C010AF', '/pmkpi/evaluation/financial/deptfill/deptedit/score', 'REMARK', '完成情况描述', 9, 1, 1, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D5FF692197792ECDE0533315A8C010AF', '/pmkpi/evaluation/financial/deptfill/deptedit/score', 'REMARKS', '备注', 10, 0, 1, 0, null, 0, 6, null, null, null, null, 50, 0, 's', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D5FF692197742ECDE0533315A8C010AF', '/pmkpi/evaluation/financial/deptfill/deptedit/score', 'FILE', '附件管理', 11, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D5FF692197752ECDE0533315A8C010AF', '/pmkpi/evaluation/financial/deptfill/deptedit/score', 'FILENAME', '附件材料', 12, 1, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{}', null);

--财政评价管理-财政评价项目审核-部门评分表
update p#busfw_t_uitabpage set config = '{url:''/pmkpi/evaluation/financial/deptfill/deptedit/score.page''}' where key = '/pmkpi/evaluation/finconfirm/deptedit' and code = 'score';
--财政评价管理-财政评价成果上传、财政评价成果审核、财政终稿报告上传-部门评分表
update p#busfw_t_uitabpage set config = '{url:''/pmkpi/evaluation/financial/deptfill/deptedit/score.page''}' where key = '/pmkpi/evaluation/financial/result/deptedit' and code = 'score';
--财政评价管理-预算部门自评-部门评分表
update p#busfw_t_uitabpage set config = '{busguid:''BD9470BB508E48E5E053B11FA8C0AEAA'',url:''/pmkpi/evaluation/financial/deptfill/deptedit/score.page'',action:''deptfillscore.save''}' where key = '/pmkpi/evaluation/financial/deptfill/deptedit' and code = 'info' and componentid = 'proscoreiframe';
