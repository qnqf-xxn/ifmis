begin

--去掉 自评的权重控制参数
delete from perf_t_systemset where paramcode  = 'weight_control';

--财政评价项目查询-左侧树类型
delete from perf_t_treetab t where t.key in('/pmkpi/evaluation/financial/query');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('D42C217B4BE02931E0533315A8C044CA', '/pmkpi/evaluation/financial/query', 'program', '项目支出', 1, null, 1, '2016', '87', null, 'programfinqueryhide');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('D42C217B4BE12931E0533315A8C044CA', '/pmkpi/evaluation/financial/query', 'dept', '部门整体', 1, null, 2, '2016', '87', null, 'deptfinqueryhide');

delete from perf_t_warnset t where t.type in('selfscoreprogram','selfresultprogram','selfscoreproject','selfresultproject');
insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('42B24123FF9B4AEA8B2EF6AC467B1C69', 'selfresultprogram', '自评结论-项目', 'selfresultprogram', 'select case when nvl(s.score,0) + nvl(a.bgtscore,0) >= 80 then ''优'' when (nvl(s.score, 0) + nvl(a.bgtscore,0) >= 70 and nvl(s.score, 0) + nvl(a.bgtscore,0) < 80)  then ''良'' when (nvl(s.score, 0) + nvl(a.bgtscore,0) >= 60 and nvl(s.score, 0) + nvl(a.bgtscore,0) < 70) then ''中'' when nvl(s.score, 0) + nvl(a.bgtscore,0) < 60 then ''差'' end as value FROM v_perf_t_selfevaltask t left join (select c.mainguid, c.pro_code, sum(c.score) score from V_PERF_T_SELFPERFINDEX c group by c.mainguid, c.pro_code) s on t.pro_code=s.pro_code left join (select nvl(nvl(sum(AMT4),0)/decode(nvl(sum(AMT3),1),0,1,nvl(sum(AMT3),1)) * 10, 0) bgtscore, pro_code from v_perf_t_selfprofund group by pro_code) a on t.pro_code = a.pro_code where t.guid = ''#mainguid#''', null, null, '2016', '87');

insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('82D0DB61BF2C4141BAC71290DE2EF1EF', 'selfscoreprogram', '自评得分-项目', 'selfscoreprogram', 'select to_char(nvl(s.score, 0) + nvl(a.bgtscore,0),''FM990.00'') value FROM v_perf_t_selfevaltask t left join (select c.mainguid, c.pro_code, sum(c.score) score from V_PERF_T_SELFPERFINDEX c group by c.mainguid, c.pro_code) s on t.pro_code=s.pro_code left join (select nvl(nvl(sum(AMT4),0)/decode(nvl(sum(AMT3),1),0,1,nvl(sum(AMT3),1)) * 10, 0) bgtscore, pro_code from v_perf_t_selfprofund group by pro_code) a on t.pro_code = a.pro_code where t.guid = ''#mainguid#''', null, null, '2016', '87');


--添加 问题整改列表查询 菜单
delete from perf_t_treetab where key ='/pmkpi/rectification/query';
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439F3375E0533315A8C0E114', '/pmkpi/rectification/query', 'dept', '部门整体', 1, '查看项目', 2, '2016', '87', 'BD53404301784449E053B11FA8C0DF9A', 'deptrectifyqueryhide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439F3375E0533315A8C0E115', '/pmkpi/rectification/query', 'program', '项目支出', 1, null, 1, '2016', '87', 'BD057E3C39B96759E053B11FA8C06040', 'programrectifyqueryhide');

delete from perf_t_warnset t where t.type='bgttracewarn';
insert into perf_t_warnset (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('DB8540E3EF9A46E0B82BC415F11CD0AD', 'bgttracewarn', '预算执行预警', 'bgttracewarn', 'select case when value < 60 then ''red'' when 60 <= value and value < 80 then ''yellow'' when 80 <= value then ''green'' end value from (select (select case when sum(amt3) is null or sum(amt4) is null then 0 else sum(amt4)/sum(amt3) end bgtget from v_perf_t_probgtfund where mainguid=''#mainguid#'')/(#month#/12)*100 value from dual) a', null, null, '2016', '87');

--自评评审意见导入
delete from p#fw_t_importtemplate t where t.tempcode in('pmkpi_self_002','pmkpi_self_001');
insert into fw_t_importtemplate (GUID, TEMPCODE, TEMPNAME, COLSPLIT, TABLECODE, CALLBACKBEANID, DEFAULTVALUE, CALLBACKMETHOD, APPID, VCHTYPEID, YEAR, PROVINCE)
values ('D42BA376643D2A20E0533315A8C085FA', 'pmkpi_self_001', '项目支出-绩效自评评审意见导入模板', ',', 'PERF_V_SELFPERFOPINIONIMP', 'pmkpi.perfSelf.PerfSelfAuditBOTX', null, 'importOpinionData', 'C43D8AA7015B7F8B25CA18C3277CA4BE', 'D42BA37664C72A20E0533315A8C085FA', '2016', '87');

insert into fw_t_importtemplate (GUID, TEMPCODE, TEMPNAME, COLSPLIT, TABLECODE, CALLBACKBEANID, DEFAULTVALUE, CALLBACKMETHOD, APPID, VCHTYPEID, YEAR, PROVINCE)
values ('D42BA37664412A20E0533315A8C085FA', 'pmkpi_self_002', '部门整体-绩效自评评审意见导入模板', ',', 'PERF_V_SELFPERFOPINIONIMP', 'pmkpi.perfSelf.PerfSelfAuditBOTX', null, 'importOpinionData', 'C43D8AA7015B7F8B25CA18C3277CA4BE', 'D42BA37664CB2A20E0533315A8C085FA', '2016', '87');

delete from p#fw_t_importtempdetail t where t.tempid in('D42BA376643D2A20E0533315A8C085FA','D42BA37664412A20E0533315A8C085FA');
insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, YEAR, PROVINCE)
values ('A1082D25F0EBB89CD0D98D7A8A4BE41F', 'D42BA37664882A20E0533315A8C085FA', 'D42BA376643D2A20E0533315A8C085FA', 0, null, null, '2016', '87');

insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, YEAR, PROVINCE)
values ('F47CD517F703511CF8B36922A82E279A', 'D42BA37664892A20E0533315A8C085FA', 'D42BA376643D2A20E0533315A8C085FA', 1, null, null, '2016', '87');

insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, YEAR, PROVINCE)
values ('62AB67B7EB197B52AF54F1467248791E', 'D42BA37664872A20E0533315A8C085FA', 'D42BA376643D2A20E0533315A8C085FA', 2, null, null, '2016', '87');

insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, YEAR, PROVINCE)
values ('FB8AAD29A4D526D5E16BD7C66B8C9038', 'D42BA37664862A20E0533315A8C085FA', 'D42BA376643D2A20E0533315A8C085FA', 3, null, null, '2016', '87');

insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, YEAR, PROVINCE)
values ('E5EC06538712840A5E6269BAE0CC2C4F', 'D42BA37664822A20E0533315A8C085FA', 'D42BA376643D2A20E0533315A8C085FA', 4, null, null, '2016', '87');

insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, YEAR, PROVINCE)
values ('0B5DE865312CF8EC3FAA2A6238569CCE', 'D42BA37664832A20E0533315A8C085FA', 'D42BA376643D2A20E0533315A8C085FA', 5, null, null, '2016', '87');

insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, YEAR, PROVINCE)
values ('064E2242A071738EF8D8937105B6E37E', 'D42BA37664852A20E0533315A8C085FA', 'D42BA376643D2A20E0533315A8C085FA', 6, null, null, '2016', '87');

insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, YEAR, PROVINCE)
values ('6AF99728D0C3F15EB1201C59925E2241', 'D42BA37664842A20E0533315A8C085FA', 'D42BA376643D2A20E0533315A8C085FA', 7, null, null, '2016', '87');

insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, YEAR, PROVINCE)
values ('8F5062EEC20CA361665ADA700668C650', 'D42BA37664882A20E0533315A8C085FA', 'D42BA37664412A20E0533315A8C085FA', 0, null, null, '2016', '87');

insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, YEAR, PROVINCE)
values ('C522ED881F505BA60554237B94BB189C', 'D42BA37664892A20E0533315A8C085FA', 'D42BA37664412A20E0533315A8C085FA', 1, null, null, '2016', '87');

insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, YEAR, PROVINCE)
values ('4F21A97F6F5205E7D0B6604D3C514CE6', 'D42BA37664822A20E0533315A8C085FA', 'D42BA37664412A20E0533315A8C085FA', 2, null, null, '2016', '87');

insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, YEAR, PROVINCE)
values ('B6F77B192955963FF606B98C81095F8B', 'D42BA37664832A20E0533315A8C085FA', 'D42BA37664412A20E0533315A8C085FA', 3, null, null, '2016', '87');

insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, YEAR, PROVINCE)
values ('5C8ABCB562B12328A4FF25F0468CE539', 'D42BA37664852A20E0533315A8C085FA', 'D42BA37664412A20E0533315A8C085FA', 4, null, null, '2016', '87');

insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, IMPORTDS, IMPORTDSCFG, YEAR, PROVINCE)
values ('F89C2DC15EB9CB8475A5D14BD2D63899', 'D42BA37664842A20E0533315A8C085FA', 'D42BA37664412A20E0533315A8C085FA', 5, null, null, '2016', '87');

--添加自评控制评审意见参数
delete from perf_t_systemset t where t.paramcode='PERFSELFOPINION';

--绩效监控审核-监控审核节点-审核方式数据源
delete from perf_t_datasource where elementcode = 'traceaudittype';
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('4', '004', '委托中介机构', null, null, null, null, 0, 'traceaudittype', 1, '20201229', '20201229', 2016, '87');
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2', '001', '委托专家组', null, null, null, null, 1, 'traceaudittype', 1, '20201229', '20201229', 2016, '87');
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('1', '002', '通过', null, null, null, null, 2, 'traceaudittype', 1, '20201229', '20201229', 2016, '87');
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('3', '003', '不通过', null, null, null, null, 3, 'traceaudittype', 1, '20201229', '20201229', 2016, '87');

--绩效自评评审意见附件类型
delete from perf_filetype t where t.bustype='perfselfopinion';
insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('D42BA37663FA2A20E0533315A8C085FA', '001', '评审附件', null, '#', 1, 0, 1, 1, 'perfselfopinion', null, null, 2016, '87');

insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('D42BA37663FB2A20E0533315A8C085FA', '001001', '评审意见', null, 'D42BA37663FA2A20E0533315A8C085FA', 2, 1, 2, 1, 'perfselfopinion', null, null, 2016, '87');

--财政评价项目确定-左侧页签隐藏按钮
delete from perf_t_treetab t where t.key in('/pmkpi/evaluation/financial/proconfirm');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CBFFE5E202901F2CE0533315A8C01584', '/pmkpi/evaluation/financial/proconfirm', 'program', '项目支出', 1, null, 1, '2016', '87', 'BD2785454440A0C1E053B11FA8C0DCF9', 'programfinconfirmhide');
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439E3375E0533315A8C0E201', '/pmkpi/evaluation/financial/proconfirm', 'dept', '部门整体', 1, '审核情况,新增项目,修改项目', 2, '2016', '87', 'BD2785454442A0C1E053B11FA8C0DCF9', 'deptfinconfirmhide');

--绩效监控填报-绩效指标完成情况-定性指标报警灯规则
delete from PERF_T_WARNSET where type='qualitativeindex';
insert into PERF_T_WARNSET (GUID, CODE, NAME, TYPE, WARNSQL, UPDATETIME, CREATETIME, YEAR, PROVINCE)
values ('563FD5339CE04035BB2BA9F120F2241C', 'qualitativeindex03', '定性指标', 'qualitativeindex', 'select case when value = ''达成年度指标'' then ''green'' when value = ''部分达成年度指标并具有一定效果'' then ''yellow'' when value = ''未达成年度指标且效果较差'' then ''red'' end value from (select ''#indexval# '' value from dual) a', '20210420190843', null, '2016', '87');

--删除配置：根据流程节点展示按钮
delete from perf_t_systemset where paramcode =  'isPushWfstatus';

