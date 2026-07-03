BEGIN
--项目储备中绩效指标内历年指标页面删除监审意见字段
delete from p#busfw_t_uicolumn where key = '/pmkpi/program/report/treeindex' and columncode in ('ADJOPTION','OPTIONS');
