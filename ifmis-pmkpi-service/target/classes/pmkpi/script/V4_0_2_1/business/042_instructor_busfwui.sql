begin
  
delete from p#busfw_t_uiqueryform where key = '/pmkpi/setting/baseinfo/instructor';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('9015933AC0CB48C0A6B0AE4AF759CE80', '/pmkpi/setting/baseinfo/instructor', 'NAME', '名称', 3, 1, 's', null, null, null, 'pmkpi', 'V_PERF_INSTRUCTOR', '{}', null);


delete from p#busfw_t_uifunction where key = '/pmkpi/setting/baseinfo/instructor';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('F55BD0708D70BC75AD735EFF5905485D', '/pmkpi/setting/baseinfo/instructor', '修改', 1, 7, 'Keepicon', 'baseinfo.sxupdate', null, '修改', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('EF536A598F36C1F33A33E4BC1F447D43', '/pmkpi/setting/baseinfo/instructor', '删除', 1, 3, 'Keepicon', 'baseinfo.del', null, '删除', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('1E94E37E42A7176441309755D280B054', '/pmkpi/setting/baseinfo/instructor', '新增', 1, 6, 'Keepicon', 'baseinfo.sxadd', null, '新增', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('0CE4DCAD1FC9F2AB26FFD197B675C338', '/pmkpi/setting/baseinfo/instructor', '查询', 0, 4, 'Keepicon', 'baseinfo.query', null, '查询', 'pmkpi', null, null, null);



delete from p#busfw_t_uicolumn where key = '/pmkpi/setting/baseinfo/instructor';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C12D96A9C4845D8FC99A248B7470B3E9', '/pmkpi/setting/baseinfo/instructor', 'SEX', '性别', 2, 1, 0, 0, null, 1, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B5294C114E0CAA9C30E2625119C10A12', '/pmkpi/setting/baseinfo/instructor', 'WORKPLACE', '工作单位', 5, 1, 0, 0, null, 1, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CAD90439F304B3CA991C33A1CBDCEDCA', '/pmkpi/setting/baseinfo/instructor', 'OCCUPATION', '从事职业', 6, 1, 0, 0, null, 1, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('7859707FC21687D187F717474A65C98A', '/pmkpi/setting/baseinfo/instructor', 'JOB', '职务', 7, 1, 0, 0, null, 1, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('8C5B545B536F79709D7628BF58245E2A', '/pmkpi/setting/baseinfo/instructor', 'NAME', '名称', 1, 1, 0, 0, null, 1, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('589A55AA0215F5FE1D62DF7B46BC454E', '/pmkpi/setting/baseinfo/instructor', 'GUID', 'GUID', 0, 0, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('7CBC7BC49FA95C1CC4C434122DEC6B84', '/pmkpi/setting/baseinfo/instructor', 'EDUCATION', '学历', 3, 1, 0, 0, null, 0, null, null, '#name', null, null, null, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('965DE9FACD8C0EA55404F203E65EB127', '/pmkpi/setting/baseinfo/instructor', 'POLITICAL', '政治面貌', 4, 1, 0, 0, null, 0, null, null, '#name', null, null, null, 1, 'tree', null, null);




delete from p#busfw_t_uitable where key = '/pmkpi/setting/baseinfo/instructor';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('5A63E7229BEAA07B45EA6A5190A5E886', '/pmkpi/setting/baseinfo/instructor', 'V_PERF_INSTRUCTOR', 100, 0, 0, null, null, 'pmkpi', null);



delete from p#busfw_t_uieditform where key = '/pmkpi/setting/baseinfo/instructor/edit';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('ECB4F1AE3F117C8577DEB59FAD806E18', '/pmkpi/setting/baseinfo/instructor/edit', 'V_PERF_INSTRUCTOR', 'textarea', '省财政厅审核意见', 'FINANCEOPINION', 1, null, 1, null, 18, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('4EC0D7C1769BE93763F8686EB4F10B8D', '/pmkpi/setting/baseinfo/instructor/edit', 'V_PERF_INSTRUCTOR', 'textarea', '任职单位审核意见', 'EMPLOYOPINION', 1, null, 1, null, 17, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('0385A17024181CD4FFB8EC6FC6F6D19C', '/pmkpi/setting/baseinfo/instructor/edit', 'V_PERF_INSTRUCTOR', 'textarea', '个人相关方向所取得的主要成果和发表文章', 'TREATISE', 1, null, 1, null, 16, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('A5DB42CDAF2EEB50EA12F7EA4CDEC126', '/pmkpi/setting/baseinfo/instructor/edit', 'V_PERF_INSTRUCTOR', 'textarea', '工作简历', 'RESUME', 1, null, 1, null, 15, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('94B1B1195EC5E58A1A421D896B0048A9', '/pmkpi/setting/baseinfo/instructor/edit', 'V_PERF_INSTRUCTOR', 's', '联系地址', 'ADDRESS', 1, null, 1, null, 14, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('CE9D3D38C720F14BB8A1E470BB577DEA', '/pmkpi/setting/baseinfo/instructor/edit', 'V_PERF_INSTRUCTOR', 's', '固定电话', 'TEL', 1, null, 1, null, 13, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('F68E82011A1E18074D3E708367F65477', '/pmkpi/setting/baseinfo/instructor/edit', 'V_PERF_INSTRUCTOR', 's', 'E-mail', 'EMAIL', 1, null, 1, null, 12, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('9DFA3EBDACA5C9B0E7F78C7D4851B57C', '/pmkpi/setting/baseinfo/instructor/edit', 'V_PERF_INSTRUCTOR', 's', '手机', 'PHONE', 1, null, 1, null, 11, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('7FA44BFBA6BA2FB74B604A01F3F612E1', '/pmkpi/setting/baseinfo/instructor/edit', 'V_PERF_INSTRUCTOR', 's', '职务', 'JOB', 1, null, 1, null, 10, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('84122F3F449CFCBE1F41D5FA93E76ECB', '/pmkpi/setting/baseinfo/instructor/edit', 'V_PERF_INSTRUCTOR', 's', '从事职业', 'OCCUPATION', 1, null, 1, null, 9, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('AEA0CBBD1E6F751768318A7F0870033F', '/pmkpi/setting/baseinfo/instructor/edit', 'V_PERF_INSTRUCTOR', 's', '工作单位', 'WORKPLACE', 1, null, 1, null, 8, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C4802F5E5E0225A92C1945A5B9AF1E1D', '/pmkpi/setting/baseinfo/instructor/edit', 'V_PERF_INSTRUCTOR', 's', '特长', 'SPECIALTY', 1, null, 1, null, 7, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('70484C68085334F11EC03124BC0DB792', '/pmkpi/setting/baseinfo/instructor/edit', 'V_PERF_INSTRUCTOR', 'tree', '政治面貌', 'POLITICAL', 1, null, 1, null, 6, null, null, 'pmkpi', 1, null, '{"format":"#code-#name"}', 0, 1, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('0D8EEE74F4DB9AFDDF17AB2E751E5982', '/pmkpi/setting/baseinfo/instructor/edit', 'V_PERF_INSTRUCTOR', 'tree', '学历', 'EDUCATION', 1, null, 1, null, 5, null, null, 'pmkpi', 1, null, '{"format":"#code-#name"}', 0, 1, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('CD1EFE4A7E079E91BE7A776025D61279', '/pmkpi/setting/baseinfo/instructor/edit', 'V_PERF_INSTRUCTOR', 's', '年龄', 'AGE', 1, null, 1, null, 4, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('0A8D99BE89B182E67867FDD29341FD39', '/pmkpi/setting/baseinfo/instructor/edit', 'V_PERF_INSTRUCTOR', 's', '性别', 'SEX', 1, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('07E8401690AA4226B5B726D9565561FD', '/pmkpi/setting/baseinfo/instructor/edit', 'V_PERF_INSTRUCTOR', 's', '姓名', 'NAME', 1, null, 1, null, 2, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('5A50940D2ABA27B3CD4204FE61F56725', '/pmkpi/setting/baseinfo/instructor/edit', 'V_PERF_INSTRUCTOR', 's', '编码', 'CODE', 1, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('9C4B9180BD00CCBC0254C8B31984E006', '/pmkpi/setting/baseinfo/instructor/edit', 'V_PERF_INSTRUCTOR', 's', 'guid', 'GUID', 0, null, 1, null, 0, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('4AC052ADE004364BFA35789DA0269063', '/pmkpi/setting/baseinfo/instructor/edit', 'V_PERF_INSTRUCTOR', 's', '年度', 'YEAR', 0, null, 0, null, 20, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('2B1AEE2FFC9CECEFF68E49C069E1B000', '/pmkpi/setting/baseinfo/instructor/edit', 'V_PERF_INSTRUCTOR', 's', '区划', 'PROVINCE', 0, null, 0, null, 19, null, null, 'pmkpi', 1, null, '{}', null, null, null);




delete from p#busfw_t_uitabpage where key = '/pmkpi/setting/baseinfo/instructor/sxedit';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('750CB6814A1B862E8CFBFFACB1E9123F', 'pmkpi', '/pmkpi/setting/baseinfo/instructor/sxedit', '附件管理', 'file', 1, 2, 'nomal', 'baseinfoedit.clickTabpage', null, '附件管理', null, '保存', '{url:''/pmkpi/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4ACC82C760EF2AFCE800BA76A2AFB0F', 'pmkpi', '/pmkpi/setting/baseinfo/instructor/sxedit', '基本信息', 'datainfo', 1, 1, 'choosed', 'baseinfoedit.clickTabpage', null, '基本信息', null, null, '{}', null, '0', 'editform', null, null, null, null, null, null);




delete from p#busfw_t_uifunction where key = '/pmkpi/setting/baseinfo/instructor/edit';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('244E94199EF2918641139D47BC7174AF', '/pmkpi/setting/baseinfo/instructor/edit', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', 'cancle', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('92EF38A0021D77BDAC66E7BBDC9A58B9', '/pmkpi/setting/baseinfo/instructor/edit', '保存', 1, 1, 'Keepicon', 'baseinfoedit.infosave', null, '保存', 'pmkpi', 'infosave', null, null);



delete from p#busfw_t_uifunction where key = '/pmkpi/setting/baseinfo/intermediaryinfo' and guid in ('24CDD67591295D0E3E0B588B51E61FCC','D0FC39B522FF027074A6EF8A72F315B5');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('24CDD67591295D0E3E0B588B51E61FCC', '/pmkpi/setting/baseinfo/intermediaryinfo', '修改(山西)', 0, 6, 'Keepicon', 'baseinfo.sxupdate', null, '修改(山西)', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D0FC39B522FF027074A6EF8A72F315B5', '/pmkpi/setting/baseinfo/intermediaryinfo', '新增(山西)', 0, 5, 'Keepicon', 'baseinfo.sxadd', null, '新增(山西)', 'pmkpi', null, null, null);



delete from p#busfw_t_uieditform where key = '/pmkpi/setting/baseinfo/legalperson';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('0904D6C73AC0278AC75B0854C6BE1281', '/pmkpi/setting/baseinfo/legalperson', 'V_PERF_LEGALPERSON', 's', '移动电话', 'PHONE', 1, null, 0, null, 11, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('8FFF0D1164B981FB81E465D954FE2D53', '/pmkpi/setting/baseinfo/legalperson', 'V_PERF_LEGALPERSON', 's', '办公电话', 'TEL', 1, null, 0, null, 10, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('13257EEAAAF3478F4D8E578D5568F6CB', '/pmkpi/setting/baseinfo/legalperson', 'V_PERF_LEGALPERSON', 's', '电子信箱', 'EMAIL', 1, null, 0, null, 9, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('A79F83603D6EE674F7AC02DB27DAA7FF', '/pmkpi/setting/baseinfo/legalperson', 'V_PERF_LEGALPERSON', 's', '职称', 'OCCUPATION', 1, null, 1, null, 8, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('2C5C2E4444B4ED8B65A5962147A2E802', '/pmkpi/setting/baseinfo/legalperson', 'V_PERF_LEGALPERSON', 's', '职务', 'JOB', 1, null, 0, null, 7, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('A9F35DFE4612EB2E96B81B85645A3958', '/pmkpi/setting/baseinfo/legalperson', 'V_PERF_LEGALPERSON', 'tree', '政治面貌', 'POLITICAL', 1, null, 0, null, 6, null, null, 'pmkpi', 1, null, '{"format":"#code-#name"}', 0, 1, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('92A3C0A9B204B5AD04D5108AAF0F7C47', '/pmkpi/setting/baseinfo/legalperson', 'V_PERF_LEGALPERSON', 's', '专业', 'MAJOR', 1, null, 1, null, 5, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('E1BF69183F170E4F831052ACCD5D0A79', '/pmkpi/setting/baseinfo/legalperson', 'V_PERF_LEGALPERSON', 'tree', '学历', 'EDUCATION', 1, null, 1, null, 4, null, null, 'pmkpi', 1, null, '{"format":"#code-#name"}', 0, 1, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6930312D506A1E906AE94016FF9E42F7', '/pmkpi/setting/baseinfo/legalperson', 'V_PERF_LEGALPERSON', 's', '性别', 'SEX', 1, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('A7C27DC74E3DF8AD5859A84EF313523E', '/pmkpi/setting/baseinfo/legalperson', 'V_PERF_LEGALPERSON', 's', '姓名', 'NAME', 1, null, 1, null, 2, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('E1746355CB531ADF61B6223F74D466F6', '/pmkpi/setting/baseinfo/legalperson', 'V_PERF_LEGALPERSON', 's', 'mainguid', 'MAINGUID', 0, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('973D9A5C61226C11AE00164579405A49', '/pmkpi/setting/baseinfo/legalperson', 'V_PERF_LEGALPERSON', 's', 'guid', 'GUID', 0, null, 1, null, 0, null, null, 'pmkpi', 1, null, '{}', null, null, null);



delete from p#busfw_t_uifunction where key = '/pmkpi/setting/baseinfo/legalperson';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('FC94C6C3AA08234B9DFF41A61A25F38F', '/pmkpi/setting/baseinfo/legalperson', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', 'cancle', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('F8FFC8F056E35244C371F2ED85D06898', '/pmkpi/setting/baseinfo/legalperson', '保存', 1, 1, 'Keepicon', 'baseinfoedit.infosave', null, '保存', 'pmkpi', 'infosave', null, null);



delete from p#busfw_t_uitabpage where key = '/pmkpi/setting/baseinfo/intermediaryinfo/sxedit';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('DE6EBF8E721B1C63BC79362206FF3F8A', 'pmkpi', '/pmkpi/setting/baseinfo/intermediaryinfo/sxedit', '附件管理', 'file', 1, 8, 'nomal', 'baseinfoedit.clickTabpage', null, '附件管理', null, '保存', '{url:''/pmkpi/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('F038C58BE4A3121CF44CD4D1CF37EC8C', 'pmkpi', '/pmkpi/setting/baseinfo/intermediaryinfo/sxedit', '基本信息', 'datainfo', 1, 1, 'choosed', 'baseinfoedit.clickTabpage', null, '基本信息', null, null, '{}', null, '0', 'editform', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('F984B436F7B7D249A31AF3A3202C300C', 'pmkpi', '/pmkpi/setting/baseinfo/intermediaryinfo/sxedit', '法定代表人信息', 'legalpersoninfo', 1, 3, 'nomal', 'baseinfoedit.clickTabpage', null, '法定代表人信息', null, null, '{}', null, '0', 'legalpersoneditform', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('59781D55BF1D5286B53DD1483F2096D4', 'pmkpi', '/pmkpi/setting/baseinfo/intermediaryinfo/sxedit', '合作专家信息', 'expertinfo', 1, 6, 'nomal', 'baseinfoedit.clickTabpage', null, '合作专家信息', null, null, '{url:''/pmkpi/setting/baseinfo/expert.page?type=expert'',action:''reviewer.save''}', null, '0', 'expertinfoiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('E094DF41150A3873BE130F92EA876662', 'pmkpi', '/pmkpi/setting/baseinfo/intermediaryinfo/sxedit', '其他绩效评价从业人员信息', 'otheremploy', 1, 7, 'nomal', 'baseinfoedit.clickTabpage', null, '其他绩效评价从业人员信息', null, null, '{url:''/pmkpi/setting/baseinfo/otheremploy.page?type=otheremploy'',action:''reviewer.save''}', null, '0', 'otheremployiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('9B625D165A422DE6581F5EA8576856A6', 'pmkpi', '/pmkpi/setting/baseinfo/intermediaryinfo/sxedit', '分支机构信息(非独立法人机构)', 'branchinfo', 1, 5, 'nomal', 'baseinfoedit.clickTabpage', null, '分支机构信息(非独立法人机构)', null, null, '{url:''/pmkpi/setting/baseinfo/branch.page'',action:''reviewer.save''}', null, '0', 'branchinfoiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('F08713494CC3E333150E723CCC1576DC', 'pmkpi', '/pmkpi/setting/baseinfo/intermediaryinfo/sxedit', '主评人信息', 'mainreviewer', 1, 4, 'nomal', 'baseinfoedit.clickTabpage', null, '主评人信息', null, null, '{url:''/pmkpi/setting/baseinfo/mainreviewer.page?type=mainreviewer'',action:''reviewer.save''}', null, '0', 'mainrevieweriframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('0EEFDB305C3412A1E619007F2C3F011E', 'pmkpi', '/pmkpi/setting/baseinfo/intermediaryinfo/sxedit', '过去三年主要业绩(项目)', 'intermediaryfunds', 1, 2, 'nomal', 'baseinfoedit.clickTabpage', null, '过去三年主要业绩(项目)', null, null, '{url:''/pmkpi/setting/baseinfo/intermediaryfunds.page'',action:''reviewer.save''}', null, '0', 'fundsiframe', null, null, null, null, null, null);



delete from p#busfw_t_uitable where key = '/pmkpi/setting/baseinfo/intermediaryfunds';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('E5CEBA596CCEAAF79577A0046FB4904C', '/pmkpi/setting/baseinfo/intermediaryfunds', 'V_PERF_INTERMEDIARYFUNDS', 100, 0, 0, null, null, 'pmkpi', null);




delete from p#busfw_t_uicolumn where key = '/pmkpi/setting/baseinfo/intermediaryfunds';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('A68B0663C08D21B935393326D3CEBEEB', '/pmkpi/setting/baseinfo/intermediaryfunds', 'CATEGORY', '行业分类', 6, 1, 1, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('551F1CDEB4CEDF4EF7EB5B5083D1D154', '/pmkpi/setting/baseinfo/intermediaryfunds', 'CHARGE', '收费金额(万元)', 5, 1, 1, 1, '0', 0, 1, null, null, null, null, 150, 0, 'amt', '{}', '0');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('AF9DFCCFC52B9EC64CDF7343A3A561AE', '/pmkpi/setting/baseinfo/intermediaryfunds', 'CAPITALSCALE', '资金规模(万元)', 4, 1, 1, 1, '0', 0, 1, null, null, null, null, 150, 0, 'amt', '{}', '0');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CDF4FB26150492A1BD9A4DE0CC8AB2A9', '/pmkpi/setting/baseinfo/intermediaryfunds', 'PROJTYPE', '项目类别', 3, 1, 1, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('E4710D5431C89F96AEF38E558C19BCCE', '/pmkpi/setting/baseinfo/intermediaryfunds', 'PRONAME', '项目名称', 2, 1, 1, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('A405C416EA05DEEF0844263C21CBD647', '/pmkpi/setting/baseinfo/intermediaryfunds', 'MAINGUID', 'MAINGUID', 1, 0, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('FC31D8AA68D18E11BFAF6A5A0BB70E89', '/pmkpi/setting/baseinfo/intermediaryfunds', 'GUID', 'GUID', 0, 0, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);



delete from p#busfw_t_uitable where key = '/pmkpi/setting/baseinfo/mainreviewer';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('19E711B4DF5A63B81CF3EBAE27B04B1A', '/pmkpi/setting/baseinfo/mainreviewer', 'PERF_EVALUATOR', 0, 0, 0, null, ' and type = ''mainreviewer''', 'pmkpi', '{}');



delete from p#busfw_t_uicolumn where key = '/pmkpi/setting/baseinfo/mainreviewer';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('15849FE7CFF81137B6969366B525A1E4', '/pmkpi/setting/baseinfo/mainreviewer', 'EMAIL', '电子信箱', 11, 1, 1, 0, null, 1, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('878BE418896D0967E1934D91DE6474D4', '/pmkpi/setting/baseinfo/mainreviewer', 'PHONE', '移动电话', 10, 1, 1, 0, null, 1, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('3700AE71433867F292FCB2C78F023751', '/pmkpi/setting/baseinfo/mainreviewer', 'TEL', '办公电话', 9, 1, 1, 0, null, 1, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0C89EF34EC37664DD0CFA22F989033F0', '/pmkpi/setting/baseinfo/mainreviewer', 'MAJOR', '专业', 8, 1, 1, 0, null, 1, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('34005472C091ED9A46C56EF15C87A43A', '/pmkpi/setting/baseinfo/mainreviewer', 'OCCUPATION', '职称', 7, 1, 1, 0, null, 1, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('4A0BEC5A3FD6B5ADFA055CFE37B95719', '/pmkpi/setting/baseinfo/mainreviewer', 'JOB', '职务', 6, 1, 1, 0, null, 1, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('70E9317A9673CE3744E50080DAD8CD9B', '/pmkpi/setting/baseinfo/mainreviewer', 'POLITICAL', '政治面貌', 5, 1, 1, 0, null, 0, null, null, '#name', null, null, null, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9F56F55FCC3576F33363BB33BF092073', '/pmkpi/setting/baseinfo/mainreviewer', 'SEX', '性别', 4, 1, 1, 0, null, 1, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C4F939222ACE1748D684371CC6FBE941', '/pmkpi/setting/baseinfo/mainreviewer', 'NAME', '姓名', 3, 1, 1, 0, null, 1, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('063375B9F596239E3F0F72B2CEE37CF7', '/pmkpi/setting/baseinfo/mainreviewer', 'MAINGUID', 'MAINGUID', 2, 0, 1, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('F12476320CFE17D0297634735F86EF17', '/pmkpi/setting/baseinfo/mainreviewer', 'GUID', 'GUID', 1, 0, 1, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);



delete from p#busfw_t_uitable where key = '/pmkpi/setting/baseinfo/branch';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('157E069BFB1F4160A2B4A172D693C43D', '/pmkpi/setting/baseinfo/branch', 'PERF_BRANCH', 0, 0, 0, null, null, 'pmkpi', '{}');



delete from p#busfw_t_uicolumn where key = '/pmkpi/setting/baseinfo/branch';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('99DB23D12123B01262EC590B22DDF7E8', '/pmkpi/setting/baseinfo/branch', 'LINKMAN', '分支机构联系人', 4, 1, 1, 0, null, 1, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('3917D32B575D8A646CCABB5970625E9F', '/pmkpi/setting/baseinfo/branch', 'WORKPLACE', '分支机构办公场所', 5, 1, 1, 0, null, 1, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0833B081851AF601C1E7D834E0E05ED8', '/pmkpi/setting/baseinfo/branch', 'RANGE', '分支机构经营范围', 6, 1, 1, 0, null, 1, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1C09818AE2D1C6C218CB5B1FBB628F95', '/pmkpi/setting/baseinfo/branch', 'GUID', 'GUID', 1, 0, 1, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9871E1C7243A3D6201C2BA7A704C750', '/pmkpi/setting/baseinfo/branch', 'MAINGUID', 'MAINGUID', 2, 0, 1, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('A1251E4302140F74C62034077482D045', '/pmkpi/setting/baseinfo/branch', 'NAME', '分支机构名称', 3, 1, 1, 0, null, 1, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('6225761A55540C7A0647A6ED66ADFB1F', '/pmkpi/setting/baseinfo/branch', 'REVIEWERSUM', '绩效评价专业人员总数', 7, 1, 1, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('E2C4371315006412B923445C4AC265F6', '/pmkpi/setting/baseinfo/branch', 'EMAIL', '分支机构电子信箱', 8, 1, 1, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('4A6731B0A273FEC292B1FB332A1402EB', '/pmkpi/setting/baseinfo/branch', 'TEL', '分支机构办公电话', 9, 1, 1, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('4466BB58E3437F6A4E0BECAE7FC98D5E', '/pmkpi/setting/baseinfo/branch', 'FAX', '分支机构传真', 10, 1, 1, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);



delete from p#busfw_t_uitable where key = '/pmkpi/setting/baseinfo/expert';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('0ADE7A98C25198A3534D8C581F34646E', '/pmkpi/setting/baseinfo/expert', 'PERF_EVALUATOR', 0, 0, 0, null, ' and type = ''expert''', 'pmkpi', '{}');



delete from p#busfw_t_uicolumn where key = '/pmkpi/setting/baseinfo/expert';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('F7BBA0B6A93BA96BAB935EFBBAED6001', '/pmkpi/setting/baseinfo/expert', 'TEL', '办公电话', 10, 1, 1, 0, null, 1, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('91CE4F729CAAD89486DF6403D56BB3AF', '/pmkpi/setting/baseinfo/expert', 'PHONE', '移动电话', 11, 1, 1, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('951B782E62334D08B1E239930848B7D3', '/pmkpi/setting/baseinfo/expert', 'JOB', '职务', 8, 1, 1, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('E3DB591AA491E5441A901CB5F79C1C03', '/pmkpi/setting/baseinfo/expert', 'OCCUPATION', '职称', 9, 1, 1, 0, null, 1, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('F69AD20D2832FAEB469645030A161421', '/pmkpi/setting/baseinfo/expert', 'EMAIL', '电子信箱', 12, 1, 1, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B4CA2577A32F28CA0FC175ED45114D0F', '/pmkpi/setting/baseinfo/expert', 'WORKPLACE', '所在单位', 13, 1, 1, 0, null, 1, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('36E00013509AAB09193F43CFE9D10684', '/pmkpi/setting/baseinfo/expert', 'POLITICAL', '政治面貌', 6, 1, 1, 0, null, 0, null, null, '#name', null, null, null, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('EA9CCA06C5BF86F2522E0441667EF9C6', '/pmkpi/setting/baseinfo/expert', 'SEX', '性别', 4, 1, 1, 0, null, 1, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2809BC28BC3BFD38278FD50978F91244', '/pmkpi/setting/baseinfo/expert', 'NAME', '姓名', 3, 1, 1, 0, null, 1, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('AC8CEE71C6FF3530146AD8B1B1E96C94', '/pmkpi/setting/baseinfo/expert', 'MAINGUID', 'MAINGUID', 2, 0, 1, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('ECB94E372BFF7AB673C2DCA37EF6AAAD', '/pmkpi/setting/baseinfo/expert', 'GUID', 'GUID', 1, 0, 1, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('5583E73F3FFE6475AF290F3788175D51', '/pmkpi/setting/baseinfo/expert', 'NATIONALITY', '国籍', 5, 1, 1, 0, null, 1, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('FCB93FCC6CC215EDD62641B3ED3AB7AD', '/pmkpi/setting/baseinfo/expert', 'EDUCATION', '学历', 7, 1, 1, 0, null, 0, null, null, '#name', null, null, null, 1, 'tree', null, null);



delete from p#busfw_t_uitable where key = '/pmkpi/setting/baseinfo/otheremploy';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('4BC5BD09C1052B0A550727276B1FD26D', '/pmkpi/setting/baseinfo/otheremploy', 'PERF_EVALUATOR', 0, 0, 0, null, ' and type = ''otheremploy''', 'pmkpi', '{}');



delete from p#busfw_t_uicolumn where key = '/pmkpi/setting/baseinfo/otheremploy';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('29116FE2D684DFE51B7F8D7049686E9B', '/pmkpi/setting/baseinfo/otheremploy', 'OCCUPATION', '职称', 9, 1, 1, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('F68AE1A838E8E6EB606520CAC3DC25D8', '/pmkpi/setting/baseinfo/otheremploy', 'JOB', '职务', 8, 1, 1, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('007703D737B18BB280AF19973427640E', '/pmkpi/setting/baseinfo/otheremploy', 'POLITICAL', '政治面貌', 5, 1, 1, 0, null, 0, null, null, '#name', null, null, null, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B344FEAD24FFE441C8A372C679305DAE', '/pmkpi/setting/baseinfo/otheremploy', 'SEX', '性别', 4, 1, 1, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('447E9CA9EF50B5F00E733D8E08BA7138', '/pmkpi/setting/baseinfo/otheremploy', 'NAME', '姓名', 3, 1, 1, 0, null, 1, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('83ED70CAFE95DB875FC59E92129D2626', '/pmkpi/setting/baseinfo/otheremploy', 'MAINGUID', 'MAINGUID', 2, 0, 1, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD09EFA9260B7AE35D414D8586C566D1', '/pmkpi/setting/baseinfo/otheremploy', 'GUID', 'GUID', 1, 0, 1, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFE8FFD32185A8A8FF87EEDEC22AD581', '/pmkpi/setting/baseinfo/otheremploy', 'EDUCATION', '学历', 6, 1, 1, 0, null, 0, null, null, '#name', null, null, null, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CBC78188B7A35035AE0F97BB10F54B9B', '/pmkpi/setting/baseinfo/otheremploy', 'MAJOR', '专业', 7, 1, 1, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);
