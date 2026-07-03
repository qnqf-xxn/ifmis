begin

--修改待办显示title，拼接上级菜单名
update PERF_PENDINGTASK set name ='绩效目标调整-项目支出绩效目标调整审核--待审核' where key ='/pmkpi/adjust/audit' and name ='项目支出绩效目标调整审核--待审核'; 
update PERF_PENDINGTASK set name ='绩效目标调整-部门整体绩效目标调整审核--待审核' where key ='/pmkpi/adjust/audit' and name ='部门整体绩效目标调整审核--待审核'; 
update PERF_PENDINGTASK set name ='绩效目标调整-部门整体绩效目标调整填报--待送审' where key ='/pmkpi/adjust/report' and name ='部门整体绩效目标调整填报--待送审'; 

update PERF_PENDINGTASK set name ='部门绩效申报-部门绩效申报审核--待审核' where key ='/pmkpi/deptperformance/audit/index' and name ='部门绩效申报审核--待审核'; 
update PERF_PENDINGTASK set name ='部门绩效申报-部门绩效申报审核--被退回' where key ='/pmkpi/deptperformance/audit/index' and name ='部门绩效申报审核--被退回'; 
update PERF_PENDINGTASK set name ='部门绩效申报-部门绩效申报填报--被退回' where key ='/pmkpi/deptperformance/report/index' and name ='部门绩效申报填报--被退回'; 

update PERF_PENDINGTASK set name ='部门评价-部门整体部门评价项目审核--待审核' where key ='/pmkpi/evaluation/dept/audit' and name ='部门整体部门评价项目审核--待审核'; 
update PERF_PENDINGTASK set name ='部门评价-部门整体部门评价项目审核--被退回' where key ='/pmkpi/evaluation/dept/audit' and name ='部门整体部门评价项目审核--被退回'; 
update PERF_PENDINGTASK set name ='部门评价-部门整体部门评价项目申报--被退回' where key ='/pmkpi/evaluation/dept/report' and name ='部门整体部门评价项目申报--被退回'; 
update PERF_PENDINGTASK set name ='部门评价-部门整体部门评价项目申报--待确认' where key ='/pmkpi/evaluation/dept/report' and name ='部门整体部门评价项目申报--待确认'; 
update PERF_PENDINGTASK set name ='部门评价-部门整体部门评价成果申报--被退回' where key ='/pmkpi/evaluation/dept/result' and name ='部门整体部门评价成果申报--被退回'; 
update PERF_PENDINGTASK set name ='部门评价-部门整体部门评价成果申报--待提交' where key ='/pmkpi/evaluation/dept/result' and name ='部门整体部门评价成果申报--待提交'; 
update PERF_PENDINGTASK set name ='部门评价-部门整体部门评价成果审核--待审核' where key ='/pmkpi/evaluation/dept/resultaudit' and name ='部门整体部门评价成果审核--待审核'; 
update PERF_PENDINGTASK set name ='部门评价-部门整体部门评价成果审核--被退回' where key ='/pmkpi/evaluation/dept/resultaudit' and name ='部门整体部门评价成果审核--被退回'; 

update PERF_PENDINGTASK set name ='指标管理-部门指标确认-项目支出-被退回' where key ='/pmkpi/index/audit' and name ='个性指标-部门整体指标确认-被退回'; 
update PERF_PENDINGTASK set name ='指标管理-部门指标确认-部门整体-被退回' where key ='/pmkpi/index/audit' and name ='部门整体-部门整体指标确认-被退回'; 

update PERF_PENDINGTASK set name ='指标管理-部门绩效指标-项目支出-被退回' where key ='/pmkpi/indexlib/deptlist' and name ='个性指标-部门整体指标-被退回'; 
update PERF_PENDINGTASK set name ='指标管理-部门绩效指标-部门整体-被退回' where key ='/pmkpi/indexlib/deptlist' and name ='部门整体-部门整体指标-被退回'; 

update PERF_PENDINGTASK set name ='年中追加绩效目标申报-年中追加项目年度绩效目标审核--被退回' where key ='/pmkpi/midprogram/report/audit' and name ='年中追加项目年度绩效目标审核--被退回'; 
update PERF_PENDINGTASK set name ='年中追加绩效目标申报-年中追加项目年度绩效目标审核--待审核' where key ='/pmkpi/midprogram/report/audit' and name ='年中追加项目年度绩效目标审核--待审核'; 

update PERF_PENDINGTASK set name ='绩效公开-绩效公开审核-被退回' where key ='/pmkpi/performanceopen/audit' and name ='绩效公开审核-被退回'; 
update PERF_PENDINGTASK set name ='绩效公开-绩效公开审核-未审核' where key ='/pmkpi/performanceopen/audit' and name ='绩效公开审核-未审核'; 

update PERF_PENDINGTASK set name ='绩效自评管理-部门整体绩效自评填报--被退回' where key ='/pmkpi/perfself/apply' and name ='部门整体绩效自评填报--被退回'; 
update PERF_PENDINGTASK set name ='绩效自评管理-项目支出绩效自评填报--未送审' where key ='/pmkpi/perfself/apply' and name ='项目支出绩效自评填报--未送审'; 
update PERF_PENDINGTASK set name ='绩效自评管理-项目支出绩效自评填报--被退回' where key ='/pmkpi/perfself/apply' and name ='项目支出绩效自评填报--被退回'; 
update PERF_PENDINGTASK set name ='绩效自评管理-项目支出绩效自评审核--被退回' where key ='/pmkpi/perfself/audit' and name ='项目支出绩效自评审核--被退回'; 
update PERF_PENDINGTASK set name ='绩效自评管理-部门整体绩效自评审核--待审核' where key ='/pmkpi/perfself/audit' and name ='部门整体绩效自评审核--待审核'; 
update PERF_PENDINGTASK set name ='绩效自评管理-项目支出绩效自评审核--待审核' where key ='/pmkpi/perfself/audit' and name ='项目支出绩效自评审核--待审核'; 
update PERF_PENDINGTASK set name ='绩效自评管理-部门整体绩效自评审核--被退回' where key ='/pmkpi/perfself/audit' and name ='部门整体绩效自评审核--被退回'; 
update PERF_PENDINGTASK set name ='绩效自评管理(结转)-结转项目绩效自评填报--被退回' where key ='/pmkpi/perfself/transfer/apply' and name ='结转项目绩效自评填报--被退回'; 
update PERF_PENDINGTASK set name ='绩效自评管理(结转)-结转项目绩效自评审核--被退回' where key ='/pmkpi/perfself/transfer/audit' and name ='结转项目绩效自评审核--被退回'; 
update PERF_PENDINGTASK set name ='绩效自评管理(结转)-结转项目绩效自评审核--待审核' where key ='/pmkpi/perfself/transfer/audit' and name ='结转项目绩效自评审核--待审核'; 

update PERF_PENDINGTASK set name ='绩效运行监控-项目支出绩效监控审核--待审核' where key ='/pmkpi/program/trace/audit' and name ='项目支出绩效监控审核--待审核'; 
update PERF_PENDINGTASK set name ='绩效运行监控-项目支出绩效监控审核--被退回' where key ='/pmkpi/program/trace/audit' and name ='项目支出绩效监控审核--被退回'; 
update PERF_PENDINGTASK set name ='绩效运行监控-项目支出绩效监控填报--待送审' where key ='/pmkpi/program/trace/report' and name ='项目支出绩效监控填报--待送审'; 
update PERF_PENDINGTASK set name ='绩效运行监控-项目支出绩效监控填报--被退回' where key ='/pmkpi/program/trace/report' and name ='项目支出绩效监控填报--被退回'; 

update PERF_PENDINGTASK set name ='绩效运行监控-定期监控下发' where key ='/pmkpi/program/trace/keytask/send' and name ='定期监控下发'; 

