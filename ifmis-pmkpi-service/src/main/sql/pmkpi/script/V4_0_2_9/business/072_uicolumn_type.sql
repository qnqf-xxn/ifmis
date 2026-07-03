begin
  --表字段小数类型不是f，改为 i，format改为：{unit:1,dotname:2,qfw:true}
  
--自评
update p#busfw_t_uicolumn set format ='{unit:1,dotname:2,qfw:true}',type ='i' where key ='/pmkpi/perfself/apply/edit/bdgpay' and columncode in('BGTGET','SCORE');
update p#busfw_t_uicolumn set format ='{unit:1,dotname:2,qfw:true}',type ='i' where key ='/pmkpi/perfself/apply/edit/fund' and columncode ='BGTGET';

update p#busfw_t_uicolumn set format ='{unit:1,dotname:2,qfw:true}',type ='i' where key ='/pmkpi/perfself/apply/dept/edit/bdgpay' and columncode in('BGTGET','SCORE');
update p#busfw_t_uicolumn set format ='{unit:1,dotname:2,qfw:true}',type ='i' where key ='/pmkpi/perfself/apply/dept/edit/fund' and columncode in('BGTGET','SCORE','SCORES','COMPLETION');


--监控
update p#busfw_t_uicolumn set format ='{unit:1,dotname:2,qfw:true}',type ='i' where key ='/pmkpi/trace/report/proedit/warn/fund' and columncode ='BGTGET';
update p#busfw_t_uicolumn set format ='{unit:1,dotname:2,qfw:true}',type ='i' where key ='/pmkpi/program/trace/report/edit/fund' and columncode in('BGTGET','AMT6');
update p#busfw_t_uicolumn set format ='{unit:1,dotname:2,qfw:true}',type ='i' where key ='/pmkpi/program/trace/report/edit/tjfund' and columncode ='BGTGET';
update p#busfw_t_uicolumn set format ='{unit:1,dotname:2,qfw:true}',type ='i' where key ='/pmkpi/trace/report/proedit/ordwarn/fund' and columncode ='BGTGET';

update p#busfw_t_uicolumn set format ='{unit:1,dotname:2,qfw:true}',type ='i' where key ='/pmkpi/dept/trace/report/edit/fund' and columncode ='BGTGET';
update p#busfw_t_uicolumn set format ='{unit:1,dotname:2,qfw:true}',type ='i' where key ='/pmkpi/trace/report/deptedit/warn/fund' and columncode ='BGTGET';




update p#busfw_t_uicolumn set format ='{unit:1,dotname:2,qfw:true}',type ='i' where key ='/pmkpi/adjust/report/proedit/index' and columncode in('WEIGHT','ADJUSTWEIGHT');

update p#busfw_t_uicolumn set format ='{unit:1,dotname:2,qfw:true}',type ='i' where key ='/pmkpi/program/report/bgtindex' and columncode in('ADJUSTWEIGHT','WEIGHT');
