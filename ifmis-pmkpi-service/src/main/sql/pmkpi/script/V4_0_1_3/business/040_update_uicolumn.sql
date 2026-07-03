begin
-- 一般监控 页面 查询方法
update busfw_t_uicolumn t set t.coltype ='1' where t.key ='/pmkpi/setting/taskset/list' and t.columncode = 'NAME';

-- 一般监控  任务布置范围 页面 查询方法
update busfw_t_uicolumn t set t.coltype ='1' where t.key ='/pmkpi/program/trace/manage/prolist' and t.columncode = 'PRO_NAME';


-- 整改通知 - 部门整体 选择项目 查询
update busfw_t_uicolumn t set t.coltype ='1' where t.key ='/pmkpi/rectification/add/deptproj';
