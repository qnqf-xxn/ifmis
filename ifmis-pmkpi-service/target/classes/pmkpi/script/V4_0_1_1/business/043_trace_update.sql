begin
update p#busfw_t_uicolumn t set t.columncode = 'MOF_DEP_CODE',t.config = '{}' where t.columncode = 'FININTORGGUID' and key = '/pmkpi/program/trace/manage/prolist';
update p#busfw_t_uitabpage t set t. config = '{url:''/pmkpi/trace/report/proedit/warn.page'',busguid:''BA6668DFDF231167E053B11FA8C08965'',action:''tracewarn.save''}' where key = '/pmkpi/program/trace/report/ordinaryedit' and  code =  'protracefund' and name = '阶段监控填报';

