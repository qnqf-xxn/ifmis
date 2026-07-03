begin
  
delete from perf_t_impexpmain t where t.code='traceprogram';
insert into perf_t_impexpmain (GUID, CODE, NAME, PROVINCE, YEAR, TABLECODE, BEANID)
values ('9560C19EDE4587C73955FD856C8CCF8C', 'traceprogram', '监控指标（项目支出）', '87', '2016', 'PERF_T_PROINDEXTRACE', 'pmkpi.perfprotrace.indextarget.ProIndexTargetBOTX');


delete from perf_t_impexpsub t where t.mainguid='traceprogram';
insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE, REDDEN)
values ('CAE801E00093A0BD706E5A468F6F2417', 'findex', 'PMKPIFINFRAME', '一级指标', 1, null, null, 'tree', 'traceprogram', 100, '87', '2016', null, 'frametype=''PM001''', null, null);

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE, REDDEN)
values ('F14BC1150E6F2D31E0702A8066FB9030', 'sindex', 'PMKPISINFRAME', '二级指标', 2, null, null, 'tree', 'traceprogram', 100, '87', '2016', null, 'frametype=''PM001''', null, null);

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE, REDDEN)
values ('12E8E872162F025226C23AC3426CCEB4', 'name', null, '三级指标名称', 3, null, null, 's', 'traceprogram', 200, '87', '2016', null, null, null, null);

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE, REDDEN)
values ('2411AF6B1D21E846AA09C263394FCD9F', 'computesign', 'PMKPIZBXS', '计算符号', 4, null, null, 'tree', 'traceprogram', 100, '87', '2016', null, null, null, null);

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE, REDDEN)
values ('A44A73188CC651EEAD5E7831DCDBEFC0', 'targetvalue', null, '年度指标值', 5, null, null, 's', 'traceprogram', 150, '87', '2016', null, null, null, null);

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE, REDDEN)
values ('2B071CE1C3AA6C52BEAE4BD5FDDF22A9', 'meterunit', null, '计量单位', 6, null, null, 's', 'traceprogram', 100, '87', '2016', null, null, null, null);

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE, REDDEN)
values ('01779A8B198965338005559AE7C2D56F', 'indexval', null, '*当前完成值（定量填数字，定性填达成、部分达成、未达成）', 7, null, null, 's', 'traceprogram', 100, '87', '2016', null, null, null, '1');

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE, REDDEN)
values ('0500DFE78E742808716B4CDC39F51DC0', 'completeanalysis', 'PMKPICOMPLETEANALYSIS', '*完成可能性分析', 8, null, null, 'tree', 'traceprogram', 150, '87', '2016', null, null, null, '1');

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE, REDDEN)
values ('8603783C62CA370C1637BBB2DAF2833C', 'otherreasons', null, '偏差原因说明', 10, null, null, 's', 'traceprogram', 200, '87', '2016', null, null, null, null);


delete from fasp_t_dicdssource t where t.guid in('PMKPIFINFRAME','PMKPISINFRAME');
insert into FASP_T_DICDSSOURCE (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIFINFRAME', 'PMKPIFINFRAME', 'PMKPIFINFRAME', '一级指标层次分类', '1', '20190508135902672', '20161208', null, '2016', '87', null, null, null, '2', 'select t.guid,code,name ,t.superid superguid,t.levelno levelno,t.isleaf isleaf,t.status,t.frametype,t.guid as findex from v_perf_t_frame t where levelno=''1''', sysdate, 1, 'pmkpi');

insert into FASP_T_DICDSSOURCE (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPISINFRAME', 'PMKPISINFRAME', 'PMKPISINFRAME', '二级指标层次分类', '1', '20190508135902672', '20161208', null, '2016', '87', null, null, null, '2', 'select t.guid,code,name ,t.superid superguid,t.levelno levelno,t.isleaf isleaf,t.status,t.frametype,t.guid as sindex,t.superid as findex from v_perf_t_frame t where levelno=''2''', sysdate, 1, 'pmkpi');

--执行脚本前，请填写数据交互中心的ip，如：http://127.0.0.1:9003
delete from perf_t_systemset t where t.paramcode='DATACOMMUNICATION_BASE' and t.year=2016 and province='87';
insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('54E89421BF3E5DB0E063030011AC0845', 'DATACOMMUNICATION_BASE', '山西数据交互中心配置', '{"ip":"http://127.0.0.1:9003","url":"/dmp/v2/huaqing/perf_t_datacommunication"}', 'ip：数据交互中心服务端口，url：数据交互中心新增/修改/删除url', 'pmkpi', 3, 2016, '87', 1);
