begin
--整改 -部门整体选项目 列表字段注册
delete from p#busfw_t_uicolumn where key ='/pmkpi/rectification/check/deptproj';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1D4E9B88DEF77473E053B11FA8C03CED', '/pmkpi/rectification/check/deptproj', 'GUID', 'guid', 8, 0, 0, 0, null, 0, 1, null, null, null, null, null, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2D4E9B88DEF87473E053B11FA8C03CED', '/pmkpi/rectification/check/deptproj', 'LINKMAN', '联系人', 10, 0, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('3D4E9B88DEF97473E053B11FA8C03CED', '/pmkpi/rectification/check/deptproj', 'NAME', '预算部门名称', 2, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('4D4E9B88DEFA7473E053B11FA8C03CED', '/pmkpi/rectification/check/deptproj', 'TELEPHONE', '联系电话', 6, 0, 0, 0, null, 0, 1, null, null, null, null, 150, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('5D4E9B88DEFB7473E053B11FA8C03CED', '/pmkpi/rectification/check/deptproj', 'WFSTATUS', '工作流状态', 9, 0, 0, 0, null, 0, 1, null, '#name', null, null, 80, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('6D4E9B88DEF67473E053B11FA8C03CED', '/pmkpi/rectification/check/deptproj', 'CREATETIME', '创建人', 7, 0, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('8D4E9B88DEF57473E053B11FA8C03CED', '/pmkpi/rectification/check/deptproj', 'AGENCYGUID', '预算部门编码', 1, 1, 0, 0, null, 0, 1, null, '#name', null, null, 50, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9D4E9B88DEF37473E053B11FA8C03CED', '/pmkpi/rectification/check/deptproj', 'TASKSTAGE', '任务阶段', 5, 1, 0, 0, null, 0, 1, null, '#name', null, null, 100, 1, 'tree', '{isjk:1}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0D4E9B88DEF47473E053B11FA8C03CED', '/pmkpi/rectification/check/deptproj', 'TASKNAME', '任务名称', 4, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', '{isjk:1}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('730FCB22D6F2559DE053D100A8C017C6', '/pmkpi/rectification/check/deptproj', 'FININTORGGUID', '业务处室', 3, 1, 0, 0, null, 0, 1, null, '#name', null, null, 50, 1, 'tree', null, null);