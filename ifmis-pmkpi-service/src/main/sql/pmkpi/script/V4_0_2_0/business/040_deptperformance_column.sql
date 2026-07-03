begin
--部门绩效申报查询
delete from p#busfw_t_uicolumn where key ='/pmkpi/deptperformance/query/index' and columncode in('NAME','WFSTATUS');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('a34170572c9b86709d6a046a11a54a11', '/pmkpi/deptperformance/query/index', 'NAME', '名称', 3, 1, 0, 0, null, 0, 1, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('62039e117bbfd40e0ffb3ac4589fee79', '/pmkpi/deptperformance/query/index', 'WFSTATUS', '工作流状态', 2, 1, 0, 0, null, 0, 1, null, '#name', null, null, 100, 1, 's', null, null);

--部门绩效申报填报
delete from p#busfw_t_uicolumn where key ='/pmkpi/deptperformance/report/index' and columncode in('NAME','WFSTATUS');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('5D0F2AE8E8F14D20B2680DC244360D7E', '/pmkpi/deptperformance/report/index', 'NAME', '名称', 3, 1, 0, 0, null, 0, 1, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('3542944054710b0edbbcea02fd20ac8b', '/pmkpi/deptperformance/report/index', 'WFSTATUS', '工作流状态', 2, 1, 0, 0, null, 0, 1, null, '#name', null, null, 80, 1, 'tree', null, null);

--部门绩效申报审核
delete from p#busfw_t_uicolumn where key ='/pmkpi/deptperformance/audit/index' and columncode in('NAME','WFSTATUS');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('62039e117bbfd40e0ffb3ac4589fee79', '/pmkpi/deptperformance/audit/index', 'WFSTATUS', '工作流状态', 2, 1, 0, 0, null, 0, 1, null, '#name', null, null, 100, 1, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('df3cc90e69fcb42bb3f4c96643604818', '/pmkpi/deptperformance/audit/index', 'NAME', '名称', 3, 1, 0, 0, null, 0, 1, null, null, null, null, 200, 0, 's', null, null);

