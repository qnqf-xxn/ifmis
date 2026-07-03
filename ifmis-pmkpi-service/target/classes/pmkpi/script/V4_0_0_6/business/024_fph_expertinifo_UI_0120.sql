begin
  

--专家库
DELETE FROM p#busfw_t_Uitable t where t.tablecode='/pmkpi/setting/baseinfo/expertinifo';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('EE7262BB094441328BF937B618E140E1', '/pmkpi/setting/baseinfo/expertinifo', 'V_PERF_EXPERTINIFO', 100, 0, 0, null, null, 'pmkpi', null);


DELETE FROM p#busfw_t_Uicolumn t where t.key='/pmkpi/setting/baseinfo/expertinifo';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2F3F1CA6719C484F8441D271FD9A2775', '/pmkpi/setting/baseinfo/expertinifo', 'NAME', '专家名称', 1, 1, 0, 0, null, 1, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('817DC42F114B420592457D1E007B2FB3', '/pmkpi/setting/baseinfo/expertinifo', 'GUID', 'GUID', 0, 0, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0C5032639F1049E1990B9031742671FF', '/pmkpi/setting/baseinfo/expertinifo', 'CATEGORY', '专家类别', 15, 1, 0, 0, null, 0, null, null, '#code-#name', null, null, null, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('FEE3A6E22A9C4D0CBDBAD8C663CC7BA3', '/pmkpi/setting/baseinfo/expertinifo', 'WORKEXPERIE', '工作经验', 5, 1, 0, 0, null, 0, null, null, '#code-#name', null, null, null, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('8D3D757850FE4BE2B01EC98B0B5D532E', '/pmkpi/setting/baseinfo/expertinifo', 'CREDITNO', '信用等级', 7, 1, 0, 0, null, 0, null, null, '#code-#name', null, null, null, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('EF6A8929529542B9A14CB8FB29A5A58C', '/pmkpi/setting/baseinfo/expertinifo', 'EVALUATENUM', '评价累计数', 9, 1, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BCAF606CE33F4C47A7D772E3F4DCFED0', '/pmkpi/setting/baseinfo/expertinifo', 'REGION', '专家地域', 11, 1, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2B4FF5160A564235A278056A8ABF6144', '/pmkpi/setting/baseinfo/expertinifo', 'PHONE', '联系电话', 13, 1, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D92071739F674D47950A2991DB380621', '/pmkpi/setting/baseinfo/expertinifo', 'WORKPLACE', '工作单位', 3, 1, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('6FCD36712B524B91956D411A9E4A87F9', '/pmkpi/setting/baseinfo/expertinifo', 'PROFESSIONAL', '专业技术职称', 5, 1, 0, 0, null, 0, null, null, '#code-#name', null, null, null, 1, 'tree', null, null);


DELETE FROM p#busfw_t_Uifunction t where t.key='/pmkpi/setting/baseinfo/expertinifo';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('608E1F09731A49278C98A43EDE2439F7', '/pmkpi/setting/baseinfo/expertinifo', '查询', 1, 4, 'Keepicon', 'baseinfo.query', null, '查询', 'pmkpi', null, null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('07CC9D3AA6AB42A3ABDD4D9F41D9E4A1', '/pmkpi/setting/baseinfo/expertinifo', '新增', 1, 1, 'Keepicon', 'baseinfo.add', null, '新增', 'pmkpi', null, null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DBA600683EDD48E4833A52AFB900CE6E', '/pmkpi/setting/baseinfo/expertinifo', '修改', 1, 2, 'Keepicon', 'baseinfo.update', null, '修改', 'pmkpi', null, null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('4CA059971BCF4389ACDDE6730A27DFF1', '/pmkpi/setting/baseinfo/expertinifo', '删除', 1, 3, 'Keepicon', 'baseinfo.del', null, '删除', 'pmkpi', null, null, null);


DELETE FROM p#busfw_t_Uiqueryform t where t.key='/pmkpi/setting/baseinfo/expertinifo';
insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('3F02330EA6D04844AD785F9E857B4AF2', '/pmkpi/setting/baseinfo/expertinifo', 'CREDITNO', '信用等级', 3, 1, 's', null, null, null, 'pmkpi', 'V_PERF_EXPERTINIFO', '{}', null);

insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('3F02330EA6D04844AD785F93334AF2', '/pmkpi/setting/baseinfo/expertinifo', 'PROFESSIONAL', '专业技术职称', 2, 1, 's', null, null, null, 'pmkpi', 'V_PERF_EXPERTINIFO', '{}', null);

--专家库编辑

DELETE FROM p#busfw_t_Uifunction t where t.key='/pmkpi/setting/baseinfo/expertinifo/edit';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('9B1AA405F8894B12B69D5D328AEF1C67', '/pmkpi/setting/baseinfo/expertinifo/edit', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', 'cancle', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('18417BF749F04EC38FFA93EF7310C2DF', '/pmkpi/setting/baseinfo/expertinifo/edit', '保存', 1, 1, 'Keepicon', 'baseinfoedit.infosave', null, '保存', 'pmkpi', 'infosave', null, null);


DELETE FROM p#busfw_t_Uieditform t where t.key='/pmkpi/setting/baseinfo/expertinifo/edit';
insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('0FD9F772A69E4256A9BF8DD6DCEE6688', '/pmkpi/setting/baseinfo/expertinifo/edit', 'V_PERF_EXPERTINIFO', 's', '主键', 'GUID', 0, null, 1, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B45263CF753043E98F688BB674486C31', '/pmkpi/setting/baseinfo/expertinifo/edit', 'V_PERF_EXPERTINIFO', 's', '专家编码', 'CODE', 1, null, 1, null, 2, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('851F705895E5403ABD9B2920D2E2F3C8', '/pmkpi/setting/baseinfo/expertinifo/edit', 'V_PERF_EXPERTINIFO', 's', '姓名', 'NAME', 1, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('19C1772464F44468B934702DEEF6A51D', '/pmkpi/setting/baseinfo/expertinifo/edit', 'V_PERF_EXPERTINIFO', 's', '年度', 'YEAR', 0, null, 0, null, 30, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('763C270FDAA142C89DD79D1425043F83', '/pmkpi/setting/baseinfo/expertinifo/edit', 'V_PERF_EXPERTINIFO', 's', '区划', 'PROVINCE', 0, null, 0, null, 31, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('19448A376EE94044BE400B34F524B1F9', '/pmkpi/setting/baseinfo/expertinifo/edit', 'V_PERF_EXPERTINIFO', 's', '工作单位', 'WORKPLACE', 1, null, 1, null, 5, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('63472E134D95436687F6268F16944566', '/pmkpi/setting/baseinfo/expertinifo/edit', 'V_PERF_EXPERTINIFO', 's', '身份证号', 'IDCARD', 1, null, 1, null, 6, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('14546CF19FF1471C8646707F7381D76A', '/pmkpi/setting/baseinfo/expertinifo/edit', 'V_PERF_EXPERTINIFO', 'tree', '民族', 'NATION', 1, null, 1, null, 7, null, null, 'pmkpi', 1, null, '{"format":"#code-#name"}', 0, 1, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('1B94642232324471C8646707F7381D76A', '/pmkpi/setting/baseinfo/expertinifo/edit', 'V_PERF_EXPERTINIFO', 'tree', '政治面貌', 'POLITICAL', 1, null, 1, null, 8, null, null, 'pmkpi', 1, null, '{"format":"#code-#name"}', 0, 1, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('233235F19FF1471C8646707F7345454', '/pmkpi/setting/baseinfo/expertinifo/edit', 'V_PERF_EXPERTINIFO', 'd', '出生日期', 'BIRTH', 1, null, 0, null, 9, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('1B454677FF1471C8646707F7381D76A', '/pmkpi/setting/baseinfo/expertinifo/edit', 'V_PERF_EXPERTINIFO', 'tree', '学历', 'EDUCATION', 1, null, 1, null, 10, null, null, 'pmkpi', 1, null, '{"format":"#code-#name"}', 0, 1, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('erhe576342324248646707F7381D76A', '/pmkpi/setting/baseinfo/expertinifo/edit', 'V_PERF_EXPERTINIFO', 's', '毕业院校', 'GRADUATE', 1, null, 1, null, 11, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('wfdf3435CF19FF1471C8646707F7381D76A', '/pmkpi/setting/baseinfo/expertinifo/edit', 'V_PERF_EXPERTINIFO', 'tree', '专业技术职称', 'PROFESSIONAL', 1, null, 1, null, 12, null, null, 'pmkpi', 1, null, '{"format":"#code-#name"}', 0, 1, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('34251471C8646707F7381D76A4545454', '/pmkpi/setting/baseinfo/expertinifo/edit', 'V_PERF_EXPERTINIFO', 's', '专家地域', 'REGION', 1, null, 0, null, 13, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('46577CF19FF1471C8646707F7381D76A', '/pmkpi/setting/baseinfo/expertinifo/edit', 'V_PERF_EXPERTINIFO', 's', '专业特长', 'SPECIALTY', 1, null, 1, null, 14, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('dfw3435359FF1471C8646707F7381D76A', '/pmkpi/setting/baseinfo/expertinifo/edit', 'V_PERF_EXPERTINIFO', 's', '注册执业资格', 'CERTIFICATE', 1, null, 0, null, 15, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('465757757FF1471C8646707F7381D76A', '/pmkpi/setting/baseinfo/expertinifo/edit', 'V_PERF_EXPERTINIFO', 'tree', '信用等级', 'CREDITNO', 1, null, 0, null, 16, null, null, 'pmkpi', 1, null, '{"format":"#code-#name"}', 0, 1, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('oifhrgh57FF1471C8646707F7381D76A', '/pmkpi/setting/baseinfo/expertinifo/edit', 'V_PERF_EXPERTINIFO', 's', '联系方式', 'TEL', 1, null, 1, null, 17, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('4565476557FF1471C8646707F7381D76A', '/pmkpi/setting/baseinfo/expertinifo/edit', 'V_PERF_EXPERTINIFO', 'tree', '工作经验', 'WORKEXPERIE', 1, null, 1, null, 18, null, null, 'pmkpi', 1, null, '{"format":"#code-#name"}', 0, 1, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('567dfsfgFF1471C8646707F7381D76A', '/pmkpi/setting/baseinfo/expertinifo/edit', 'V_PERF_EXPERTINIFO', 'tree', '专家类别', 'CATEGORY', 1, null, 1, null, 19, null, null, 'pmkpi', 1, null, '{"format":"#code-#name"}', 0, 1, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('987esgreewgF1471C8646707F7381D76A', '/pmkpi/setting/baseinfo/expertinifo/edit', 'V_PERF_EXPERTINIFO', 'tree', '行业类别', 'CATEGORY02', 1, null, 0, null, 20, null, null, 'pmkpi', 1, null, '{"format":"#code-#name"}', 0, 1, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('4636436346F1471C8646707F7381D76A', '/pmkpi/setting/baseinfo/expertinifo/edit', 'V_PERF_EXPERTINIFO', 'tree', '行业大类', 'CATEGORY03', 1, null, 0, null, 21, null, null, 'pmkpi', 1, null, '{"format":"#code-#name"}', 0, 1, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('346557FF1471C8646707F7381D76A4356', '/pmkpi/setting/baseinfo/expertinifo/edit', 'V_PERF_EXPERTINIFO', 's', '联系地址', 'ADDRESS', 1, null, 1, null, 22, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('3454368646707F7381D76Ahdqwe23526', '/pmkpi/setting/baseinfo/expertinifo/edit', 'V_PERF_EXPERTINIFO', 'd', '评聘时间', 'EMPLOYDATA', 1, null, 0, null, 23, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('2353257FF1471C8646707F7381D76A353', '/pmkpi/setting/baseinfo/expertinifo/edit', 'V_PERF_EXPERTINIFO', 'textarea', '个人论著及参与的重大研究项目（限2000字内）', 'TREATISE', 1, null, 0, null, 25, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('3463471C8646707F7381D73465252vgg', '/pmkpi/setting/baseinfo/expertinifo/edit', 'V_PERF_EXPERTINIFO', 'textarea', '近三年参与的绩效评价项目（限2000字内）', 'PERFPRO', 1, null, 0, null, 24, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);
