begin

--修改待办显示title，拼接上级菜单名
update PERF_PENDINGTASK set name ='绩效目标调整/绩效目标调整审核/项目支出-待审核' where key ='/pmkpi/adjust/audit' and name ='绩效目标调整-项目支出绩效目标调整审核--待审核'; 
update PERF_PENDINGTASK set name ='绩效目标调整/绩效目标调整审核/部门整体-待审核' where key ='/pmkpi/adjust/audit' and name ='绩效目标调整-部门整体绩效目标调整审核--待审核'; 
update PERF_PENDINGTASK set name ='绩效目标调整/绩效目标调整审核/项目支出-被退回' where key ='/pmkpi/adjust/audit' and name ='项目支出绩效目标调整审核--被退回'; 
update PERF_PENDINGTASK set name ='绩效目标调整/绩效目标调整审核/部门整体-被退回' where key ='/pmkpi/adjust/audit' and name ='部门整体绩效目标调整审核--被退回'; 

update PERF_PENDINGTASK set name ='绩效目标调整/绩效目标调整填报/项目支出-未送审' where key ='/pmkpi/adjust/report' and name ='项目支出绩效目标调整填报--待送审'; 
update PERF_PENDINGTASK set name ='绩效目标调整/绩效目标调整填报/部门整体-未送审' where key ='/pmkpi/adjust/report' and name ='绩效目标调整-部门整体绩效目标调整填报--待送审'; 
update PERF_PENDINGTASK set name ='绩效目标调整/绩效目标调整填报/项目支出-被退回' where key ='/pmkpi/adjust/report' and name ='项目支出绩效目标调整填报--被退回'; 
update PERF_PENDINGTASK set name ='绩效目标调整/绩效目标调整填报/部门整体-被退回' where key ='/pmkpi/adjust/report' and name ='部门整体绩效目标调整填报--被退回'; 

update PERF_PENDINGTASK set name ='部门绩效申报/部门绩效申报审核-待审核' where key ='/pmkpi/deptperformance/audit/index' and name ='部门绩效申报-部门绩效申报审核--待审核'; 
update PERF_PENDINGTASK set name ='部门绩效申报/部门绩效申报审核-被退回' where key ='/pmkpi/deptperformance/audit/index' and name ='部门绩效申报-部门绩效申报审核--被退回'; 

update PERF_PENDINGTASK set name ='部门绩效申报/部门绩效申报填报-待送审' where key ='/pmkpi/deptperformance/report/index' and name ='部门绩效申报填报--待送审'; 
update PERF_PENDINGTASK set name ='部门绩效申报/部门绩效申报填报-被退回' where key ='/pmkpi/deptperformance/report/index' and name ='部门绩效申报-部门绩效申报填报--被退回'; 

update PERF_PENDINGTASK set name ='部门评价/部门评价项目审核/项目支出-待审核' where key ='/pmkpi/evaluation/dept/audit' and name ='项目支出部门评价项目审核--待审核'; 
update PERF_PENDINGTASK set name ='部门评价/部门评价项目审核/项目支出-被退回' where key ='/pmkpi/evaluation/dept/audit' and name ='项目支出部门评价项目审核--被退回';
update PERF_PENDINGTASK set name ='部门评价/部门评价项目审核/部门整体-待审核' where key ='/pmkpi/evaluation/dept/audit' and name ='部门评价-部门整体部门评价项目审核--待审核'; 
update PERF_PENDINGTASK set name ='部门评价/部门评价项目审核/部门整体-被退回' where key ='/pmkpi/evaluation/dept/audit' and name ='部门评价-部门整体部门评价项目审核--被退回';
 
update PERF_PENDINGTASK set name ='部门评价/部门评价项目申报/项目支出-被退回' where key ='/pmkpi/evaluation/dept/report' and name ='项目支出部门评价项目申报--被退回'; 
update PERF_PENDINGTASK set name ='部门评价/部门评价项目申报/项目支出-待确认' where key ='/pmkpi/evaluation/dept/report' and name ='项目支出部门评价项目申报--待确认'; 
update PERF_PENDINGTASK set name ='部门评价/部门评价项目申报/部门整体-被退回' where key ='/pmkpi/evaluation/dept/report' and name ='部门评价-部门整体部门评价项目申报--被退回'; 
update PERF_PENDINGTASK set name ='部门评价/部门评价项目申报/部门整体-待确认' where key ='/pmkpi/evaluation/dept/report' and name ='部门评价-部门整体部门评价项目申报--待确认'; 

update PERF_PENDINGTASK set name ='部门评价/部门评价成果申报/项目支出-被退回' where key ='/pmkpi/evaluation/dept/result' and name ='项目支出部门评价成果申报--被退回'; 
update PERF_PENDINGTASK set name ='部门评价/部门评价成果申报/项目支出-待提交' where key ='/pmkpi/evaluation/dept/result' and name ='项目支出部门评价成果申报--待提交'; 
update PERF_PENDINGTASK set name ='部门评价/部门评价成果申报/部门整体-被退回' where key ='/pmkpi/evaluation/dept/result' and name ='部门评价-部门整体部门评价成果申报--被退回'; 
update PERF_PENDINGTASK set name ='部门评价/部门评价成果申报/部门整体-待提交' where key ='/pmkpi/evaluation/dept/result' and name ='部门评价-部门整体部门评价成果申报--待提交'; 

update PERF_PENDINGTASK set name ='部门评价/部门评价成果审核/项目支出-待审核' where key ='/pmkpi/evaluation/dept/resultaudit' and name ='项目支出部门评价成果审核--待审核'; 
update PERF_PENDINGTASK set name ='部门评价/部门评价成果审核/项目支出-被退回' where key ='/pmkpi/evaluation/dept/resultaudit' and name ='项目支出部门评价成果审核--被退回'; 
update PERF_PENDINGTASK set name ='部门评价/部门评价成果审核/部门整体-待审核' where key ='/pmkpi/evaluation/dept/resultaudit' and name ='部门评价-部门整体部门评价成果审核--待审核'; 
update PERF_PENDINGTASK set name ='部门评价/部门评价成果审核/部门整体-被退回' where key ='/pmkpi/evaluation/dept/resultaudit' and name ='部门评价-部门整体部门评价成果审核--被退回'; 

update PERF_PENDINGTASK set name ='指标管理/部门指标确认/项目支出-待确认' where key ='/pmkpi/index/audit' and name ='个性指标-部门整体指标确认-待送审'; 
update PERF_PENDINGTASK set name ='指标管理/部门指标确认/部门整体-待确认' where key ='/pmkpi/index/audit' and name ='部门整体-部门整体指标确认-待送审'; 
update PERF_PENDINGTASK set name ='指标管理/部门指标确认/项目支出-被退回' where key ='/pmkpi/index/audit' and name ='指标管理-部门指标确认-项目支出-被退回'; 
update PERF_PENDINGTASK set name ='指标管理/部门指标确认/部门整体-被退回' where key ='/pmkpi/index/audit' and name ='指标管理-部门指标确认-部门整体-被退回'; 

update PERF_PENDINGTASK set name ='指标管理/部门绩效指标/项目支出-待送审' where key ='/pmkpi/indexlib/deptlist' and name ='个性指标-部门整体指标-待送审'; 
update PERF_PENDINGTASK set name ='指标管理/部门绩效指标/部门整体-待送审' where key ='/pmkpi/indexlib/deptlist' and name ='部门整体-部门整体指标-待送审'; 
update PERF_PENDINGTASK set name ='指标管理/部门绩效指标/项目支出-被退回' where key ='/pmkpi/indexlib/deptlist' and name ='指标管理-部门绩效指标-项目支出-被退回'; 
update PERF_PENDINGTASK set name ='指标管理/部门绩效指标/部门整体-被退回' where key ='/pmkpi/indexlib/deptlist' and name ='指标管理-部门绩效指标-部门整体-被退回'; 

update PERF_PENDINGTASK set name ='年中追加绩效目标申报/年中追加项目年度绩效目标审核-被退回' where key ='/pmkpi/midprogram/report/audit' and name ='年中追加绩效目标申报-年中追加项目年度绩效目标审核--被退回'; 
update PERF_PENDINGTASK set name ='年中追加绩效目标申报/年中追加项目年度绩效目标审核-待审核' where key ='/pmkpi/midprogram/report/audit' and name ='年中追加绩效目标申报-年中追加项目年度绩效目标审核--待审核'; 

update PERF_PENDINGTASK set name ='年中追加绩效目标申报/年中追加项目年度绩效目标填报-被退回' where key ='/pmkpi/midprogram/report/list' and name ='年中追加项目年度绩效目标填报--被退回'; 
update PERF_PENDINGTASK set name ='年中追加绩效目标申报/年中追加项目年度绩效目标填报-待送审' where key ='/pmkpi/midprogram/report/list' and name ='年中追加项目年度绩效目标填报--待送审'; 


update PERF_PENDINGTASK set name ='绩效公开/绩效公开审核-被退回' where key ='/pmkpi/performanceopen/audit' and name ='绩效公开-绩效公开审核-被退回'; 
update PERF_PENDINGTASK set name ='绩效公开/绩效公开审核-待审核' where key ='/pmkpi/performanceopen/audit' and name ='绩效公开-绩效公开审核-未审核'; 

update PERF_PENDINGTASK set name ='绩效自评管理/绩效自评填报/部门整体-未送审' where key ='/pmkpi/perfself/apply' and name ='部门整体绩效自评填报--未送审';
update PERF_PENDINGTASK set name ='绩效自评管理/绩效自评填报/部门整体-被退回' where key ='/pmkpi/perfself/apply' and name ='绩效自评管理-部门整体绩效自评填报--被退回'; 
update PERF_PENDINGTASK set name ='绩效自评管理/绩效自评填报/项目支出-未送审' where key ='/pmkpi/perfself/apply' and name ='绩效自评管理-项目支出绩效自评填报--未送审'; 
update PERF_PENDINGTASK set name ='绩效自评管理/绩效自评填报/项目支出-被退回' where key ='/pmkpi/perfself/apply' and name ='绩效自评管理-项目支出绩效自评填报--被退回';
 
update PERF_PENDINGTASK set name ='绩效自评管理/绩效自评审核/项目支出-被退回' where key ='/pmkpi/perfself/audit' and name ='绩效自评管理-项目支出绩效自评审核--被退回'; 
update PERF_PENDINGTASK set name ='绩效自评管理/绩效自评审核/部门整体-待审核' where key ='/pmkpi/perfself/audit' and name ='绩效自评管理-部门整体绩效自评审核--待审核'; 
update PERF_PENDINGTASK set name ='绩效自评管理/绩效自评审核/项目支出-待审核' where key ='/pmkpi/perfself/audit' and name ='绩效自评管理-项目支出绩效自评审核--待审核'; 
update PERF_PENDINGTASK set name ='绩效自评管理/绩效自评审核/部门整体-被退回' where key ='/pmkpi/perfself/audit' and name ='绩效自评管理-部门整体绩效自评审核--被退回'; 

update PERF_PENDINGTASK set name ='绩效自评管理(结转)/结转项目绩效自评填报-被退回' where key ='/pmkpi/perfself/transfer/apply' and name ='绩效自评管理(结转)-结转项目绩效自评填报--被退回'; 
update PERF_PENDINGTASK set name ='绩效自评管理(结转)/结转项目绩效自评填报-待送审' where key ='/pmkpi/perfself/transfer/apply' and name ='结转项目绩效自评填报--待送审'; 
update PERF_PENDINGTASK set name ='绩效自评管理(结转)/结转项目绩效自评审核-被退回' where key ='/pmkpi/perfself/transfer/audit' and name ='绩效自评管理(结转)-结转项目绩效自评审核--被退回'; 
update PERF_PENDINGTASK set name ='绩效自评管理(结转)/结转项目绩效自评审核-待审核' where key ='/pmkpi/perfself/transfer/audit' and name ='绩效自评管理(结转)-结转项目绩效自评审核--待审核'; 

update PERF_PENDINGTASK set name ='绩效运行监控/绩效监控审核/项目支出-待审核' where key ='/pmkpi/program/trace/audit' and name ='绩效运行监控-项目支出绩效监控审核--待审核'; 
update PERF_PENDINGTASK set name ='绩效运行监控/绩效监控审核/项目支出-被退回' where key ='/pmkpi/program/trace/audit' and name ='绩效运行监控-项目支出绩效监控审核--被退回'; 
update PERF_PENDINGTASK set name ='绩效运行监控/绩效监控审核/部门整体-待审核' where key ='/pmkpi/program/trace/audit' and name ='部门整体绩效监控审核--待审核'; 
update PERF_PENDINGTASK set name ='绩效运行监控/绩效监控审核/部门整体-被退回' where key ='/pmkpi/program/trace/audit' and name ='部门整体绩效监控审核--被退回'; 

update PERF_PENDINGTASK set name ='绩效运行监控/绩效监控填报/项目支出-待送审' where key ='/pmkpi/program/trace/report' and name ='绩效运行监控-项目支出绩效监控填报--待送审'; 
update PERF_PENDINGTASK set name ='绩效运行监控/绩效监控填报/项目支出-被退回' where key ='/pmkpi/program/trace/report' and name ='绩效运行监控-项目支出绩效监控填报--被退回'; 
update PERF_PENDINGTASK set name ='绩效运行监控/绩效监控填报/部门整体-待送审' where key ='/pmkpi/program/trace/report' and name ='部门整体绩效监控填报--待送审'; 
update PERF_PENDINGTASK set name ='绩效运行监控/绩效监控填报/部门整体-被退回' where key ='/pmkpi/program/trace/report' and name ='部门整体绩效监控填报--被退回'; 

update PERF_PENDINGTASK set name ='绩效运行监控/定期监控下发' where key ='/pmkpi/program/trace/keytask/send' and name ='绩效运行监控-定期监控下发'; 

update PERF_PENDINGTASK set name ='预算绩效/项目绩效修改-待审核' where key ='/pmkpi/program/reportdp/audit' and name ='预算绩效-项目绩效修改-待审核'; 
update PERF_PENDINGTASK set name ='预算绩效/项目绩效修改-待完善' where key ='/pmkpi/program/reportdp/list' and name ='预算绩效-项目绩效修改-待完善'; 
update PERF_PENDINGTASK set name ='预算绩效/项目绩效-待审核' where key ='/pmkpi/program/reportdp/jxaudit' and name ='预算绩效-项目绩效-待审核'; 

update PERF_PENDINGTASK set name ='事前绩效评估报告/事前绩效评估申报/项目支出-被退回' where key ='/pmkpi/seeting/evaluation/report' and name ='项目支出事前绩效评估申报-被退回'; 
update PERF_PENDINGTASK set name ='事前绩效评估报告/事前绩效评估申报/项目支出-未送审' where key ='/pmkpi/seeting/evaluation/report' and name ='项目支出事前绩效评估申报-未送审'; 

update PERF_PENDINGTASK set name ='事前绩效评估报告/事前绩效评估审核/项目支出-被退回' where key ='/pmkpi/seeting/evaluation/audit' and name ='项目支出事前绩效评估审核-被退回'; 
update PERF_PENDINGTASK set name ='事前绩效评估报告/事前绩效评估审核/项目支出-待审核' where key ='/pmkpi/seeting/evaluation/audit' and name ='项目支出事前绩效评估审核-未送审'; 

update PERF_PENDINGTASK set name ='问题整改/整改通知编制/项目支出-被退回' where key ='/pmkpi/rectification/index' and name ='项目支出整改通知编制--被退回'; 
update PERF_PENDINGTASK set name ='问题整改/整改通知编制/项目支出-待下达' where key ='/pmkpi/rectification/index' and name ='项目支出整改通知编制--待下达'; 
update PERF_PENDINGTASK set name ='问题整改/整改通知编制/部门整体-被退回' where key ='/pmkpi/rectification/index' and name ='部门整体整改通知编制--被退回'; 
update PERF_PENDINGTASK set name ='问题整改/整改通知编制/部门整体-待下达' where key ='/pmkpi/rectification/index' and name ='部门整体整改通知编制--待下达'; 

update PERF_PENDINGTASK set name ='问题整改/整改情况反馈/项目支出-被退回' where key ='/pmkpi/rectification/feedback/index' and name ='项目支出整改情况反馈--被退回'; 
update PERF_PENDINGTASK set name ='问题整改/整改情况反馈/项目支出-待送审' where key ='/pmkpi/rectification/feedback/index' and name ='项目支出整改情况反馈--待送审'; 
update PERF_PENDINGTASK set name ='问题整改/整改情况反馈/部门整体-被退回' where key ='/pmkpi/rectification/feedback/index' and name ='部门整体整改情况反馈--被退回'; 
update PERF_PENDINGTASK set name ='问题整改/整改情况反馈/部门整体-待送审' where key ='/pmkpi/rectification/feedback/index' and name ='部门整体整改情况反馈--待送审'; 

update PERF_PENDINGTASK set name ='问题整改/整改情况审核/项目支出-被退回' where key ='/pmkpi/rectification/feedback/audit/index' and name ='项目支出整改情况审核--被退回'; 
update PERF_PENDINGTASK set name ='问题整改/整改情况审核/项目支出-待审核' where key ='/pmkpi/rectification/feedback/audit/index' and name ='项目支出整改情况审核--待审核'; 
update PERF_PENDINGTASK set name ='问题整改/整改情况审核/部门整体-被退回' where key ='/pmkpi/rectification/feedback/audit/index' and name ='部门整体整改情况审核--被退回'; 
update PERF_PENDINGTASK set name ='问题整改/整改情况审核/部门整体-待审核' where key ='/pmkpi/rectification/feedback/audit/index' and name ='部门整体整改情况审核--待审核'; 

update PERF_PENDINGTASK set name ='问题整改/整改情况审核/项目支出-被退回' where key ='/pmkpi/rectification/feedback/audit/index' and name ='项目支出整改情况审核-被退回';
update PERF_PENDINGTASK set name ='问题整改/整改情况审核/部门整体-待审核' where key ='/pmkpi/rectification/feedback/audit/index' and name ='部门整体整改情况审核-待审核'; 

update PERF_PENDINGTASK set name ='问题整改/整改通知审核/项目支出-被退回' where key ='/pmkpi/rectification/audit/index' and name ='项目支出整改通知审核--被退回'; 
update PERF_PENDINGTASK set name ='问题整改/整改通知审核/项目支出-待审核' where key ='/pmkpi/rectification/audit/index' and name ='项目支出整改通知审核--待审核'; 
update PERF_PENDINGTASK set name ='问题整改/整改通知审核/部门整体-被退回' where key ='/pmkpi/rectification/audit/index' and name ='部门整体整改通知审核--被退回'; 
update PERF_PENDINGTASK set name ='问题整改/整改通知审核/部门整体-待审核' where key ='/pmkpi/rectification/audit/index' and name ='部门整体整改通知审核--待审核'; 

update PERF_PENDINGTASK set name ='绩效目标修订/绩效目标修订填报/项目支出-被退回' where key ='/pmkpi/prorevision/report' and name ='绩效目标修订填报--被退回'; 
update PERF_PENDINGTASK set name ='绩效目标修订/绩效目标修订填报/项目支出-未送审' where key ='/pmkpi/prorevision/report' and name ='绩效目标修订填报--未送审'; 

update PERF_PENDINGTASK set name ='绩效目标修订/绩效目标修订审核/项目支出-被退回' where key ='/pmkpi/prorevision/audit' and name ='绩效目标修订审核--被退回'; 
update PERF_PENDINGTASK set name ='绩效目标修订/绩效目标修订审核/项目支出-待审核' where key ='/pmkpi/prorevision/audit' and name ='绩效目标修订审核--待审核'; 

update PERF_PENDINGTASK set name ='财政评价管理/财政评价成果上传/项目支出-被退回' where key ='/pmkpi/evaluation/financial/resultupload' and name ='项目支出财政评价结果上传--被退回'; 
update PERF_PENDINGTASK set name ='财政评价管理/财政评价成果上传/项目支出-待提交' where key ='/pmkpi/evaluation/financial/resultupload' and name ='项目支出财政评价结果上传--待提交'; 
update PERF_PENDINGTASK set name ='财政评价管理/财政评价成果上传/部门整体-被退回' where key ='/pmkpi/evaluation/financial/resultupload' and name ='部门整体财政评价结果上传--被退回'; 
update PERF_PENDINGTASK set name ='财政评价管理/财政评价成果上传/部门整体-待提交' where key ='/pmkpi/evaluation/financial/resultupload' and name ='部门整体财政评价结果上传--待提交'; 

update PERF_PENDINGTASK set name ='财政评价管理/财政评价成果审核/项目支出-被退回' where key ='/pmkpi/evaluation/financial/resultaudit' and name ='项目支出财政评价成果审核--被退回'; 
update PERF_PENDINGTASK set name ='财政评价管理/财政评价成果审核/项目支出-待审核' where key ='/pmkpi/evaluation/financial/resultaudit' and name ='项目支出财政评价成果审核--待审核'; 
update PERF_PENDINGTASK set name ='财政评价管理/财政评价成果审核/部门整体-被退回' where key ='/pmkpi/evaluation/financial/resultaudit' and name ='部门整体财政评价成果审核--被退回'; 
update PERF_PENDINGTASK set name ='财政评价管理/财政评价成果审核/部门整体-待审核' where key ='/pmkpi/evaluation/financial/resultaudit' and name ='部门整体财政评价成果审核--待审核'; 

update PERF_PENDINGTASK set name ='财政评价管理/财政评价项目确定/项目支出-被退回' where key ='/pmkpi/evaluation/financial/proconfirm' and name ='项目支出财政评价项目确定--被退回'; 
update PERF_PENDINGTASK set name ='财政评价管理/财政评价项目确定/项目支出-待确认' where key ='/pmkpi/evaluation/financial/proconfirm' and name ='项目支出财政评价项目确定--待确认'; 
update PERF_PENDINGTASK set name ='财政评价管理/财政评价项目确定/部门整体-被退回' where key ='/pmkpi/evaluation/financial/proconfirm' and name ='部门整体财政评价确定--被退回'; 
update PERF_PENDINGTASK set name ='财政评价管理/财政评价项目确定/部门整体-待确认' where key ='/pmkpi/evaluation/financial/proconfirm' and name ='部门整体财政评价确定--待确认'; 

update PERF_PENDINGTASK set name ='财政评价管理/预算部门自评/项目支出-被退回' where key ='/pmkpi/evaluation/financial/deptassessment/list' and name ='项目支出财政评价部门自评价-被退回'; 
update PERF_PENDINGTASK set name ='财政评价管理/预算部门自评/项目支出-待送审' where key ='/pmkpi/evaluation/financial/deptassessment/list' and name ='项目支出财政评价部门自评价-待审核'; 
update PERF_PENDINGTASK set name ='财政评价管理/预算部门自评/部门整体-被退回' where key ='/pmkpi/evaluation/financial/deptassessment/list' and name ='部门整体财政评价部门自评价-被退回'; 
update PERF_PENDINGTASK set name ='财政评价管理/预算部门自评/部门整体-待送审' where key ='/pmkpi/evaluation/financial/deptassessment/list' and name ='部门整体财政评价部门自评价-待审核'; 

update PERF_PENDINGTASK set name ='财政评价管理/财政评价项目审核/项目支出-被退回' where key ='/pmkpi/evaluation/financial/audit' and name ='项目支出财政评价审核--被退回'; 
update PERF_PENDINGTASK set name ='财政评价管理/财政评价项目审核/项目支出-待审核' where key ='/pmkpi/evaluation/financial/audit' and name ='项目支出财政评价审核--待审核'; 
update PERF_PENDINGTASK set name ='财政评价管理/财政评价项目审核/部门整体-被退回' where key ='/pmkpi/evaluation/financial/audit' and name ='部门整体财政评价审核--被退回'; 
update PERF_PENDINGTASK set name ='财政评价管理/财政评价项目审核/部门整体-待审核' where key ='/pmkpi/evaluation/financial/audit' and name ='部门整体财政评价审核--待审核'; 

update PERF_PENDINGTASK set name ='财政评价管理/财政评价项目审核/项目支出-被退回' where key ='/pmkpi/evaluation/financial/audit' and name ='财政评价管理/财政评价审核/项目支出-被退回'; 
update PERF_PENDINGTASK set name ='财政评价管理/财政评价项目审核/项目支出-待审核' where key ='/pmkpi/evaluation/financial/audit' and name ='财政评价管理/财政评价审核/项目支出-待审核'; 
update PERF_PENDINGTASK set name ='财政评价管理/财政评价项目审核/部门整体-被退回' where key ='/pmkpi/evaluation/financial/audit' and name ='财政评价管理/财政评价审核/部门整体-被退回'; 
update PERF_PENDINGTASK set name ='财政评价管理/财政评价项目审核/部门整体-待审核' where key ='/pmkpi/evaluation/financial/audit' and name ='财政评价管理/财政评价审核/部门整体-待审核'; 


update PERF_PENDINGTASK set name ='部门评价/部门评价项目审核/项目支出-待审核' where key ='/pmkpi/evaluation/dept/audit' and name ='部门评价项目审核--待审核'; 
update PERF_PENDINGTASK set name ='部门评价/部门评价项目审核/项目支出-被退回' where key ='/pmkpi/evaluation/dept/audit' and name ='部门评价项目审核--被退回';
update PERF_PENDINGTASK set name ='部门评价/部门评价项目申报/项目支出-被退回' where key ='/pmkpi/evaluation/dept/report' and name ='部门评价项目申报--被退回'; 
update PERF_PENDINGTASK set name ='部门评价/部门评价项目申报/项目支出-待确认' where key ='/pmkpi/evaluation/dept/report' and name ='部门评价项目申报--待确认'; 
update PERF_PENDINGTASK set name ='部门评价/部门评价成果申报/项目支出-被退回' where key ='/pmkpi/evaluation/dept/result' and name ='部门评价成果申报--被退回'; 
update PERF_PENDINGTASK set name ='部门评价/部门评价成果申报/项目支出-待提交' where key ='/pmkpi/evaluation/dept/result' and name ='部门评价成果申报--待提交'; 
update PERF_PENDINGTASK set name ='部门评价/部门评价成果审核/项目支出-待审核' where key ='/pmkpi/evaluation/dept/resultaudit' and name ='部门评价成果审核--待审核'; 
update PERF_PENDINGTASK set name ='部门评价/部门评价成果审核/项目支出-被退回' where key ='/pmkpi/evaluation/dept/resultaudit' and name ='部门评价成果审核--被退回'; 
