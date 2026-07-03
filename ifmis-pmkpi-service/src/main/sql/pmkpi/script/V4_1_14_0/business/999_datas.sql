begin
  
delete from perf_t_impexpmain t where code= 'selfprogram';
insert into perf_t_impexpmain (GUID, CODE, NAME, PROVINCE, YEAR, TABLECODE, BEANID)
values ('627B7A9E93A8AD777959485BB4780294', 'selfprogram', '自评指标（项目支出）', '87', '2016', 'PERF_T_SELFPERFINDEX', 'pmkpi.perfSelf.SelfIndexBOTX');

delete from perf_t_impexpsub t  where  mainguid= 'selfprogram';
insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE, REDDEN)
values ('FEA3C1E7ADB1B772049D733EA0CC444B', 'findex', 'PMKPIFINFRAME', '一级指标', 1, null, null, 'tree', 'selfprogram', 100, '87', '2016', null, 'frametype=''PM001''', null, null);

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE, REDDEN)
values ('F707C8CC9CC95E6EA2A0374349E5350C', 'sindex', 'PMKPISINFRAME', '二级指标', 2, null, null, 'tree', 'selfprogram', 100, '87', '2016', null, 'frametype=''PM001''', null, null);

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE, REDDEN)
values ('FA22301AECCB8104EA17269E36DEA6F5', 'name', null, '三级指标名称', 3, null, null, 's', 'selfprogram', 150, '87', '2016', null, null, null, null);

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE, REDDEN)
values ('77F204FC771BDFBEFD47C82085D09E79', 'computesign', 'PMKPIZBXS', '计算符号', 4, null, null, 'tree', 'selfprogram', 100, '87', '2016', null, null, null, null);

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE, REDDEN)
values ('FC20DCF2236FD72832A8AE08F7D9F8CD', 'indexval', null, '指标值', 5, null, null, 's', 'selfprogram', 100, '87', '2016', null, null, null, null);

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE, REDDEN)
values ('517DDC73707C17347018E39F85A65259', 'actualvalue', null, '*实际完成值（定量填数字，定性填达成、部分达成、未达成）', 6, null, null, 's', 'selfprogram', 100, '87', '2016', null, null, null, '1');

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE, REDDEN)
values ('5593AE634649F337A4C9BB005C22A0AB', 'meterunit', null, '计量单位', 7, null, null, 's', 'selfprogram', 100, '87', '2016', null, null, null, null);

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE, REDDEN)
values ('1185D248DC37D05096B80CAD7F5219CD', 'actualweight', null, '*分值 数量(20)、质量(10)、时效(10)、成本(10)、效益(30)、满意度(10)', 8, null, null, 'f', 'selfprogram', 100, '87', '2016', null, null, null, '1');

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE, REDDEN)
values ('6750DE3F9949B44EA96098691050F17F', 'score', null, '*指标得分（定量系统自动计算，定性必填，所填值为原指标得分，不包含扣减分数。）', 9, null, null, 'f', 'selfprogram', 100, '87', '2016', null, null, null, '1');

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE, REDDEN)
values ('4E93D6823B5F329E0A01605DDDAEF725', 'deduct_score', null, '扣减分数', 10, null, null, 'f', 'selfprogram', 100, '87', '2016', null, null, null, null);

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE, REDDEN)
values ('8E8AE5E8842B555DE588E1F8E10A00AF', 'score_remark', null, '完成情况简要描述（定量选填，定性必填）', 11, null, null, 's', 'selfprogram', 200, '87', '2016', null, null, null, null);

insert into perf_t_impexpsub (GUID, COLUMNCODE, CSID, NAME, ORDERNUM, HEAD, FORMAT, TYPE, MAINGUID, COLWIDTH, PROVINCE, YEAR, IMPORTDS, IMPORTDSCFG, TABLECODE, REDDEN)
values ('C7CEDA30E0312C76EF412977788F2F11', 'kpi_remark', null, '偏差原因及改进措施（指标未完成时必填）', 12, null, null, 's', 'selfprogram', 200, '87', '2016', null, null, null, null);