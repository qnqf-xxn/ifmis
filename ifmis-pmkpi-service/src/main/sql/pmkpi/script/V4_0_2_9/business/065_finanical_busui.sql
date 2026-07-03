begin

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/evaluation/financial/deptfill/score') and t.columncode in('OBLIGATE1','SCORE','SELFSCORE');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/evaluation/financial/deptfill/score', 'OBLIGATE1', '操作', 1, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 1, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/evaluation/financial/deptfill/score', 'SCORE', '分值', 5, 1, 1, 1, null, 0, 6, null, '{unit:1,dotname:2,qfw:true}', null, null, 30, 0, 'i', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/evaluation/financial/deptfill/score', 'SELFSCORE', '单位自评分', 6, 1, 1, 1, null, 1, 6, null, '{unit:1,dotname:2,qfw:true}', null, null, 100, 0, 'i', '{}', null);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/evaluation/financial/deptfill/deptedit/score') and t.columncode in('OBLIGATE1','SCORE','SELFSCORE');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/evaluation/financial/deptfill/deptedit/score', 'OBLIGATE1', '操作', 1, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 1, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/evaluation/financial/deptfill/deptedit/score', 'SCORE', '分值', 7, 1, 1, 1, null, 0, 6, null, '{unit:1,dotname:2,qfw:true}', null, null, 80, 0, 'i', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/evaluation/financial/deptfill/deptedit/score', 'SELFSCORE', '自评得分', 8, 1, 1, 1, null, 1, 6, null, '{unit:1,dotname:2,qfw:true}', null, null, 100, 0, 'i', '{}', null);

update p#busfw_t_uitabpage t set t.hidebtns='保存' where t.key in('/pmkpi/evaluation/financial/deptfill/proedit','/pmkpi/evaluation/financial/result/edit','/pmkpi/evaluation/finconfirm/proedit') and code='relation';
update p#busfw_t_uitabpage t set t.hidebtns='保存', t.config='{url:''/pmkpi/evaluation/financial/deptfill/deptedit/score.page?pagetype=upfile''}' where t.key ='/pmkpi/evaluation/financial/report/deptedit' and t.code='score';
update p#busfw_t_uitabpage t set t.hidebtns='保存', t.config='{url:''/pmkpi/evaluation/financial/deptfill/score.page?pagetype=upfile''}' where t.key ='/pmkpi/evaluation/financial/report/edit' and t.code='score';
update p#busfw_t_uitabpage t set t.hidebtns='保存', t.config='{url:''/pmkpi/evaluation/financial/deptfill/deptedit/score.page?pagetype=upfile''}' where t.key ='/pmkpi/evaluation/financial/result/deptedit' and t.code='score';
update p#busfw_t_uitabpage t set t.hidebtns='保存', t.config='{url:''/pmkpi/evaluation/financial/deptfill/score.page?pagetype=upfile''}' where t.key ='/pmkpi/evaluation/financial/result/edit' and t.code='score';
update p#busfw_t_uitabpage t set t.hidebtns='保存', t.config='{url:''/pmkpi/evaluation/financial/deptfill/deptedit/score.page?pagetype=upfile''}' where t.key ='/pmkpi/evaluation/finconfirm/deptedit' and t.code='score';
update p#busfw_t_uitabpage t set t.hidebtns='保存', t.config='{url:''/pmkpi/evaluation/financial/deptfill/score.page?pagetype=upfile''}' where t.key ='/pmkpi/evaluation/finconfirm/proedit' and t.code='score';