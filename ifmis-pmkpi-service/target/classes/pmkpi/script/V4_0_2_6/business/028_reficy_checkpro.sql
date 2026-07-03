begin
  --问题整改选择项目 列表字段注册
delete from p#busfw_t_uicolumn where key ='/pmkpi/rectification/check/proj';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DE3B55B5606D2ACAE0533315A8C03C9D', '/pmkpi/rectification/check/proj', 'SELFRESULT', '自评结论', 10, 1, 0, 0, '0', 0, 0, null, null, null, 0, 50, 0, 's', '{iszp:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32C6A274CE0533315A8C0ACDD', '/pmkpi/rectification/check/proj', 'PRO_CODE', '项目编码', 3, 1, 0, 0, '0', 0, 1, null, null, null, 0, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32C6B274CE0533315A8C0ACDD', '/pmkpi/rectification/check/proj', 'NAME', '项目名称', 4, 1, 0, 0, '0', 0, 1, null, null, null, 0, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32C6C274CE0533315A8C0ACDD', '/pmkpi/rectification/check/proj', 'AGENCYGUID', '预算单位', 5, 1, 0, 0, '0', 0, 1, null, '#code-#name', null, 0, 150, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32C65274CE0533315A8C0ACDD', '/pmkpi/rectification/check/proj', 'FININTORGGUID', '业务处室', 6, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, 50, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32C69274CE0533315A8C0ACDD', '/pmkpi/rectification/check/proj', 'GUID', '项目id', 7, 0, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32C75274CE0533315A8C0ACDD', '/pmkpi/rectification/check/proj', 'TASKNAME', '任务名称', 8, 1, 0, 0, '0', 0, 1, null, null, null, 0, 100, 0, null, '{isjk:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32C64274CE0533315A8C0ACDD', '/pmkpi/rectification/check/proj', 'TASKSTAGE', '任务阶段', 9, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, 100, 1, 'tree', '{isjk:1}', null);




delete from p#busfw_t_uicolumn where key ='/pmkpi/rectification/check/deptproj';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1E3B55B5606D2ACAE0533315A8C03C9D', '/pmkpi/rectification/check/deptproj', 'SELFRESULT', '自评结论', 10, 1, 0, 0, null, 0, 0, null, null, null, null, 100, 0, 's', '{iszp:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32C6D274CE0533315A8C0ACDD', '/pmkpi/rectification/check/deptproj', 'GUID', 'guid', 8, 0, 0, 0, null, 0, 1, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32C6E274CE0533315A8C0ACDD', '/pmkpi/rectification/check/deptproj', 'LINKMAN', '联系人', 10, 0, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32C6F274CE0533315A8C0ACDD', '/pmkpi/rectification/check/deptproj', 'NAME', '预算部门名称', 2, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32C70274CE0533315A8C0ACDD', '/pmkpi/rectification/check/deptproj', 'TELEPHONE', '联系电话', 6, 0, 0, 0, null, 0, 1, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32C71274CE0533315A8C0ACDD', '/pmkpi/rectification/check/deptproj', 'WFSTATUS', '工作流状态', 9, 0, 0, 0, null, 0, 1, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32C72274CE0533315A8C0ACDD', '/pmkpi/rectification/check/deptproj', 'CREATETIME', '创建人', 7, 0, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32C73274CE0533315A8C0ACDD', '/pmkpi/rectification/check/deptproj', 'AGENCYGUID', '预算部门编码', 1, 1, 0, 0, null, 0, 1, null, '#name', null, null, 50, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32C74274CE0533315A8C0ACDD', '/pmkpi/rectification/check/deptproj', 'TASKSTAGE', '任务阶段', 5, 1, 0, 0, null, 0, 1, null, '#name', null, null, 100, 1, 'tree', '{isjk:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32C79274CE0533315A8C0ACDD', '/pmkpi/rectification/check/deptproj', 'TASKNAME', '任务名称', 4, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', '{isjk:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32C7F274CE0533315A8C0ACDD', '/pmkpi/rectification/check/deptproj', 'FININTORGGUID', '业务处室', 3, 1, 0, 0, null, 0, 1, null, '#name', null, null, 50, 1, 'tree', null, null);

