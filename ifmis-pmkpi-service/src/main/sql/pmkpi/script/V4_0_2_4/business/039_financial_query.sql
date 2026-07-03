begin
  --财政评价查询区
delete from p#busfw_t_uiqueryform where key ='/pmkpi/evaluation/financial/program';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E35B7D274CE0533315A8C0ACDD', '/pmkpi/evaluation/financial/program', 'NAME', '名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_FINEVALUATION', '{}', null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E35B7E274CE0533315A8C0ACDD', '/pmkpi/evaluation/financial/program', 'FININTORGGUID', '业务处室', 1, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_FINEVALUATION', '{format:''#name''}', null);

