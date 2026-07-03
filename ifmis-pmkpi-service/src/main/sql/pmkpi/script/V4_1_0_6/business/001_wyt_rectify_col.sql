begin
  --问题整改列表 任务阶段字段不翻译
  update p#busfw_t_uicolumn t set format ='#name',issource ='1',type ='tree' where key ='/pmkpi/rectification/index' and columncode ='TASKSTAGE';

