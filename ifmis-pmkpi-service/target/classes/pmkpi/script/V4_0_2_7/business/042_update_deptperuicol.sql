begin
update P#busfw_t_Uicolumn t set t.isvisiable = 0 where t.key = '/pmkpi/deptperformance/report/deptperfgoal' and t.columncode = 'REMARK';
update P#busfw_t_Uicolumn t set t.ordernum = 4 where t.key = '/pmkpi/deptperformance/report/deptperfgoal' and t.columncode = 'KPI_TARGET';
