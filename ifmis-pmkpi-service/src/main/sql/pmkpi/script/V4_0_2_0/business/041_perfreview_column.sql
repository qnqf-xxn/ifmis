begin
  --绩效目标评审 -- 绩效指标(安徽)不要合计行
delete from p#busfw_t_uicolumn where key ='/pmkpi/deptperformance/report/perfindex' and columncode in('COMPUTESIGN','METERUNIT');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF38D1AA46AC4BA3B5A538F7557CD49D', '/pmkpi/deptperformance/report/perfindex', 'COMPUTESIGN', '计算符号', 9, 1, 1, 0, null, 1, null, null, '#name', null, null, 100, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF38D1AA46AC4BA3B5A538F7557CD49D', '/pmkpi/deptperformance/report/perfindex', 'METERUNIT', '计量单位', 11, 1, 1, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null);
