begin

delete from perf_t_framesystem;
insert into perf_t_framesystem (ELE_ID, ELE_CODE, ELE_NAME, MOF_DIV_CODE, PARENT_ID, LEVEL_NO, IS_LEAF, ORDERNUM, REMARK, START_DATE, END_DATE, IS_ENABLED, UPDATE_TIME, IS_DELETED, CREATE_TIME, FISCAL_YEAR,province,year)
values ('DEPT', 'DEPT', '部门整体绩效指标体系', '87', '00', 1, 1, 2, null, '20201119', sysdate, 1, '20201119', 2, '20201119', '2016','87', '2016');

insert into perf_t_framesystem (ELE_ID, ELE_CODE, ELE_NAME, MOF_DIV_CODE, PARENT_ID, LEVEL_NO, IS_LEAF, ORDERNUM, REMARK, START_DATE, END_DATE, IS_ENABLED, UPDATE_TIME, IS_DELETED, CREATE_TIME, FISCAL_YEAR,province,year)
values ('PM001', 'PM001', '项目指标体系', '87', '00', 1, 1, 1, null, '20201119', sysdate, 1, '20201119', 2, '20201119', '2016','87', '2016');
