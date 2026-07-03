begin

--更新原菜单id到项目支出类型的leftmenuid
update perf_t_treetab set leftmenuid ='B8C8933B0D03196EE0530100007FF847' where key  ='/pmkpi/indexlib/deptlist' and name ='项目支出' and leftmenuid is null;

update perf_t_treetab set leftmenuid ='B8C8933B0D04196EE0530100007FF847' where key  ='/pmkpi/index/audit' and name ='项目支出' and leftmenuid is null;

update perf_t_treetab set leftmenuid ='0FAA13E129FF4BFAA54DE0E1F46D10B9' where key  ='/pmkpi/index/query/dept' and name ='项目支出' and leftmenuid is null;

--更新新加的菜单id到部门整体类型的leftmenuid
update perf_t_treetab set leftmenuid ='deptindexreportdepthide' where key  ='/pmkpi/indexlib/deptlist' and name ='部门整体' and leftmenuid is null;

update perf_t_treetab set leftmenuid ='deptindexauditdepthide' where key  ='/pmkpi/index/audit' and name ='部门整体' and leftmenuid is null;

update perf_t_treetab set leftmenuid ='deptindexquerydepthide' where key  ='/pmkpi/index/query/dept' and name ='部门整体' and leftmenuid is null;

