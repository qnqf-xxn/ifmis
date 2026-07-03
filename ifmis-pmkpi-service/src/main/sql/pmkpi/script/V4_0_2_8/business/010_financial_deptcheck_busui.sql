begin

--部门
delete from p#busfw_t_uitable where key in('/pmkpi/evaluation/financial/deptcheck');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/evaluation/financial/deptcheck', 'PMKPI_FASP_T_PUBAGENCY', 100, 0, 0, 'code', 'isleaf<>1 and levelno=1', 'pmkpi', null);

