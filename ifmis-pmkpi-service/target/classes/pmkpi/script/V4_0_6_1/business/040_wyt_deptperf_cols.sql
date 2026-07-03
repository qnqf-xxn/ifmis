begin
  --工作流状态字段不翻译
  update p#busfw_t_uicolumn t set t.ISSOURCE = '1',t.TYPE = 'tree',t.FORMAT ='#name' where key ='/pmkpi/deptperformance/query/index'and columncode ='WFSTATUS';
