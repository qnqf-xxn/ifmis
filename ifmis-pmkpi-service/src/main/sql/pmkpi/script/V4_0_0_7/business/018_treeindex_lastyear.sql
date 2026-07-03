begin
  
DELETE FROM bus_t_pageconsolecomconfig t where t.url='/pmkpi/program/prjindex/lastyear';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/lastyear', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/lastyear', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:true}', 'lasttable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/lastyear', 'pmkpi_lastyear', '{}', 'pmkpilastyear', 'pmkpi', null);


DELETE FROM p#Busfw_t_Uitable t where t.key='/pmkpi/program/prjindex/lastyear';
insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('prjindex/lastyear090203', '/pmkpi/program/prjindex/lastyear', 'PM_PERF_INDICATOR', 100, 0, 0, null, null, 'pmkpi', '{}');


DELETE FROM p#Busfw_t_Uicolumn t where t.key='/pmkpi/program/prjindex/lastyear';
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BDDC6C7273ADED37E053B11FA8C0DE0B', '/pmkpi/program/prjindex/lastyear', 'LEVELNO', '级次', 12, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BDDC6C7273AEED37E053B11FA8C0DE0B', '/pmkpi/program/prjindex/lastyear', 'EXPLAIN', '公式或说明', 4, 0, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BDDC6C7273AFED37E053B11FA8C0DE0B', '/pmkpi/program/prjindex/lastyear', 'SINDEX', '二级指标', 2, 1, 0, 0, null, 0, 6, null, '#name', null, null, 150, 1, 'tree', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BDDC6C7273B0ED37E053B11FA8C0DE0B', '/pmkpi/program/prjindex/lastyear', 'GUID', 'GUID', 25, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BDDC6C7273B1ED37E053B11FA8C0DE0B', '/pmkpi/program/prjindex/lastyear', 'FINDEX', '一级指标', 1, 1, 0, 0, null, 0, 6, null, '#name', null, null, 150, 1, 'tree', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BDDC6C7273B2ED37E053B11FA8C0DE0B', '/pmkpi/program/prjindex/lastyear', 'NAME', '指标名称', 3, 1, 0, 0, null, 1, 6, null, null, null, null, 150, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BDDC6C7273A5ED37E053B11FA8C0DE0B', '/pmkpi/program/prjindex/lastyear', 'KPI_CONTENT', '指标内容', 27, 0, 0, 0, null, 1, 6, null, null, null, null, 150, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BDDC6C7273A6ED37E053B11FA8C0DE0B', '/pmkpi/program/prjindex/lastyear', 'KPI_EVALSTD', '扣分标准', 28, 0, 0, 0, null, 1, 6, null, null, null, null, 150, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BDDC6C7273A7ED37E053B11FA8C0DE0B', '/pmkpi/program/prjindex/lastyear', 'KPI_REMARK', '备注', 29, 1, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BDDC6C7273A8ED37E053B11FA8C0DE0B', '/pmkpi/program/prjindex/lastyear', 'SUPERID', 'SUPERID', 26, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BDDC6C7273A9ED37E053B11FA8C0DE0B', '/pmkpi/program/prjindex/lastyear', 'INDEXVAL', '指标值', 10, 1, 0, 0, null, 1, 6, null, null, null, null, 150, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BDDC6C7273AAED37E053B11FA8C0DE0B', '/pmkpi/program/prjindex/lastyear', 'COMPUTESIGN', '计算符号', 9, 1, 0, 0, null, 1, 6, null, '#name', null, null, 100, 1, 'tree', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BDDC6C7273ABED37E053B11FA8C0DE0B', '/pmkpi/program/prjindex/lastyear', 'METERUNIT', '计量单位', 11, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BDDC6C7273ACED37E053B11FA8C0DE0B', '/pmkpi/program/prjindex/lastyear', 'WEIGHT', '权重', 16, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 'amt', null, null);
