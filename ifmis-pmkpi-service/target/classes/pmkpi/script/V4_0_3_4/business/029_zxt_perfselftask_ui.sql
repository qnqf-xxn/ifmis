begin

update p#busfw_t_uitable set defquery = 'pro_cat_code in (''22'',''3'')' where key = '/pmkpi/yearprogram/query/list';

delete from busfw_t_uicolumn where key = '/pmkpi/perfself/taskmanage' and columncode in ('PRO_TOTAL_AMT','BGTAMT');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values ('33406A2509654C62A003C4DE9FC4BEAA', '/pmkpi/perfself/taskmanage', 'PRO_TOTAL_AMT', '项目总金额', 14, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{type:''program''}', null, '2016', '87');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, YEAR, PROVINCE)
values ('33406A2509654C62A003C4DE9FC4BEAB', '/pmkpi/perfself/taskmanage', 'BGTAMT', '当年预算金额', 15, 1, 0, 0, null, 0, 6,  null, null, null, null, 100, 0, 's', '{type:''program''}', null, '2016', '87');

update fasp_t_dicdssource t set datasource='SELECT t.code as guid,t.code ,t.name,t.status FROM perf_enum t where t.elementcode=''PROLEV'' and t.year = ''2016'' order by t.ordernum'
where t.guid in ('PMKPIPROLEV');