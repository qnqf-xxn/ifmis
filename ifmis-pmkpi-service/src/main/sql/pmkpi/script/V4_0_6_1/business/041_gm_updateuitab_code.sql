begin

update p#busfw_T_uitabpage t set t.code = 'yearindex',t.componentid = 'iframeindextable' where t.key = '/pmkpi/program/report/edit' 
 and t.config like '%/pmkpi/program/report/treeindex%' and t.code = 'yeargoal';

update p#busfw_T_uitabpage t set t.code = 'basinfo' where t.key = '/pmkpi/evaluation/financial/report/deptedit' 
 and t.code = 'info' and t.componentid = 'infoeditform';
 
 update p#busfw_T_uitabpage t set t.code = 'basinfo' where t.key = '/pmkpi/evaluation/financial/result/edit' 
  and t.code = 'info' and t.componentid = 'infoeditform';

update p#busfw_T_uitabpage t set t.code = 'resultfile' where t.key = '/pmkpi/evaluation/dept/result/deptedit' 
 and t.code = 'file' and t.config like '%deptevadeptresult%';
 
update p#busfw_T_uitabpage t set t.code = 'basinfo' where t.key = '/pmkpi/evaluation/financial/result/deptedit' 
  and t.code = 'info' and t.componentid = 'infoeditform';
  
update p#busfw_T_uitabpage t set t.code = 'resultfile' where t.key = '/pmkpi/evaluation/financial/result/deptedit' 
  and t.code = 'file' and t.config like '%finevadeptproresult%';
  
update p#busfw_T_uitabpage t set t.code = 'resultfile' where t.key = '/pmkpi/evaluation/financial/result/edit' 
  and t.code = 'file' and t.config like '%finevaproresult%';

update p#busfw_T_uitabpage t set t.code = 'alldone' where t.key = '/pmkpi/perfselftaskmanage/dept/index' 
  and t.code = 'alldeals' and t.title = 'ÒÑÍê³É';
  
update p#busfw_T_uitabpage t set t.code = 'basinfo' where t.key = '/pmkpi/evaluation/dept/result/deptedit' 
  and t.code = 'info' and t.componentid = 'infoeditform';

update p#busfw_T_uitabpage t set t.code = 'resultfile' where t.key = '/pmkpi/evaluation/financial/report/edit' 
  and t.code = 'file' and t.config like '%finevaproresult%';

update p#busfw_T_uitabpage t set t.code = 'resultfile' where t.key = '/pmkpi/evaluation/financial/report/deptedit' 
  and t.code = 'file' and t.config like '%finevadeptproresult%';

update p#busfw_T_uitabpage t set t.code = 'basinfo' where t.key = '/pmkpi/evaluation/financial/query/edit' 
  and t.code = 'info' and t.componentid = 'infoeditform';
  
update p#busfw_T_uitabpage t set t.code = 'scoreinfo' where t.key = '/pmkpi/evaluation/financial/query/edit' 
  and t.code = 'info' and t.componentid = 'proscoreiframe';

update p#busfw_T_uitabpage t set t.code = 'basinfo' where t.key = '/pmkpi/evaluation/financial/report/edit' 
  and t.code = 'info' and t.componentid = 'infoeditform';
  
update p#busfw_T_uitabpage t set t.code = 'resultfile' where t.key = '/pmkpi/evaluation/financial/query/edit' 
  and t.code = 'file' and t.componentid = 'manceisframe';

update p#busfw_T_uitabpage t set t.code = 'sxinfo' where t.key = '/pmkpi/evaluation/finconfirm/deptedit' 
  and t.code = 'info' and t.componentid = 'deptinfoiframe';
  
update p#busfw_T_uitabpage t set t.code = 'scoreinfo' where t.key = '/pmkpi/evaluation/financial/deptfill/deptedit' 
  and t.code = 'info' and t.componentid = 'proscoreiframe';

update p#busfw_T_uitabpage t set t.code = 'scoreinfo' where t.key = '/pmkpi/evaluation/financial/deptfill/proedit' 
  and t.code = 'info' and t.componentid = 'proscoreiframe';

update p#busfw_T_uitabpage t set t.code = 'fileflow' where t.key = '/pmkpi/evaluation/financial/deptfill/deptedit' 
  and t.code = 'file' and t.config like '%finselfevadeptpro%';

update p#busfw_T_uitabpage t set t.code = 'filefloud' where t.key = '/pmkpi/evaluation/financial/deptfill/proedit' 
  and t.code = 'file' and t.config like '%finselfevapro%';

update p#busfw_T_uitabpage t set t.code = 'basinfo' where t.key = '/pmkpi/evaluation/dept/result/edit' 
  and t.code = 'info' and t.componentid = 'infoeditform';

update p#busfw_T_uitabpage t set t.code = 'resultfile' where t.key = '/pmkpi/evaluation/dept/result/edit' 
  and t.code = 'file' and t.config like '%deptevaproresult%';

update perf_t_uitabpage_chec t set t.ischecktab=1 where t.province <> 87 and nvl(t.checktable,'') <> 'v_perf_file';
