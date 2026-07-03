begin

DELETE FROM perf_t_datasource t where t.elementcode in ('PMKPIASSESSMENTBYYEAR','PMKPIASSESSMENTBYYEAR');
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2020', '2020', '2020', null, '0', 1, null, 1, 'PMKPIASSESSMENTBYYEAR', 1, '20201229', '20201229', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2021', '2021', '2021', null, '0', 1, null, 2, 'PMKPIASSESSMENTBYYEAR', 1, '20201229', '20201229', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2022', '2022', '2022', null, '0', 1, null, 3, 'PMKPIASSESSMENTBYYEAR', 1, '20201229', '20201229', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2023', '2023', '2023', null, '0', 1, null, 4, 'PMKPIASSESSMENTBYYEAR', 1, '20201229', '20201229', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2024', '2024', '2024', null, '0', 1, null, 5, 'PMKPIASSESSMENTBYYEAR', 1, '20201229', '20201229', 2020, '87');


DELETE FROM perf_enum t where t.elementcode in ('PMKPIASSESSMENTBYOBJ');
insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('subprovinceworkeval1', '2', 'PMKPIASSESSMENTBYOBJ', '县（市）区、开发区', '1', '20210118162733', '20210420182904', '2016', '87', 1, 'pmkpi', 'subprovince', 2, 1, null, '1', 2);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('deptworkeval1', '4', 'PMKPIASSESSMENTBYOBJ', '市预算绩效管理重点推进任务牵头市直部门', '1', '20210118162733', '20210420182904', '2016', '87', 1, 'pmkpi', 'dept', 2, 1, null, '2', 4);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('deptworkeval2', '5', 'PMKPIASSESSMENTBYOBJ', '非市预算绩效管理重点推进任务牵头市直部门', '1', '20210118162733', '20210420182904', '2016', '87', 1, 'pmkpi', 'dept', 2, 1, null, '3', 5);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('subprovince', '1', 'PMKPIASSESSMENTBYOBJ', '县（市）区', '1', '20210118162733', '20210118162733', '2016', '87', 1, 'pmkpi', null, 1, 0, null, null, 1);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('dept', '3', 'PMKPIASSESSMENTBYOBJ', '市直部门', '1', '20210118162733', '20210118162733', '2016', '87', 1, 'pmkpi', null, 1, 0, null, null, 3);

delete from PERF_FILETYPE where bustype in ('finselfevapro','finselfevadeptpro','workevaluatetask','revisioneport','deptworkeval');
insert into PERF_FILETYPE (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('FPP6P63P38P90CC3E053B11FA8C0BCPP', '001001', '项目自评材料', null, 'FOP6P23PP8190CC3E053B11FA8C0BCPP', 2, 1, 2, 1, 'finselfevapro', null, null, 2016, '87');

insert into PERF_FILETYPE (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('FOP6P23PP8190CC3E053B11FA8C0BCPP', '001', '项目自评附件', null, '#', 1, 0, 1, 1, 'finselfevapro', null, null, 2016, '87');

insert into PERF_FILETYPE (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('FPP6P63P38P90CC3E053B11FA8C0BCPL', '001001', '项目自评材料', null, 'FOP6P23PP8190CC3E053B11FA8C0BCPL', 2, 1, 2, 1, 'finselfevadeptpro', null, null, 2016, '87');

insert into PERF_FILETYPE (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('FOP6P23PP8190CC3E053B11FA8C0BCPL', '001', '项目自评附件', null, '#', 1, 0, 1, 1, 'finselfevadeptpro', null, null, 2016, '87');


insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('FPP6P63P38P90CC3E053B11FA8COBCPP', '001001', '项目修订材料', null, 'PPP6P2LPP8190CC3E053B11FA8COBCC1', 2, 1, 2, 1, 'revisioneport', null, null, 2016, '87');

insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('PPP6P2LPP8190CC3E053B11FA8COBCC1', '001', '项目附件', null, '#', 1, 0, 1, 1, 'revisioneport', null, null, 2016, '87');


insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('C3A0D06B92F0CAA7E053B11FA8C03BDD', '001', '工作任务附件', null, '#', 1, 0, 1, 1, 'workevaluatetask', null, null, 2016, '87');

insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('C3A0D06B92EFCAA7E053B11FA8C03BDD', '001001', '附件材料', null, 'C3A0D06B92F0CAA7E053B11FA8C03BDD', 2, 1, 2, 1, 'workevaluatetask', null, null, 2016, '87');


insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('C3BF724EC8D4A42AE053B11FA8C0F406', '001', '工作任务附件', null, '#', 1, 0, 1, 1, 'deptworkeval', null, null, 2016, '87');

insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('C3BF724EC8DEA42AE053B11FA8C0F406', '001001', '附件材料', null, 'C3BF724EC8D4A42AE053B11FA8C0F406', 2, 1, 2, 1, 'deptworkeval', null, null, 2016, '87');



delete from perf_t_datasource t where t.elementcode='scoretype';

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('evaluatescore', '001', '财政部门重点评价', null, '0', 1, 1, 1, 'scoretype', 1, '20201204', '20201204', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('programevaluatescore', '001001', '项目支出', null, 'evaluatescore', 1, 1, 2, 'scoretype', 1, '20201204', '20201204', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('deptevaluatescore', '001002', '部门整体', null, 'evaluatescore', 1, 1, 3, 'scoretype', 1, '20201204', '20201204', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('workscore', '002', '绩效管理工作考核', null, '0', 1, 1, 4, 'scoretype', 1, '20201204', '20201204', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('deptwork', '002001', '市直部门预算绩效管理工作考核评分表', null, 'workscore', 1, 1, 5, 'scoretype', 1, '20201204', '20201204', 2020, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('deptkeywork', '002002', '市预算绩效管理重点推进任务考核评分表', null, 'workscore', 1, 1, 6, 'scoretype', 1, '20201204', '20201204', 2020, '87');



--绩效工作管理考核工作流
delete from p#busfw_t_dcworkflowplan t where t.guid='C33452C06CA5C699E053B11FA8C0AACB';
insert into p#busfw_t_dcworkflowplan (GUID, CODE, TABLECODE, NAME, STATUS, YEAR, PROVINCE, VERSION, DBVERSION, REMARK, CREATER, CREATETIME, TYPE)
values ('C33452C06CA5C699E053B11FA8C0AACB', 'PERF_DEPTWORKEVALUATE', 'PERF_T_WORKTASKASSIGN', '预算部门绩效工作管理考核', '1', '2016', '87', null, null, null, null, '20200826143402197', 'B876713347C31372A297A0234F30FFB8');


--系统参数
DELETE FROM Perf_t_Systemset t where t.paramcode='INDEXLIBISDATARULE';
insert into Perf_t_Systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('8FED9EFB09B04D9CA71C9BDC66CDEBE0', 'INDEXLIBISDATARULE', '指标库审核左侧树是否有数据权限', '2', '1、有数据权限，2、无数据权限', null, 3, 2016, '87', 1);

--绩效目标评审审核意见导出列
delete from perf_t_impexpsub t where t.mainguid='program';
insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR)
values ('C31F5F3276C60AEFE053B11FA8C0108D', 'agencyguid', 'VD00010', '单位编码', 1, null, null, 'tree', 'program', 100, '87', '2016');

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR)
values ('C31F5F3276C70AEFE053B11FA8C0108D', 'agencyname', null, '单位名称', 2, null, null, 's', 'program', 160, '87', '2016');

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR)
values ('C31F5F3276C80AEFE053B11FA8C0108D', 'proguid', 'PMKPIPROGRAM', '项目编码', 3, null, null, 'tree', 'program', 120, '87', '2016');

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR)
values ('C31F5F3276C90AEFE053B11FA8C0108D', 'proname', null, '项目名称', 4, null, null, 's', 'program', 160, '87', '2016');

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR)
values ('C31F5F3276CA0AEFE053B11FA8C0108D', 'opinion', null, '修改意见', 11, null, null, 's', 'program', 200, '87', '2016');

delete from perf_t_impexpsub t where t.mainguid='dept';
insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR)
values ('C3C17A38C182E694E053B11FA8C01A83', 'agencyguid', 'VD00010', '单位编码', 1, null, null, 'tree', 'dept', 100, '87', '2016');

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR)
values ('C3C17A38C183E694E053B11FA8C01A83', 'agencyname', null, '单位名称', 2, null, null, 's', 'dept', 160, '87', '2016');

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR)
values ('C3C17A38C184E694E053B11FA8C01A83', 'opinion', null, '修改意见', 11, null, null, 's', 'dept', 200, '87', '2016');


--部门绩效工作管理考核附件
delete from PERF_FILETYPE t where bustype='deptworkeval';
insert into PERF_FILETYPE (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('C3D9A9E30ADE118AE053B11FA8C0F105', '001', '绩效工作管理考核', null, '#', 1, 0, 1, 1, 'deptworkeval', null, null, 2016, '87');

insert into PERF_FILETYPE (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('C3D9A9E30ADF118AE053B11FA8C0F105', '001001', '附件材料', null, 'C3D9A9E30ADE118AE053B11FA8C0F105', 2, 1, 2, 1, 'deptworkeval', null, null, 2016, '87');

--更改附件类型表的年度和区划，此表未分年度和区划
update PERF_FILETYPE t set t.YEAR = '2016', t.PROVINCE='87';