begin
  
delete from perf_t_bimmodnameconfig t where t.tablecode in('pm_perf_goal_info','pm_perf_indicator');
insert into PERF_T_BIMMODNAMECONFIG (GUID, ISAGENCY, COLCODE, UPCOLCODE, TABLECODE, STATUS, FILTERSQL, REMARK, ISSTAND)
values ('273CC83835972C13E0638516A8C00453', '1', 'agencyguid', 'agency_name', 'pm_perf_goal_info', 1, 'yearflag=''1''', null, '2');

insert into PERF_T_BIMMODNAMECONFIG (GUID, ISAGENCY, COLCODE, UPCOLCODE, TABLECODE, STATUS, FILTERSQL, REMARK, ISSTAND)
values ('273CC83835982C13E0638516A8C00453', '1', 'agencyguid', 'agency_name', 'pm_perf_indicator', 1, 'yearflag=''1''', null, '2');

insert into PERF_T_BIMMODNAMECONFIG (GUID, ISAGENCY, COLCODE, UPCOLCODE, TABLECODE, STATUS, FILTERSQL, REMARK, ISSTAND)
values ('242A4A0AB3EEBA71E0638516A8C0C866', '1', 'agencyguid', 'agency_name', 'pm_perf_goal_info', 1, 'yearflag=''0''', null, null);

insert into PERF_T_BIMMODNAMECONFIG (GUID, ISAGENCY, COLCODE, UPCOLCODE, TABLECODE, STATUS, FILTERSQL, REMARK, ISSTAND)
values ('242A4A0AB3EFBA71E0638516A8C0C866', '1', 'agencyguid', 'agency_name', 'pm_perf_indicator', 1, 'yearflag=''0''', null, null);
