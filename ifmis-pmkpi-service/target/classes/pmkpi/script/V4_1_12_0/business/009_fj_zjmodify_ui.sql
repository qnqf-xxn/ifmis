begin

--抽评对象确定，修复错误的按钮code
update p#busfw_t_uifunction set code ='audit' where key ='/pmkpi/randomcomment/object/index' and code='submit' and action = 'randomcommentobject.submit';

update p#busfw_t_uifunction set code ='cancelaudit' where key ='/pmkpi/randomcomment/object/index' and code='backProj' and action = 'randomcommentobject.backProj';

--抽评列表，修复项目类型配置
update p#busfw_t_uicolumn set config ='{lefttabtype:''program''}' where config ='{type:''program''}' and key in ('/pmkpi/randomcomment/scope/index','/pmkpi/randomcomment/object/index','/pmkpi/randomcomment/random/index','/pmkpi/randomcomment/entrust/index','/pmkpi/randomcomment/result/index','/pmkpi/randomcomment/query/index');

--债券指标编辑页，增加层级的末级控制
update p#busfw_t_uieditform set bottomcontrl =1 where key ='/pmkpi/gdindex/edit' and columncode ='SINDEX';

--抽评结果上传，导入组件jslib引入
update bus_t_pagecomponent set jslib ='/buscommon/fileimport/js/import.js,'||jslib 
where id in('pmkpi_randomcommentresult')
and jslib is not null and instr(jslib,'/buscommon/fileimport/js/import.js')=0;