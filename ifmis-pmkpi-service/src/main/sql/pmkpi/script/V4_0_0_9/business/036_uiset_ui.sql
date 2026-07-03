begin
  
--编辑区
DELETE FROM P#Busfw_t_uifunction t where t.key='/pmkpi/set/uieditformcols/edit';
insert into Busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BFC3074692CF14ABE053B11FA8C0D098', '/pmkpi/set/uieditformcols/edit', '保存', 1, 1, 'Keepicon', 'pmkpiuiset.save', null, '保存', 'pmkpi', 'save', null, null);

DELETE FROM P#BUSFW_T_UITABLE t where t.key='/pmkpi/set/uieditformcols/edit';
insert into BUSFW_T_UITABLE (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BFC3074692D014ABE053B11FA8C0D098', '/pmkpi/set/uieditformcols/edit', 'BUSFW_T_UIEDITFORM', 100, null, null, null, null, 'pmkpi', null);

DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/set/uieditformcols/edit';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC30746939614ABE053B11FA8C0D098', '/pmkpi/set/uieditformcols/edit', 'GUID', '主键', 1, 0, 0, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC30746939814ABE053B11FA8C0D098', '/pmkpi/set/uieditformcols/edit', 'TABLECODE', '表名', 3, 1, 0, null, null, 1, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC30746939914ABE053B11FA8C0D098', '/pmkpi/set/uieditformcols/edit', 'COLUMNCODE', '字段', 4, 1, 1, null, null, 1, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC30746939C14ABE053B11FA8C0D098', '/pmkpi/set/uieditformcols/edit', 'ISEDIT', '是否可编辑', 7, 1, 1, null, null, 1, null, null, null, null, null, null, 1, 'tree', '{format:''#code-#name''}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC30746939D14ABE053B11FA8C0D098', '/pmkpi/set/uieditformcols/edit', 'ISVISIABLE', '是否显示', 8, 1, 1, null, null, 1, null, null, null, null, null, null, 1, 'tree', '{format:''#code-#name''}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC30746939714ABE053B11FA8C0D098', '/pmkpi/set/uieditformcols/edit', 'KEY', '页面KEY', 2, 1, 0, null, null, 1, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC30746939A14ABE053B11FA8C0D098', '/pmkpi/set/uieditformcols/edit', 'NAME', '字段名称', 5, 1, 1, null, null, 1, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC30746939E14ABE053B11FA8C0D098', '/pmkpi/set/uieditformcols/edit', 'REQUIREMENT', '是否必填', 9, 1, 1, null, null, 1, null, null, null, null, null, null, 1, 'tree', '{format:''#code-#name''}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC30746939B14ABE053B11FA8C0D098', '/pmkpi/set/uieditformcols/edit', 'TYPE', '类型', 6, 1, 1, null, null, 1, null, null, null, null, null, null, 1, 'tree', '{format:''#code-#name''}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC3074693A114ABE053B11FA8C0D098', '/pmkpi/set/uieditformcols/edit', 'DEFAULTVALUE', '默认值', 12, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC3074693A214ABE053B11FA8C0D098', '/pmkpi/set/uieditformcols/edit', 'TEXTAREAROWS', '行数', 13, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC3074693A314ABE053B11FA8C0D098', '/pmkpi/set/uieditformcols/edit', 'COLSPANNUM', '列数', 14, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC3074693A814ABE053B11FA8C0D098', '/pmkpi/set/uieditformcols/edit', 'APPID', '系统标识', 19, 1, 0, null, null, 1, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC3074693A514ABE053B11FA8C0D098', '/pmkpi/set/uieditformcols/edit', 'SHOWLEVEL', '显示级次', 16, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC3074693A614ABE053B11FA8C0D098', '/pmkpi/set/uieditformcols/edit', 'SETVALUE', 'SETVALUE', 17, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC3074693A414ABE053B11FA8C0D098', '/pmkpi/set/uieditformcols/edit', 'FROMSOURCE', '否顺向细化', 15, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC3074693A714ABE053B11FA8C0D098', '/pmkpi/set/uieditformcols/edit', 'BOTTOMCONTRL', '是否未级控制', 18, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC30746939F14ABE053B11FA8C0D098', '/pmkpi/set/uieditformcols/edit', 'CONFIG', '配置', 10, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC3074693A014ABE053B11FA8C0D098', '/pmkpi/set/uieditformcols/edit', 'ORDERNUM', '排序', 11, 1, 1, null, null, 1, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFFDABD6B410367EE053470A050A2333', '/pmkpi/set/uieditformcols/edit', 'LEVELCONTROL', 'LEVELCONTROL', 20, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

--按钮
DELETE FROM P#Busfw_t_uifunction t where t.key='/pmkpi/set/uifunctioncols/edit';
insert into Busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BFC74849D95A76BAE053B11FA8C0B981', '/pmkpi/set/uifunctioncols/edit', '保存', 1, 1, 'Keepicon', 'pmkpiuiset.save', null, '保存', 'pmkpi', 'save', null, null);


DELETE FROM P#BUSFW_T_UITABLE t where t.key='/pmkpi/set/uifunctioncols/edit';
insert into BUSFW_T_UITABLE (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BFC74849D95B76BAE053B11FA8C0B981', '/pmkpi/set/uifunctioncols/edit', 'BUSFW_T_UIFUNCTION', 100, null, null, null, null, 'pmkpi', null);


DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/set/uifunctioncols/edit';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC76D2CA8977B5CE053B11FA8C0C4A1', '/pmkpi/set/uifunctioncols/edit', 'GUID', '主键', 1, 0, 0, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC76D2CA8997B5CE053B11FA8C0C4A1', '/pmkpi/set/uifunctioncols/edit', 'CODE', '编码', 3, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC76D2CA89D7B5CE053B11FA8C0C4A1', '/pmkpi/set/uifunctioncols/edit', 'CLASSNAME', '样式', 7, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC76D2CA89F7B5CE053B11FA8C0C4A1', '/pmkpi/set/uifunctioncols/edit', 'PARAM', '参数', 9, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC76D2CA8A07B5CE053B11FA8C0C4A1', '/pmkpi/set/uifunctioncols/edit', 'CONFIG', '配置', 10, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC76D2CA8A27B5CE053B11FA8C0C4A1', '/pmkpi/set/uifunctioncols/edit', 'APPID', '系统标识', 13, 1, 0, null, null, 1, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC74849D96876BAE053B11FA8C0B981', '/pmkpi/set/uifunctioncols/edit', 'ORDERNUM', '排序', 12, 1, 1, null, null, 1, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC76D2CA89C7B5CE053B11FA8C0C4A1', '/pmkpi/set/uifunctioncols/edit', 'ISVISIABLE', '是否显示', 6, 1, 1, null, null, 1, null, null, null, null, null, null, 1, 'tree', '{format:''#code-#name''}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC76D2CA8987B5CE053B11FA8C0C4A1', '/pmkpi/set/uifunctioncols/edit', 'KEY', '页面KEY', 2, 1, 0, null, null, 1, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC76D2CA89A7B5CE053B11FA8C0C4A1', '/pmkpi/set/uifunctioncols/edit', 'NAME', '按钮名称', 4, 1, 1, null, null, 1, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC76D2CA89B7B5CE053B11FA8C0C4A1', '/pmkpi/set/uifunctioncols/edit', 'TITLE', '显示名称', 5, 1, 1, null, null, 1, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC76D2CA89E7B5CE053B11FA8C0C4A1', '/pmkpi/set/uifunctioncols/edit', 'ACTION', '事件', 8, 1, 1, null, null, 1, null, null, null, null, null, null, null, 's', null, null);


--页签
DELETE FROM P#Busfw_t_uifunction t where t.key='/pmkpi/set/uitabcols/edit';
insert into Busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BFC74849D96976BAE053B11FA8C0B981', '/pmkpi/set/uitabcols/edit', '保存', 1, 1, 'Keepicon', 'pmkpiuiset.save', null, '保存', 'pmkpi', 'save', null, null);


DELETE FROM P#BUSFW_T_UITABLE t where t.key='/pmkpi/set/uitabcols/edit';
insert into BUSFW_T_UITABLE (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BFC74849D96A76BAE053B11FA8C0B981', '/pmkpi/set/uitabcols/edit', 'BUSFW_T_UITABPAGE', 100, null, null, null, null, 'pmkpi', null);


DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/set/uitabcols/edit';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC7ED63A97D8EC3E053B11FA8C04DF2', '/pmkpi/set/uitabcols/edit', 'GUID', '主键', 1, 0, 0, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC7ED63A97F8EC3E053B11FA8C04DF2', '/pmkpi/set/uitabcols/edit', 'CODE', '编码', 3, 1, 0, null, null, 1, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC7ED63A9828EC3E053B11FA8C04DF2', '/pmkpi/set/uitabcols/edit', 'ISVISIABLE', '是否显示', 6, 1, 1, null, null, 1, null, null, null, null, null, null, 1, 'tree', '{format:''#code-#name''}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC7ED63A97E8EC3E053B11FA8C04DF2', '/pmkpi/set/uitabcols/edit', 'KEY', '页面KEY', 2, 1, 0, null, null, 1, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC7ED63A9808EC3E053B11FA8C04DF2', '/pmkpi/set/uitabcols/edit', 'NAME', '页签名称', 4, 1, 1, null, null, 1, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC7ED63A9848EC3E053B11FA8C04DF2', '/pmkpi/set/uitabcols/edit', 'FILTER', '过滤条件', 8, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC7ED63A9818EC3E053B11FA8C04DF2', '/pmkpi/set/uitabcols/edit', 'TITLE', '显示名称', 5, 1, 1, null, null, 1, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC7ED63A9888EC3E053B11FA8C04DF2', '/pmkpi/set/uitabcols/edit', 'APPID', '系统标识', 12, 1, 0, null, null, 1, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC7ED63A9858EC3E053B11FA8C04DF2', '/pmkpi/set/uitabcols/edit', 'CONFIG', '属性', 9, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC7ED63A9878EC3E053B11FA8C04DF2', '/pmkpi/set/uitabcols/edit', 'ORDERNUM', '排序', 11, 1, 1, null, null, 1, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC7ED63A9868EC3E053B11FA8C04DF2', '/pmkpi/set/uitabcols/edit', 'DISABLED', '是否可用', 10, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFC7ED63A9838EC3E053B11FA8C04DF2', '/pmkpi/set/uitabcols/edit', 'HIDEBTNS', '隐藏按钮', 7, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFFDA18348B71E0AE053B11FA8C03A97', '/pmkpi/set/uitabcols/edit', 'COMPONENTID', '组件ID', 13, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFFDA18348B81E0AE053B11FA8C03A97', '/pmkpi/set/uitabcols/edit', 'WFSTATUS', '工作流状态', 14, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFFDA18348B91E0AE053B11FA8C03A97', '/pmkpi/set/uitabcols/edit', 'CLASSNAME', '样式名称', 15, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFFDA18348BA1E0AE053B11FA8C03A97', '/pmkpi/set/uitabcols/edit', 'CLICK', '点击', 16, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFFDA18348BB1E0AE053B11FA8C03A97', '/pmkpi/set/uitabcols/edit', 'WAITFLAG', '是否待办', 17, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFFDA18348BC1E0AE053B11FA8C03A97', '/pmkpi/set/uitabcols/edit', 'DEFAULTFILTER', '默认值', 18, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);


--查询区
DELETE FROM P#Busfw_t_uifunction t where t.key='/pmkpi/set/uiqueryformcols/edit';
insert into Busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BFD1CC24687DD987E053B11FA8C0461F', '/pmkpi/set/uiqueryformcols/edit', '保存', 1, 1, 'Keepicon', 'pmkpiuiset.save', null, '保存', 'pmkpi', 'save', null, null);


DELETE FROM P#BUSFW_T_UITABLE t where t.key='/pmkpi/set/uiqueryformcols/edit';
insert into BUSFW_T_UITABLE (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BFD1CC24687ED987E053B11FA8C0461F', '/pmkpi/set/uiqueryformcols/edit', 'BUSFW_T_UIQUERYFORM', 100, null, null, null, null, 'pmkpi', null);


DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/set/uiqueryformcols/edit';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC96255DB72E053B11FA8C0A1DD', '/pmkpi/set/uiqueryformcols/edit', 'BOTTOMCONTRL', '是否未级控制', 10, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC96257DB72E053B11FA8C0A1DD', '/pmkpi/set/uiqueryformcols/edit', 'LINKCHILD', '下级', 12, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC96256DB72E053B11FA8C0A1DD', '/pmkpi/set/uiqueryformcols/edit', 'LINKPARENT', '上级', 11, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC9624DDB72E053B11FA8C0A1DD', '/pmkpi/set/uiqueryformcols/edit', 'GUID', '主键', 1, 0, 0, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC9624FDB72E053B11FA8C0A1DD', '/pmkpi/set/uiqueryformcols/edit', 'TABLECODE', '表名', 3, 1, 1, null, null, 1, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC96250DB72E053B11FA8C0A1DD', '/pmkpi/set/uiqueryformcols/edit', 'COLUMNCODE', '字段', 4, 1, 1, null, null, 1, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC96253DB72E053B11FA8C0A1DD', '/pmkpi/set/uiqueryformcols/edit', 'ISVISIABLE', '是否显示', 8, 1, 1, null, null, 1, null, null, null, null, null, null, 1, 'tree', '{format:''#code-#name''}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC9624EDB72E053B11FA8C0A1DD', '/pmkpi/set/uiqueryformcols/edit', 'KEY', '页面KEY', 2, 1, 0, null, null, 1, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC96251DB72E053B11FA8C0A1DD', '/pmkpi/set/uiqueryformcols/edit', 'NAME', '名称', 5, 1, 1, null, null, 1, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC96254DB72E053B11FA8C0A1DD', '/pmkpi/set/uiqueryformcols/edit', 'DEFAULTVALUE', '默认值', 9, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC96252DB72E053B11FA8C0A1DD', '/pmkpi/set/uiqueryformcols/edit', 'TYPE', '类型', 6, 1, 1, null, null, 1, null, null, null, null, null, null, 1, 'tree', '{format:''#code-#name''}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC9625ADB72E053B11FA8C0A1DD', '/pmkpi/set/uiqueryformcols/edit', 'APPID', '系统标识', 15, 1, 0, null, null, 1, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC96258DB72E053B11FA8C0A1DD', '/pmkpi/set/uiqueryformcols/edit', 'CONFIG', '属性', 13, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC96259DB72E053B11FA8C0A1DD', '/pmkpi/set/uiqueryformcols/edit', 'ORDERNUM', '排序', 14, 1, 1, null, null, 1, null, null, null, null, null, null, null, 's', null, null);


--表格
DELETE FROM P#Busfw_t_uifunction t where t.key='/pmkpi/set/uidatatablecols/edit';
insert into Busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BFD1CC24688BD987E053B11FA8C0461F', '/pmkpi/set/uidatatablecols/edit', '保存', 1, 1, 'Keepicon', 'pmkpiuiset.save', null, '保存', 'pmkpi', 'save', null, null);


DELETE FROM P#busfw_t_Uieditform t where t.key='/pmkpi/set/uidatatablecols/edit';
insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BFD1DBC96273DB72E053B11FA8C0A1DD', '/pmkpi/set/uidatatablecols/edit', 'BUSFW_T_UITABLE', 's', '系统标识', 'APPID', 1, null, 1, null, 9, null, null, null, 0, null, null, null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BFD1DBC96274DB72E053B11FA8C0A1DD', '/pmkpi/set/uidatatablecols/edit', 'BUSFW_T_UITABLE', 's', '配置信息', 'CONFIG', 1, null, 0, null, 5, null, null, null, 1, null, null, null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BFD1DBC96275DB72E053B11FA8C0A1DD', '/pmkpi/set/uidatatablecols/edit', 'BUSFW_T_UITABLE', 's', '条件', 'DEFQUERY', 1, null, 0, null, 4, null, null, null, 1, null, null, null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BFD1DBC96276DB72E053B11FA8C0A1DD', '/pmkpi/set/uidatatablecols/edit', 'BUSFW_T_UITABLE', 's', '标识', 'GUID', 0, null, 1, null, 0, null, null, null, 0, null, null, null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BFD1DBC96277DB72E053B11FA8C0A1DD', '/pmkpi/set/uidatatablecols/edit', 'BUSFW_T_UITABLE', 's', '页面KEY', 'KEY', 1, null, 1, null, 1, null, null, null, 0, null, null, null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BFD1DBC96278DB72E053B11FA8C0A1DD', '/pmkpi/set/uidatatablecols/edit', 'BUSFW_T_UITABLE', 's', 'LOCKNUM', 'LOCKNUM', 1, null, 0, null, 2, null, null, null, 1, null, null, null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BFD1DBC96279DB72E053B11FA8C0A1DD', '/pmkpi/set/uidatatablecols/edit', 'BUSFW_T_UITABLE', 's', '排序字段', 'ORDERBY', 1, null, 1, null, 6, null, null, null, 1, null, null, null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BFD1DBC9627ADB72E053B11FA8C0A1DD', '/pmkpi/set/uidatatablecols/edit', 'BUSFW_T_UITABLE', 's', '分页条数', 'PAGENUM', 1, null, 0, null, 7, null, null, null, 1, null, null, null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BFD1DBC9627BDB72E053B11FA8C0A1DD', '/pmkpi/set/uidatatablecols/edit', 'BUSFW_T_UITABLE', 's', '表名称', 'TABLECODE', 1, null, 1, null, 3, null, null, null, 1, null, null, null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BFD1DBC9627CDB72E053B11FA8C0A1DD', '/pmkpi/set/uidatatablecols/edit', 'BUSFW_T_UITABLE', 's', 'TOTALTAG', 'TOTALTAG', 1, null, 0, null, 8, null, null, null, 1, null, null, null, null, null);


DELETE FROM P#BUSFW_T_UITABLE t where t.key='/pmkpi/set/uidatatablecols/edit';
insert into BUSFW_T_UITABLE (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BFD1CC24688CD987E053B11FA8C0461F', '/pmkpi/set/uidatatablecols/edit', 'BUSFW_T_UICOLUMN', 100, null, null, null, null, 'pmkpi', null);


DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/set/uidatatablecols/edit';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC9626BDB72E053B11FA8C0A1DD', '/pmkpi/set/uidatatablecols/edit', 'KEY', 'key', 2, 1, 0, null, null, 1, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC9626CDB72E053B11FA8C0A1DD', '/pmkpi/set/uidatatablecols/edit', 'LEVELCONTROL', '级次', 13, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC9626DDB72E053B11FA8C0A1DD', '/pmkpi/set/uidatatablecols/edit', 'NAME', '名称', 4, 1, 1, null, null, 1, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC9626EDB72E053B11FA8C0A1DD', '/pmkpi/set/uidatatablecols/edit', 'ORDERNUM', '排序', 19, 1, 1, null, null, 1, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC9626FDB72E053B11FA8C0A1DD', '/pmkpi/set/uidatatablecols/edit', 'REQUIREMENT', '是否必填', 8, 1, 1, null, null, 1, null, null, null, null, null, null, 1, 'tree', '{format:''#code-#name''}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC96270DB72E053B11FA8C0A1DD', '/pmkpi/set/uidatatablecols/edit', 'SHOWLEVEL', '显示级次', 14, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC96271DB72E053B11FA8C0A1DD', '/pmkpi/set/uidatatablecols/edit', 'TOTALTAG', '合计', 15, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC96272DB72E053B11FA8C0A1DD', '/pmkpi/set/uidatatablecols/edit', 'TYPE', '来源类型', 5, 1, 1, null, null, 0, null, null, null, null, null, null, 1, 'tree', '{format:''#code-#name''}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC9625FDB72E053B11FA8C0A1DD', '/pmkpi/set/uidatatablecols/edit', 'BOTTOMCONTRL', '是否未级控制', 17, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC96260DB72E053B11FA8C0A1DD', '/pmkpi/set/uidatatablecols/edit', 'COLTYPE', '列字段类型', 20, 1, 1, null, null, 1, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC96261DB72E053B11FA8C0A1DD', '/pmkpi/set/uidatatablecols/edit', 'COLUMNCODE', '列字段', 3, 1, 1, null, null, 1, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC96262DB72E053B11FA8C0A1DD', '/pmkpi/set/uidatatablecols/edit', 'COLWIDTH', '列宽度', 12, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC96263DB72E053B11FA8C0A1DD', '/pmkpi/set/uidatatablecols/edit', 'CONFIG', '配置信息', 18, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC96264DB72E053B11FA8C0A1DD', '/pmkpi/set/uidatatablecols/edit', 'DEFAULTVALUE', '默认值', 11, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC96265DB72E053B11FA8C0A1DD', '/pmkpi/set/uidatatablecols/edit', 'FORMAT', '显示格式', 10, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC96266DB72E053B11FA8C0A1DD', '/pmkpi/set/uidatatablecols/edit', 'GUID', '标识', 1, 0, 0, null, null, 1, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC96267DB72E053B11FA8C0A1DD', '/pmkpi/set/uidatatablecols/edit', 'HEAD', '父级表头', 16, 1, 1, null, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC96268DB72E053B11FA8C0A1DD', '/pmkpi/set/uidatatablecols/edit', 'ISEDIT', '是否可编辑', 6, 1, 1, null, null, 1, null, null, null, null, null, null, 1, 'tree', '{format:''#code-#name''}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC96269DB72E053B11FA8C0A1DD', '/pmkpi/set/uidatatablecols/edit', 'ISSOURCE', '是否有来源', 9, 1, 1, null, null, 0, null, null, null, null, null, null, 1, 'tree', '{format:''#code-#name''}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BFD1DBC9626ADB72E053B11FA8C0A1DD', '/pmkpi/set/uidatatablecols/edit', 'ISVISIABLE', '是否显示', 7, 1, 1, null, null, 1, null, null, null, null, null, null, 1, 'tree', '{format:''#code-#name''}', null);
