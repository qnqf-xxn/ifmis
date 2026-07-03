begin

--删除未启用项目调整流程
delete from p#busfw_t_dcworkflowplan t where guid in('ACB7014749AFD762BBFD99D8304BA3F2');

--项目目标修订填报工作流(HB)
DELETE FROM P#busfw_t_Dcworkflowplan t where t.guid in ('pmkpiperftlprogramtotalmod001','pmkpiperftlprogramyearmod002');
insert into P#busfw_t_Dcworkflowplan (GUID, CODE, TABLECODE, NAME, STATUS, YEAR, PROVINCE, VERSION, DBVERSION, REMARK, CREATER, CREATETIME, TYPE)
values ('pmkpiperftlprogramtotalmod001', 'V_PERF_T_PROVISIONDECLARE', 'V_PERF_T_PROVISIONDECLARE', '项目总体目标修订填报(HB)', '1', '2016', '87', null, null, null, null, '20200827225021776', 'B876713347C31372A297A0234F30FFB8');

insert into P#busfw_t_Dcworkflowplan (GUID, CODE, TABLECODE, NAME, STATUS, YEAR, PROVINCE, VERSION, DBVERSION, REMARK, CREATER, CREATETIME, TYPE)
values ('pmkpiperftlprogramyearmod002', 'V_PERF_T_PROVISIONDECLARE', 'V_PERF_T_PROVISIONDECLARE', '项目年度目标修订填报(HB)', '1', '2016', '87', null, null, null, null, '20200827225021776', 'B876713347C31372A297A0234F30FFB8');

delete from perf_enum where elementcode in('KPIVALSOURCE','KPIVALNOTAPP');

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('BE5CCC7CC1C68D62E053480A050PP06F', '1', 'KPIVALSOURCE', '暂不确定', '1', null, '20210531203521', '2016', '87', null, 'pmkpi', null, 2, 1, '9', null, '1');

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('C054B706A4E0387DE053B11FA8CPP9DE', '2', 'KPIVALSOURCE', '项目实际值', '1', null, '20210531203521', '2016', '87', null, 'pmkpi', null, 2, 1, '9', null, '2');

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('C054B706A4E0387DE053B100PPC059DE', '1', 'KPIVALNOTAPP', '本指标不适用此项目', '1', null, '20210531203521', '2016', '87', null, 'pmkpi', null, 2, 1, '10', null, '1');

--系统配置
delete from perf_t_systemset t where t.PARAMCODE='program_totalname';
insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('C5D04435FF623418E053B11FA8C0203B', 'program_totalname', '项目绩效目标/指标添加动态配置', '{1:"onegoal,oneindex,oneframetype",onegoal:"",oneindex:"",oneframetype:"",2:"twogoal,twoindex,twoframetype",twogoal:"",twoindex:"",twoframetype:"",3:"threegoal,threeindex,threeframetype",threegoal:"",threeindex:"",threeframetype:""}', '根据项目级次动态的配置总体绩效目标、指标名称，以及动态的配置指标体系', null, 10, 2016, '87', 1);

