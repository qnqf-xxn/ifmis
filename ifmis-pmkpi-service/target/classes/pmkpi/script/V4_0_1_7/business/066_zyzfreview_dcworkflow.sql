begin

delete from p#busfw_t_dcworkflowplan where guid = 'D118978EBDF7E3926E49A0A9E16ED8CD';
insert into busfw_t_dcworkflowplan (GUID, CODE, TABLECODE, NAME, STATUS, YEAR, PROVINCE, VERSION, DBVERSION, REMARK, CREATER, CREATETIME, TYPE)
values ('D118978EBDF7E3926E49A0A9E16ED8CD', 'V_PERF_T_REVIEW', 'V_PERF_T_REVIEW', '转移支付绩效项目(评审)', '1', '2016', '87', null, null, null, null, '20210421102117739', 'B876713347C31372A297A0234F30FFB8');


update busfw_t_uitabpage set filter = null where key = '/pmkpi/review/report/list' and filter = ' t.type=''goal''';