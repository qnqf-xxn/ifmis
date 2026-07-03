begin


delete from bus_t_pageconsolecomconfig  t where t.url='/pmkpi/evaluation/financial/deptfill/deptedit/score';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/deptfill/deptedit/score', 'pmkpi_deptfillscore', '{}', 'deptfillscore', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/deptfill/deptedit/score', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:true,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false}', 'datatable', 'pmkpi', null);


delete from bus_t_pageconsole t where t.url='/pmkpi/evaluation/financial/deptfill/deptedit/score';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/financial/deptfill/deptedit/score', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.financial.deptfill.DeptfillPage', 'score', '{main:[datatable]}', null, null, 0);



delete from P#BUSFW_T_UICOLUMN t where t.key='/pmkpi/evaluation/financial/deptfill/deptedit/score';


insert into BUSFW_T_UICOLUMN (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D5FF6921976F2ECDE0533315A8C010AF', '/pmkpi/evaluation/financial/deptfill/deptedit/score', 'EXPLAIN', '指标解释', 2, 1, 1, 0, null, 0, 6, null, null, null, null, 180, 0, 's', null, null);

insert into BUSFW_T_UICOLUMN (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D5FF692197702ECDE0533315A8C010AF', '/pmkpi/evaluation/financial/deptfill/deptedit/score', 'EVALSTD', '评分标准', 3, 1, 1, 0, null, 0, 6, null, null, null, null, 220, 0, 's', null, null);

insert into BUSFW_T_UICOLUMN (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D5FF692197712ECDE0533315A8C010AF', '/pmkpi/evaluation/financial/deptfill/deptedit/score', 'SCORE', '分值', 4, 1, 1, 1, null, 0, 6, null, null, null, null, 30, 0, 'f', null, null);

insert into BUSFW_T_UICOLUMN (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D5FF692197722ECDE0533315A8C010AF', '/pmkpi/evaluation/financial/deptfill/deptedit/score', 'SELFSCORE', '得分', 5, 1, 1, 1, null, 1, 6, null, null, null, null, 40, 0, 'f', null, null);

insert into BUSFW_T_UICOLUMN (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D5FF692197732ECDE0533315A8C010AF', '/pmkpi/evaluation/financial/deptfill/deptedit/score', 'REMARK', '单位自评完成情况描述（需附相关佐证材料）', 6, 1, 1, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

insert into BUSFW_T_UICOLUMN (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D5FF692197742ECDE0533315A8C010AF', '/pmkpi/evaluation/financial/deptfill/deptedit/score', 'FILE', '附件管理', 7, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', null, null);

insert into BUSFW_T_UICOLUMN (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D5FF692197752ECDE0533315A8C010AF', '/pmkpi/evaluation/financial/deptfill/deptedit/score', 'FILENAME', '附件材料', 7, 1, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

insert into BUSFW_T_UICOLUMN (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D5FF692197762ECDE0533315A8C010AF', '/pmkpi/evaluation/financial/deptfill/deptedit/score', 'GUID', 'guid', 8, 0, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', null, null);

insert into BUSFW_T_UICOLUMN (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D5FF692197772ECDE0533315A8C010AF', '/pmkpi/evaluation/financial/deptfill/deptedit/score', 'TARGETVALUE', '目标值或目标来源', 30, 0, 1, 0, null, 0, null, null, null, null, null, 50, 0, 's', null, null);

insert into BUSFW_T_UICOLUMN (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D5FF692197782ECDE0533315A8C010AF', '/pmkpi/evaluation/financial/deptfill/deptedit/score', 'EVALUATIONRULE', '评扣分细则', 31, 0, 1, 0, null, 0, null, null, null, null, null, 50, 0, 's', null, null);

insert into BUSFW_T_UICOLUMN (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL )
values ('D5FF692197792ECDE0533315A8C010AF', '/pmkpi/evaluation/financial/deptfill/deptedit/score', 'REMARKS', '备注', 32, 1, 1, 0, null, 0, null, null, null, null, null, 50, 0, 's', null, null);

insert into BUSFW_T_UICOLUMN (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D5FF6921976D2ECDE0533315A8C010AF', '/pmkpi/evaluation/financial/deptfill/deptedit/score', 'OBLIGATE1', '操作', 0, 1, 0, 0, null, 0, 6, null, null, null, null, 30, 1, 's', null, null);

insert into BUSFW_T_UICOLUMN (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D5FF6921976E2ECDE0533315A8C010AF', '/pmkpi/evaluation/financial/deptfill/deptedit/score', 'NAME', '指标名称', 1, 1, 1, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);



delete from p#BUSFW_T_UITABPAGE t where t.key='/pmkpi/evaluation/financial/deptfill/deptedit' and  t.componentid='proscoreiframe';

insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37A06274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/evaluation/financial/deptfill/deptedit', '评分表', 'info', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '评分表', null, null, '{busguid:''BD9470BB508E48E5E053B11FA8C0AEAA'',url:''/pmkpi/evaluation/financial/deptfill/deptedit/score.page'',action:''deptfillscore.save''}', null, '0', 'proscoreiframe', null, null, null, null, null,  null);


delete from P#BUSFW_T_UITABLE t where t.key='/pmkpi/evaluation/financial/deptfill/deptedit/score';

insert into BUSFW_T_UITABLE (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('D5D3D3E10FAC270CE0533315A8C0ACDD', '/pmkpi/evaluation/financial/deptfill/deptedit/score', 'V_PERF_T_DEPTSCORE', 0, 1, 0, null, null, 'pmkpi', '{}');

