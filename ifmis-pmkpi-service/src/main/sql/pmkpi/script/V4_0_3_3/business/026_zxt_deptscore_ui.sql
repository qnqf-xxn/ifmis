BEGIN

update p#busfw_t_uitabpage set isvisiable = 0 where key ='/pmkpi/deptoverallmerit/report/edit' and code = 'workcontent';
update p#busfw_t_uitabpage set isvisiable = 0 where key ='/pmkpi/deptoverallmerit/audit/edit' and code = 'workcontent';
update busfw_t_uieditform set isvisiable = 0 where key = '/pmkpi/perfself/apply/dept/report/edit' and columncode in ('BASICEXPEND','BUDGETAMT','BUDGETTOTAL','FUNCDESC','GOVEFUNCAMT','OTHERFUND','PROJEXPAMT','TAXRANAMT');


delete from p#busfw_t_uicolumn where key = '/pmkpi/deptoverallmerit/report/edit/deptscore';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D8F4EBD5BB295FECE0530603A8C0B67C', '/pmkpi/deptoverallmerit/report/edit/deptscore', 'BUCKLE', '理由及依据', 10, 1, 1, 0, '0', 0, null, null, null, null, 0, 50, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DF60D3C21194BA69E053D100A8C02F03', '/pmkpi/deptoverallmerit/report/edit/deptscore', 'GUID', '主键ID', 1, 0, 0, 0, '0', 0, null, null, null, null, 0, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D8F4EBD5BB205FECE0530603A8C0B67C', '/pmkpi/deptoverallmerit/report/edit/deptscore', 'ISLEAF', '叶子节点', 4, 0, 0, 0, '0', 0, null, null, null, null, 0, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DF80D3C21194BA69E053D100A8C02F03', '/pmkpi/deptoverallmerit/report/edit/deptscore', 'LEVELNO', '级别', 0, 0, 0, 0, '0', 0, null, null, null, null, 0, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DF60D3C21195BA69E053D100A8C02F03', '/pmkpi/deptoverallmerit/report/edit/deptscore', 'MAINGUID', '目标ID', 2, 0, 0, 0, '0', 0, null, null, null, null, 0, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D8F4EBD5BB206FECE0530603A8C0B67C', '/pmkpi/deptoverallmerit/report/edit/deptscore', 'NAME', '评价指标', 5, 1, 0, 0, '0', 0, null, null, null, null, 0, 150, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D8F4EBD5BB208FECE0530603A8C0B67C', '/pmkpi/deptoverallmerit/report/edit/deptscore', 'QUALITYNAMEEXP', '指标解释或说明', 6, 1, 0, 0, '0', 0, null, null, null, null, 0, 220, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D8F4EBD5BB207FECE0530603A8C0B67C', '/pmkpi/deptoverallmerit/report/edit/deptscore', 'QUALITYSTAND', '评价（评分）标准', 7, 1, 0, 0, '0', 0, null, null, null, null, 0, 220, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D8F4EBD5BB285FECE0530603A8C0B67C', '/pmkpi/deptoverallmerit/report/edit/deptscore', 'QUALITYWEIGHT', '分值', 8, 1, 0, 0, '0', 0, null, null, null, null, 0, 50, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D8F4EBD5BB265FECE0530603A8C0B67C', '/pmkpi/deptoverallmerit/report/edit/deptscore', 'SBUCKLE', '理由及依据', 12, 0, 0, 0, '0', 0, null, null, null, null, 0, 50, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DF60D3C211A2BA11Q053D100A8C02F03', '/pmkpi/deptoverallmerit/report/edit/deptscore', 'SCROE', '自评得分', 9, 1, 1, 1, '0', 0, null, null, null, null, 0, 50, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DF80D3C211A2BA11Q053D100A8C02F03', '/pmkpi/deptoverallmerit/report/edit/deptscore', 'SGUID', '评价得分id', 15, 0, 0, 0, '0', 0, null, null, null, null, 0, 50, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D8F4EBD5BB275FECE0530603A8C0B67C', '/pmkpi/deptoverallmerit/report/edit/deptscore', 'SSCROE', '考核得分', 11, 0, 0, 0, '0', 0, null, null, null, null, 0, 50, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D8F4EBD5BB205FECE0530603A8C0B67C', '/pmkpi/deptoverallmerit/report/edit/deptscore', 'SUPERID', '父级', 3, 0, 0, 0, '0', 0, null, null, null, null, 0, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DF70D3C211A2BA11Q053D100A8C02F03', '/pmkpi/deptoverallmerit/report/edit/deptscore', 'TGUID', '自评得分id', 14, 0, 0, 0, '0', 0, null, null, null, null, 0, 50, 0, 's', '{}', null);


delete from p#busfw_t_uitable where key = '/pmkpi/deptoverallmerit/audit/edit/deptscore';

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('DA60D3C21193BA69E053E100A8C02F03', '/pmkpi/deptoverallmerit/audit/edit/deptscore', 'V_PERF_V_DEPTEVALSECORE', 0, 1, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn where key = '/pmkpi/deptoverallmerit/audit/edit/deptscore';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DAF4EBD5BB295FECE0530603A8C0B67C', '/pmkpi/deptoverallmerit/audit/edit/deptscore', 'BUCKLE', '理由及依据', 10, 1, 0, 0, '0', 0, null, null, null, null, 0, 200, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DA60D3C21194BA69E053D100A8C02F03', '/pmkpi/deptoverallmerit/audit/edit/deptscore', 'GUID', '主键ID', 1, 0, 0, 0, '0', 0, null, null, null, null, 0, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DAF4EBD5BB205FECE0530603A8C0B67C', '/pmkpi/deptoverallmerit/audit/edit/deptscore', 'ISLEAF', '叶子节点', 4, 0, 0, 0, '0', 0, null, null, null, null, 0, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DA80D3C21194BA69E053D100A8C02F03', '/pmkpi/deptoverallmerit/audit/edit/deptscore', 'LEVELNO', '级别', 0, 0, 0, 0, '0', 0, null, null, null, null, 0, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DA60D3C21195BA69E053D100A8C02F03', '/pmkpi/deptoverallmerit/audit/edit/deptscore', 'MAINGUID', '目标ID', 2, 0, 0, 0, '0', 0, null, null, null, null, 0, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DAF4EBD5BB206FECE0530603A8C0B67C', '/pmkpi/deptoverallmerit/audit/edit/deptscore', 'NAME', '评价指标', 5, 1, 0, 0, '0', 0, null, null, null, null, 0, 150, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DAF4EBD5BB208FECE0530603A8C0B67C', '/pmkpi/deptoverallmerit/audit/edit/deptscore', 'QUALITYNAMEEXP', '指标解释或说明', 6, 1, 0, 0, '0', 0, null, null, null, null, 0, 300, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DAF4EBD5BB207FECE0530603A8C0B67C', '/pmkpi/deptoverallmerit/audit/edit/deptscore', 'QUALITYSTAND', '评价（评分）标准', 7, 1, 0, 0, '0', 0, null, null, null, null, 0, 300, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DAF4EBD5BB285FECE0530603A8C0B67C', '/pmkpi/deptoverallmerit/audit/edit/deptscore', 'QUALITYWEIGHT', '分值', 8, 1, 0, 0, '0', 0, null, null, null, null, 0, 40, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DAF4EBD5BB265FECE0530603A8C0B67C', '/pmkpi/deptoverallmerit/audit/edit/deptscore', 'SBUCKLE', '理由及依据', 12, 1, 1, 0, '0', 0, null, null, null, null, 0, 200, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DA60D3C211A2BA11Q053D100A8C02F03', '/pmkpi/deptoverallmerit/audit/edit/deptscore', 'SCROE', '自评得分', 9, 1, 0, 1, '0', 0, null, null, null, null, 0, 70, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DA80D3C211A2BA11Q053D100A8C02F03', '/pmkpi/deptoverallmerit/audit/edit/deptscore', 'SGUID', '评价得分id', 15, 0, 0, 0, '0', 0, null, null, null, null, 0, 50, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DAF4EBD5BB275FECE0530603A8C0B67C', '/pmkpi/deptoverallmerit/audit/edit/deptscore', 'SSCROE', '考核得分', 11, 1, 1, 0, '0', 0, null, null, null, null, 0, 70, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DAF4EBD5BB205FECE0530603A8C0B67C', '/pmkpi/deptoverallmerit/audit/edit/deptscore', 'SUPERID', '父级', 3, 0, 0, 0, '0', 0, null, null, null, null, 0, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DA70D3C211A2BA11Q053D100A8C02F03', '/pmkpi/deptoverallmerit/audit/edit/deptscore', 'TGUID', '自评得分id', 14, 0, 0, 0, '0', 0, null, null, null, null, 0, 50, 0, 's', '{}', null);
