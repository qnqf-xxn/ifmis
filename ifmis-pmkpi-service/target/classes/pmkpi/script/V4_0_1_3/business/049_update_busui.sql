begin
 delete from p#busfw_t_uicolumn where key = '/pmkpi/program/trace/report/edit/indextarget' and COLUMNCODE = 'COMPLETEANALYSCON';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B785109A5BCF0EC1E0530100007PPF2', '/pmkpi/program/trace/report/edit/indextarget', 'COMPLETEANALYSCON', '全年预计完成情况', 10, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);
update p#busfw_t_uicolumn t set t.config = '{viewmodel:''list'',isMulti:true}' where t.key = '/pmkpi/program/trace/report/edit/indextarget' and columncode = 'DEVIATIONANALYSIS';
delete from p#busfw_t_uicolumn where key = '/pmkpi/program/trace/report/edit/fund' and columncode = 'ECONOMIC';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('4FBA14C3FD4PP01F9CEFPPF970EFFE71', '/pmkpi/program/trace/report/edit/fund', 'ECONOMIC', '资金来源', 0, 1, 1, null, null, null, null, null, '#code-#name', null, null, null, 1, 'tree', '{}', null);
