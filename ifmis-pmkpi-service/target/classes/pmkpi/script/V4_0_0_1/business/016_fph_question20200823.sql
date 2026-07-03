begin


---page
delete from Bus_t_Pageconsole t where t.url='/pmkpi/setting/question';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/question', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.question.PmkpiQuestionPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,datatable]}', null, null, null);

delete from Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/setting/question';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/question', 'pmkpi_question', '{}', 'question', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/question', 'busuidatatable', '{name:''打分配置'',checkbox:true,title:''打分配置'',edit:true,addrow:true}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/question', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/question', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/question', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);


delete from Bus_t_Pagecomponent t where t.id='pmkpi_question';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_question', '打分配置', null, '打分配置', '/pmkpi/setting/question/questionservice.js', 'Ext.lt.pmkpi.question', 'pmkpi', 'pmkpi.setting.question.PmkpiQuestionService');

---UI

delete from p#busfw_t_Uifunction t where t.key='/pmkpi/setting/question';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('8B14E61BD98343FDA0132093742649A9', '/pmkpi/setting/question', '保存', 1, 1, 'searchicon', 'question.tablesave', null, '保存', 'pmkpi', 'tablesave', null, '{}');


delete from p#busfw_T_uitable t where t.key='/pmkpi/setting/question';
insert into busfw_T_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('4989B1C623D5450E827BD88B0EBE81B2', '/pmkpi/setting/question', 'V_PERF_T_QUESTION', 0, 0, 0, null, null, 'pmkpi', '{}');


delete from p#busfw_t_Uicolumn t where t.key='/pmkpi/setting/question';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('02B479F0E8DA45F5A64FBEA481714104', '/pmkpi/setting/question', 'SCOREDETAILS', '评分细则', 9, 1, 1, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('3390A2F609A14C83ACBE8CA31EA93C9F', '/pmkpi/setting/question', 'SCORESTAND', '评分标准', 8, 1, 1, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DE3744CA883943A28C2794BD3EAEF53C', '/pmkpi/setting/question', 'WEIGHT', '权重', 10, 1, 1, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D57966C0DD5E43F2B1729EE41FDBB9FB', '/pmkpi/setting/question', 'GUID', '主键', 1, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('FDEB165A43BE4F8C9C11E8649F468170', '/pmkpi/setting/question', 'EXPLANATION', '解释', 6, 1, 1, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('5EF87B8AB1D242E3A4113BD9B4746A43', '/pmkpi/setting/question', 'CODE', '编码', 4, 1, 1, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('7B0CC1768A014E55B00E16DC0A84278C', '/pmkpi/setting/question', 'REMARK', '说明', 7, 1, 1, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9D8A0E1B0E044D25BD6833E28AB37A11', '/pmkpi/setting/question', 'NODEGUID', '节点', 11,0, 1, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('4038F9C8FA3D4DF28E4A736165421CB5', '/pmkpi/setting/question', 'NAME', '名称', 5, 1, 1, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);
