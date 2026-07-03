begin

--是否显示AI模型思考过程 默认为是
delete from perf_t_systemset where paramcode='isShowAIThink';
insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('33D233B806287114E063020011AC1DEC', 'isShowAIThink', '是否显示AI模型思考过程', '1', '1-是，0-否；', 'pmkpi', 98, 2016, '87', 1);

--纳入指标库配置节点
delete from perf_t_pagemenu t where t.uikey='/pmkpi/intoindexlib/index';
insert into perf_t_pagemenu (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values ('7B2F5593BC4D8CF404A47738216EE678', '02', '纳入指标库', '/pmkpi/intoindexlib/index', 'D574940480DF7ED4E0533315A8C059D3', 4, 1, 2, 1, '20250610095544', '20250610095544', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', '2016');

--（浙江）抽评对象已提交导入模板
delete from p#fw_t_importtemplate where tempcode = 'pmkpi_objectsubmit' and VCHTYPEID = '27EEDFD75D969E146149497926D632E2';
insert into fw_t_importtemplate (GUID, TEMPCODE, TEMPNAME, COLSPLIT, TABLECODE, CALLBACKBEANID, DEFAULTVALUE, CALLBACKMETHOD, APPID, VCHTYPEID, YEAR, PROVINCE, JILIANXIANGMU, PROCODE, PARENTCODE)
values ('36A54CA816748EFAE0638416A8C0C44C', 'pmkpi_objectsubmit', '抽评对象导入模板', ',', 'V_PERF_T_RANDOMCOMMENT', 'pmkpi.randomcomment.RandomCommentObjectBOTX', null, 'importRandomObject', 'C43D8AA7015B7F8B25CA18C3277CA4BE', '27EEDFD75D969E146149497926D632E2', '2016', '87', null, null, null);

delete from p#fw_t_importtempdetail where TEMPID = '36A54CA816748EFAE0638416A8C0C44C';
insert into fw_t_importtempdetail (GUID, COLUMNID, TEMPID, ORDERNUM, YEAR, PROVINCE, IMPORTDS, IMPORTDSCFG, SHOWNAME, REDDEN)
values ('1791D65T5E0D86471A6821753D1993DA', 'V22B314BC2575271E0530100007F1Q31', '36A54CA816748EFAE0638416A8C0C44C', 0, '2016', '87', 'checked', null, '项目编码(请设置本列为文本格式)', null);

