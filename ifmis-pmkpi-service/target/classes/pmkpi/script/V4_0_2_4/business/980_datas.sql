begin

--项目指标表status值改为null，不然调整有问题
update pm_perf_indicator t set t.status = null;
--部门指标表status值改为null，不然调整有问题
update bgt_perf_indicator t set t.status = null;

--绩效自评查询左侧树隐藏按钮
delete from perf_t_treetab t where t.key = '/pmkpi/perfself/query';
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('D0DEA3B03A2E6E68E0533315A8C0AFF2', '/pmkpi/perfself/query', 'program', '项目支出', 1, '导出部门整体自评表,导出部门整体支出绩效自评表（河北）', 1, '2016', '87', '97453626C11A83A453494FB4E08F3C16', 'programselfqueryhide');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('D0DEA3B03A2F6E68E0533315A8C0AFF2', '/pmkpi/perfself/query', 'dept', '部门整体', 1, '查看项目,导出项目自评表,导出项目支出支出绩效自评表（河北）', 2, '2016', '87', 'AB1C3F88E5BA9F021C1D2B249ADBDA27', 'deptselfqueryhide');

--财政评价成果上传审核-审核操作去掉（征求意见）选项
delete from perf_t_datasource t where t.elementcode='ordinaryaudittype';
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('audit', '1', '通过', null, '0', 1, 1, 1, 'ordinaryaudittype', 1, '20210127', '20210127', 2016, '87');
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('back', '2', '不通过，退回完善', null, '0', 1, 1, 2, 'ordinaryaudittype', 1, '20210127', '20210127', 2016, '87');
--insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
--values ('sendaudit', '3', '征求意见', null, '0', 1, 1, 3, 'ordinaryaudittype', 1, '20210127', '20210127', 2016, '87');

--修改系统参数
update perf_t_systemset t set t.paramcode='ISTRACEINITIATEADJUST' ,t.paramname='监控是否发起调整', t.remark='iswfadjust1调整，2不调整, deptwfststus一般监控终审状态，jxwfststus绩效处终审状态' where t.paramcode='iswfadjustconfig';

--系统配置
delete from perf_t_systemset where paramcode = 'finhidebutton';
insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('D9389BA0CDA15150E0533315A8C08AB0', 'finhidebutton', '财政评价成果审核/终稿报告上传菜单按钮隐藏', '{"result":",批量审核,批量退回,上传终稿评价报告","report": ",审核,取消审核,评价成果修改"}', 'result-财政评价成果审核，report-财政终稿报告上传；', null, 4, 2016, '87', 1);


-- 问题整改  整改类型数据源
delete from fasp_t_dicdssource where guid ='RECTYPE' and code ='RECTYPE';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('RECTYPE', 'RECTYPE', 'RECTYPE', '整改类型', '1', '20160106155820402', '20160106', null, '2016', '87', null, null, null, '2', 'select guid,code,name from perf_t_datasource where elementcode =''rectifytype''', null, 1, 'pmkpi');
