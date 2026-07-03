begin
  --列表字段注册：添加支出项目类别、一级项目编码字段
  --自评任务布置列表
delete from p#busfw_t_uicolumn where key ='/pmkpi/perfself/taskmanage' and COLUMNCODE in('PROJECTKIND','PRO_LEVONE_CODE');  
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/taskmanage', 'PROJECTKIND', '支出项目类别', 14, 0, 0, 0, null, 0, 1, null, '#code-#name', null, null, 100, 1, 'tree', '{type:"program"}', null,  null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/taskmanage', 'PRO_LEVONE_CODE', '一级项目编码', 15, 0, 0, 0, null, 0, 1, null, '#code-#name', null, null, 100, 1, 'tree', '{type:"program"}', null,  null, null);


--自评列表
delete from p#busfw_t_uicolumn where key ='/pmkpi/perfself/query' and COLUMNCODE in('PROJECTKIND','PRO_LEVONE_CODE');  
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/query', 'PRO_LEVONE_CODE', '一级项目编码', 17, 0, 0, 0, null, 0, 1, null, '#code-#name', null, null, 100, 1, 's', '{type:"program"}', null,  null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/query', 'PROJECTKIND', '支出项目类别', 16, 0, 0, 0, null, 0, 1, null, '#code-#name', null, null, 100, 1, 's', '{type:"program"}', null,  null, null);


--调整列表
delete from p#busfw_t_uicolumn where key ='/pmkpi/adjust/report/list' and COLUMNCODE in('PROJECTKIND','PRO_LEVONE_CODE');  
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/adjust/report/list', 'PRO_LEVONE_CODE', '一级项目编码', 24, 0, 0, 0, null, null, 1, null, '#code-#name', null, null, 100, 1, 'tree', '{type:"program"}', null,  null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/adjust/report/list', 'PROJECTKIND', '支出项目类别', 23, 0, 0, 0, null, null, 1, null, '#code-#name', null, null, 100, 1, 'tree', '{type:"program"}', null,  null, null);


--年中追加填报列表
delete from p#busfw_t_uicolumn where key ='/pmkpi/midprogram/report/list' and COLUMNCODE in('PROJECTKIND','PRO_LEVONE_CODE');  
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/midprogram/report/list', 'PROJECTKIND', '支出项目类别', 16, 0, 0, null, null, null, 1, null, '#code-#name', null, null, null, 1, 'tree', '{}', null,  null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/midprogram/report/list', 'PRO_LEVONE_CODE', '一级项目编码', 17, 0, 0, null, null, null, 1, null, '#code-#name', null, null, null, 1, 'tree', '{}', null,  null, null);


--年中追加审核列表
delete from p#busfw_t_uicolumn where key ='/pmkpi/midprogram/report/audit' and COLUMNCODE in('PROJECTKIND','PRO_LEVONE_CODE');  
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/midprogram/report/audit', 'PRO_LEVONE_CODE', '一级项目编码', 17, 0, 0, null, null, null, 1, null, '#code-#name', null, null, null, 1, 'tree', '{}', null,  null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/midprogram/report/audit', 'PROJECTKIND', '支出项目类别', 16, 0, 0, null, null, null, 1, null, '#code-#name', null, null, null, 1, 'tree', '{}', null,  null, null);


--年中追加申报列表
delete from p#busfw_t_uicolumn where key ='/pmkpi/midprogram/query/list' and COLUMNCODE in('PROJECTKIND','PRO_LEVONE_CODE');  
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/midprogram/query/list', 'PRO_LEVONE_CODE', '一级项目编码', 17, 0, 0, null, null, null, 1, null, '#code-#name', null, null, null, 1, 'tree', '{}', null,  null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/midprogram/query/list', 'PROJECTKIND', '支出项目类别', 16, 0, 0, null, null, null, 1, null, '#code-#name', null, null, null, 1, 'tree', '{}', null,  null, null);


--项目年度绩效查询列表
delete from p#busfw_t_uicolumn where key ='/pmkpi/yearprogram/query/list' and COLUMNCODE in('PROJECTKIND','PRO_LEVONE_CODE');  
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/yearprogram/query/list', 'PROJECTKIND', '支出项目类别', 15, 0, 0, null, null, null, 1, null, '#code-#name', null, null, 200, 1, 'tree', '{}', null,  null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/yearprogram/query/list', 'PRO_LEVONE_CODE', '一级项目编码', 16, 0, 0, null, null, null, 1, null, '#code-#name', null, null, 200, 1, 'tree', '{}', null,  null, null);


--部门重点监控下发列表
delete from p#busfw_t_uicolumn where key ='/pmkpi/program/trace/keytask/send' and COLUMNCODE in('PROJECTKIND','PRO_LEVONE_CODE');  
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/keytask/send', 'PROJECTKIND', '支出项目类别', 12, 0, 0, null, null, null, 1, null, null, null, null, 100, 0, 's', '{}', null,  null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/keytask/send', 'PRO_LEVONE_CODE', '一级项目编码', 13, 0, 0, null, null, null, 1, null, null, null, null, 100, 0, 's', '{}', null,  null, null);


-- 一般监控任务布置
delete from p#busfw_t_uicolumn where key ='/pmkpi/program/trace/manage/prolist' and COLUMNCODE in('PROJECTKIND','PRO_LEVONE_CODE');  
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/manage/prolist', 'PRO_LEVONE_CODE', '一级项目编码', 11, 0, 0, null, null, null, 1, null, '#code-#name', null, null, 200, 1, 'tree', '{}', null,  null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/manage/prolist', 'PROJECTKIND', '支出项目类别', 12, 0, 0, null, null, null, 1, null, '#code-#name', null, null, 150, 1, 'tree', '{}', null,  null, null);


--重点监控任务布置
delete from p#busfw_t_uicolumn where key ='/pmkpi/program/trace/manage/prolistimp' and COLUMNCODE in('PROJECTKIND','PRO_LEVONE_CODE');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', 'PROJECTKIND', '支出项目类别', 12, 0, 0, null, null, null, 1, null, '#code-#name', null, null, 150, 1, 'tree', '{}', null,  null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', 'PRO_LEVONE_CODE', '一级项目编码', 11, 0, 0, null, null, null, 1, null, '#code-#name', null, null, 200, 1, 'tree', '{}', null,  null, null);


--监控填报、审核列表
delete from p#busfw_t_uicolumn where key ='/pmkpi/program/trace/report' and COLUMNCODE in('PROJECTKIND','PRO_LEVONE_CODE');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/report', 'PRO_LEVONE_CODE', '一级项目编码', 24, 0, 0, 0, null, 0, 1, null, '#code-#name', null, null, 150, 1, 'tree', '{type:''protrace''}', null,  null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/report', 'PROJECTKIND', '支出项目类别', 25, 0, 0, 0, null, 0, 1, null, '#code-#name', null, null, 150, 1, 'tree', '{type:''protrace''}', null,  null, null);


--监控查询列表
delete from p#busfw_t_uicolumn where key ='/pmkpi/program/trace/query' and COLUMNCODE in('PROJECTKIND','PRO_LEVONE_CODE');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/query', 'PRO_LEVONE_CODE', '一级项目编码', 24, 0, 0, 0, null, 0, 1, null, '#code-#name', null, null, 150, 1, 'tree', '{type:''protrace''}', null,  null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/query', 'PROJECTKIND', '支出项目类别', 25, 0, 0, 0, null, 0, 1, null, '#code-#name', null, null, 150, 1, 'tree', '{type:''protrace''}', null,  null, null);




