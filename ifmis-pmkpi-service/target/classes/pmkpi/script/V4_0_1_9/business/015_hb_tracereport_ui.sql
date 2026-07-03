begin
  
DELETE FROM Busfw_t_Uifunction t where t.key='/pmkpi/hbtracereport/upload/index';
insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DAD77BF4F67B48D0A1EF9B974BDDAE69', '/pmkpi/hbtracereport/upload/index', '填报/修改', 1, 2, 'searchicon', 'hbtracereportupload.add', null, '填报/修改', 'pmkpi', 'save', null, '{}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('F38A26AE9ECE4C0EABE1FC06DEAEC9F2', '/pmkpi/hbtracereport/upload/index', '删除', 1, 3, 'searchicon', 'hbtracereportupload.del', null, '删除', 'pmkpi', 'del', null, '{}');


DELETE FROM Busfw_t_Uiqueryform t where t.key='/pmkpi/hbtracereport/upload/index';
insert into Busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('7B00BA746EDF411098FB914D219F47F8', '/pmkpi/hbtracereport/upload/index', 'NAME', '名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_HBTRACEREPORTUPLOAD', null, null);


DELETE FROM Busfw_t_Uitable t where t.key='/pmkpi/hbtracereport/upload/index';
insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('D651C5FE1F5442CB8150431B4DE77366', '/pmkpi/hbtracereport/upload/index', 'V_PERF_T_HBTRACEREPORTUPLOAD', 0, 0, 0, null, null, 'pmkpi', null);


DELETE FROM Busfw_t_Uicolumn t where t.key='/pmkpi/hbtracereport/upload/index';
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1CF3F2EBC82E49A9A16B26255541EAB2', '/pmkpi/hbtracereport/upload/index', 'CREATETIME', '创建人', 6, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('47B4D3289CAF47049FDE9D09D5555A68', '/pmkpi/hbtracereport/upload/index', 'GUID', 'guid', 1, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D692FC79427A49FE8BE88664A3CA3BDF', '/pmkpi/hbtracereport/upload/index', 'LINKMAN', '联系人', 4, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('042B5CFD3ACB4DE69E586836BC77F6A1', '/pmkpi/hbtracereport/upload/index', 'NAME', '名称', 3, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('3786EC9E7A464E7CA23DAAAE721794BE', '/pmkpi/hbtracereport/upload/index', 'TELEPHONE', '联系电话', 5, 1, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

---

DELETE FROM Busfw_t_Uieditform t where t.key='/pmkpi/hbtracereport/upload/edit';
insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('88EDD565830F493A84CC8CF6200B8CE8', '/pmkpi/hbtracereport/upload/edit', 'V_PERF_T_HBTRACEREPORTUPLOAD', 's', '联系电话', 'TELEPHONE', 1, null, 0, null, 4, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('D4D141517A684EC495DD0D011D917CE3', '/pmkpi/hbtracereport/upload/edit', 'V_PERF_T_HBTRACEREPORTUPLOAD', 's', '部门名称', 'NAME', 1, null, 0, null, 2, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('502D30CA386840269F6EE7D714BC3A1E', '/pmkpi/hbtracereport/upload/edit', 'V_PERF_T_HBTRACEREPORTUPLOAD', 's', '主键', 'GUID', 0, null, 0, null, 5, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('AC3F11CD1255403C9C7243F498436E9A', '/pmkpi/hbtracereport/upload/edit', 'V_PERF_T_HBTRACEREPORTUPLOAD', 's', '部门编号', 'CODE', 1, null, 1, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('8A4A68B2AF2641D5809231B949C37154', '/pmkpi/hbtracereport/upload/edit', 'V_PERF_T_HBTRACEREPORTUPLOAD', 's', '联系人', 'LINKMAN', 1, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('11C644E003584273A5DDE81651862017', '/pmkpi/hbtracereport/upload/edit', 'V_PERF_T_HBTRACEREPORTUPLOAD', 'tree', '监控任务', 'TASKGUID', 1, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{format:''#name''}', null, null, null);


DELETE FROM Busfw_t_Uifunction t where t.key='/pmkpi/hbtracereport/upload/edit';
insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('2CEB0117BDF7461CB86C0EA11E2F0A94', '/pmkpi/hbtracereport/upload/edit', '保存', 1, 1, 'Keepicon', 'hbtracereportedit.infosave', null, '保存', 'pmkpi', null, null, null);

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('8F37F34DCB434A409CB17D71FF271DF9', '/pmkpi/hbtracereport/upload/edit', '取消', 1, 2, 'Nofinishicon', 'hbtracereportedit.close', null, '取消', 'pmkpi', null, null, null);


DELETE FROM Busfw_t_Uitabpage t where t.key='/pmkpi/hbtracereport/upload/edit';
insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('616A1540EAA44AC0BC5EAC3A83884C7E', 'pmkpi', '/pmkpi/hbtracereport/upload/edit', '监控汇总资料', 'file', 1, 2, 'nomal', 'hbtracereportedit.clickTabpage', null, '附件管理', null, '保存', '{filebustype:''hbtracereportupload'',url:''/pmkpi/upload/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C0D2429884F04BFC94C0D75A09CE2A9E', 'pmkpi', '/pmkpi/hbtracereport/upload/edit', '基本信息', 'deptinfo', 1, 1, 'choosed', 'hbtracereportedit.clickTabpage', null, '部门基本信息', null, null, '{busguid:''FB89D249B8094C009B9FEB9C680A46A5''}', null, '0', 'formaleditform', null, null, null, null, null, null);



DELETE FROM Busfw_t_Uifunction t WHERE t.key='/pmkpi/hbtracereport/upload/query';
insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('59EEC92BEFA84176AF0D7AA7E414E8BD', '/pmkpi/hbtracereport/upload/query', '批量下载', 1, 3, 'searchicon', 'hbtracereportquery.batchdownload', null, '批量下载', 'pmkpi', 'batchdownload', null, '{}');

DELETE FROM Busfw_t_Uiqueryform t WHERE t.key='/pmkpi/hbtracereport/upload/query';
insert into Busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('8B53E7EB53A74F75B19C8DE640489F18', '/pmkpi/hbtracereport/upload/query', 'NAME', '名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_HBTRACEREPORTUPLOAD', null, null);

DELETE FROM Busfw_t_Uitable t WHERE t.key='/pmkpi/hbtracereport/upload/query';
insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('79B20542196F43ED9A0DD66F3A27897B', '/pmkpi/hbtracereport/upload/query', 'V_PERF_T_HBTRACEREPORTUPLOAD', 0, 0, 0, null, null, 'pmkpi', null);

DELETE FROM Busfw_t_Uicolumn t WHERE t.key='/pmkpi/hbtracereport/upload/query';
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1BE78069B8384C40ACEEC99CD219745E', '/pmkpi/hbtracereport/upload/query', 'CREATETIME', '创建人', 6, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9B04108C7D014C0BBA0A7BA73F5A3E6D', '/pmkpi/hbtracereport/upload/query', 'GUID', 'guid', 1, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('7AC203D919F04E548DDBF542EBFF76ED', '/pmkpi/hbtracereport/upload/query', 'LINKMAN', '联系人', 4, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1C06BADF137C484DA7F3824D679D1FEF', '/pmkpi/hbtracereport/upload/query', 'NAME', '名称', 3, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('313B0B90B0BA431EA7F73795AF5E41E8', '/pmkpi/hbtracereport/upload/query', 'TELEPHONE', '联系电话', 5, 1, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);



