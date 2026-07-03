begin

--未授权和已授权列表隐藏填报时间和更新时间
update p#busfw_t_uicolumn set isvisiable=0 where key ='/pmkpi/prorevision/power' and columncode in ('CREATE_TIME','UPDATE_TIME');

--中期绩效目标页签名称调整为“总体绩效目标”
update p#busfw_t_uitabpage set name ='总体绩效目标',title = '总体绩效目标' where key ='/pmkpi/prorevision/report/proedit/goal' and code ='total';

--修订填报页资金明细页签隐藏
update p#busfw_t_uitabpage set isvisiable = 0 where key ='/pmkpi/prorevision/report/proedit' and code ='bugamt';

--修订填报页目标指标，总体不可编辑
update p#busfw_t_uitabpage set config ='{busguid:''B9B1886CA7A600A1E053B11FA8C0DBA4'',url:''/pmkpi/prorevision/report/proedit/goal.page?showtab=1&isedittotal=1'',action:''revisiongoal.save''}' where key ='/pmkpi/prorevision/report/proedit' and code ='progoal';
update p#busfw_t_uitabpage set config ='{busguid:''B9B1886CA7A700A1E053B11FA8C0DBA4'',url:''/pmkpi/prorevision/report/proedit/index.page?showtab=1&isedittotal=1'',action:''revisionindex.save''}' where key ='/pmkpi/prorevision/report/proedit' and code ='proindex';
