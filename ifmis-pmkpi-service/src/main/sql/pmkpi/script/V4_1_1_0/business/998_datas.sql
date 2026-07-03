begin
  
--页面配置菜单配置
delete from perf_t_pagemenu t where t.guid='C12C791640FD6DE7B08C9CB27643B057';
insert into perf_t_pagemenu (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('C12C791640FD6DE7B08C9CB27643B057', '5', '绩效指标调整（新）', '/pmkpi/adjust/report/proedit/newindex', 'CCF16B4354E26519E0530B4B050A695B', 4, 1, 5, 1, '20240407161424', '20240407161424', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', '2016');

--审核定义菜单配置
delete from perf_t_auditdefinemenu t where t.guid='157D584890FA7D71E0635B03A8C0BEAB';
insert into perf_t_auditdefinemenu (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('157D584890FA7D71E0635B03A8C0BEAB', '008001005', '项目调整指标（新）', null, 'B99067F619D5E2E2E053B11FA8C09FEF', 3, 1, 5, 1, '20240407161904', '20240407161904', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', 2016);

--页签非空必填校验
delete from perf_t_uitabpage_chec t where t.key='/pmkpi/adjust/report/proedit' and t.code='pronewindex' and t.year='2016' and t.province='87';
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('157D584891857D71E0635B03A8C0BEAB', 'D4D3D3E37A60274CE0533315A8C0ACDD', '绩效指标调整(新)', '/pmkpi/adjust/report/proedit', 'pronewindex', 1, 'v_perf_t_adjustindex', '20220719174409', '20220719174409', '2016', '87');


--典型案例类型枚举
delete from perf_enum where ELEMENTCODE = 'PERFTYPICALCASETYPE';

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('PERFTYPICALCASETYPE1', '01', 'PERFTYPICALCASETYPE', '事前绩效评估案例', '1', '20210118162733', '20231108164241', '2016', '87', 1, 'pmkpi', '#', 1, 1, null, null, 0);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('PERFTYPICALCASETYPE2', '02', 'PERFTYPICALCASETYPE', '绩效目标案例', '1', '20210118162733', '20231108164241', '2016', '87', 1, 'pmkpi', '#', 1, 1, null, null, 0);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('PERFTYPICALCASETYPE3', '03', 'PERFTYPICALCASETYPE', '绩效监控案例', '1', '20210118162733', '20231108164241', '2016', '87', 1, 'pmkpi', '#', 1, 1, null, null, 0);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('PERFTYPICALCASETYPE4', '04', 'PERFTYPICALCASETYPE', '绩效评价案例', '1', '20210118162733', '20231108164241', '2016', '87', 1, 'pmkpi', '#', 1, 1, null, null, 0);

--典型案例左侧树配置
delete from perf_t_treetab where KEY = '/pmkpi/setting/typicalcase/list';

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values (sys_guid(), '/pmkpi/setting/typicalcase/list', 'program', '案例类型', 1, null, 1, '2016', '87', null, 'programtypicalcasehide', '{"leftsource":"PERFTYPICALCASETYPE"}');

--典型案例附件类型
delete from perf_filetype where BUSTYPE = 'typicalcase';

insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('PPP6P63FQW190CC3E053B11FA8C0BCC1', '001', '典型案例附件', null, '#', 1, 0, 1, 1, 'typicalcase', null, null, 2016, '87');

insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('PPP6P63F3RT90CC3E053B11FA8C0BCC1', '001001', '附件材料', null, 'PPP6P63FQW190CC3E053B11FA8C0BCC1', 2, 1, 2, 1, 'typicalcase', null, null, 2016, '87');


--典型案例菜单配置
delete from perf_t_pagemenu where UIKEY in ('/pmkpi/setting/typicalcase/edit','/pmkpi/setting/typicalcase/info');

insert into perf_t_pagemenu (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('DDE06F920398B2D57065823F5B3C4466', '10000201801', '典型案例编辑', '/pmkpi/setting/typicalcase/edit', '31F69DDC7CQ142B8BBB71696FDBD9D39', 4, 1, 1, 1, '20240410134634', '20240410134634', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', '2016');

insert into perf_t_pagemenu (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('16E9B9D9ECDCF50F4EBB0897DE5D1A03', '10000201802', '典型案例基本信息', '/pmkpi/setting/typicalcase/info', '31F69DDC7CQ142B8BBB71696FDBD9D39', 4, 1, 2, 1, '20240410170211', '20240410170211', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', '2016');

--多年度项目自评查询左侧树页签配置
delete from perf_t_treetab t where t.key in('/pmkpi/perfself/comperquery');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values ('161D96F3A98F60F9E0635B03A8C0EBBA', '/pmkpi/perfself/comperquery', 'program', '项目支出', 1, null, 1, '2016', '87', null, 'programselfcomperqueryhide', null);
