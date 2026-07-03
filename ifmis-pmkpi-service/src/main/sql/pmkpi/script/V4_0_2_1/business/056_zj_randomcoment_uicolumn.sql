begin
delete from p#busfw_t_uifunction where key = '/pmkpi/randomcomment/result/edit/randomIndexEdit';
INSERT INTO busfw_t_uifunction VALUES ('33BB0A243FF8C3EDPPE51CED05BB4879', '/pmkpi/randomcomment/result/edit/randomIndexEdit', '指标推荐', 1, 2, 'searchicon', 'randomIndexEdit.recom', NULL, '指标推荐', 'pmkpi', 'cancelsubmit', NULL, NULL, '87', '2016');
update p#busfw_t_uieditform t set t.type = 'tree',t.config = '{format:''#name''}',t.columncode = 'MEACHNAME',t.tablecode = 'PERF_T_RANDOMCOMMENT_PROJ' where key = '/pmkpi/randomcomment/result/edit/randomProblemEdit' and columncode = 'AGENCYNAME';
update p#busfw_t_uicolumn t set t.format = '#name',issource = '1',type = 'tree',columncode = 'MEACHNAME'
where t.key = '/pmkpi/randomcomment/entrust/index' and columncode = 'AGENCYNAME';
update p#busfw_t_uicolumn t set t.format = '#name',issource = '1',type = 'tree',columncode = 'MEACHNAME'
where t.key = '/pmkpi/randomcomment/result/index' and columncode = 'AGENCYNAME';
update p#busfw_t_uicolumn t set t.format = '#name',issource = '1',type = 'tree',columncode = 'MEACHNAME'
where t.key = '/pmkpi/randomcomment/query/index' and columncode = 'AGENCYNAME';
