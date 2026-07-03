begin
 
--控制部门评价成果申报-评价成果上传-评价成果(处室)附件页面是否可编辑
delete from perf_t_systemset where PARAMCODE = 'DEPTEVALUATIONFILE';
insert into perf_t_systemset (GUID, PARAMCODE, PARAMNAME, PARAMVALUE, REMARK, APPID, ORDERNUM, YEAR, PROVINCE, STATUS)
values ('92ADF6743363DAF73FD6742E80E9E353', 'DEPTEVALUATIONFILE', '控制部门评价成果申报-评价成果上传-评价成果(处室)附件页面是否可编辑', '{"isedit":""}', '部门评价成果申报时只读，部门评价成果审核时可填写 根据角色控制 引号中配置可编辑的角色guid 多个角色用,隔开', 'pmkpi', 4, 2016, '87', 1);


--部门评价成果申报-【评价成果上传】-评价成果(处室)附件类型
delete from PERF_FILETYPE where bustype = 'findeptevaproresult';
insert into PERF_FILETYPE (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('E1F3658DF56F48791107CEADC2855535', '001002', '其他材料', null, '11AB1CB1A1333C322B30B63CB5D16A8E', 2, 1, 3, 1, 'findeptevaproresult', null, null, 2016, '87');

insert into PERF_FILETYPE (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('A2684020A0B7C36E63C81778BDC48F95', '001001', '评价报告', null, '11AB1CB1A1333C322B30B63CB5D16A8E', 2, 1, 2, 1, 'findeptevaproresult', null, null, 2016, '87');

insert into PERF_FILETYPE (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('11AB1CB1A1333C322B30B63CB5D16A8E', '001', '材料', null, '#', 1, 0, 1, 1, 'findeptevaproresult', null, null, 2016, '87');



--财政评价新增项目 类别字段  数据源注册
delete from fasp_t_dicdssource where guid ='FINANCIALEVALTYPE';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('FINANCIALEVALTYPE', 'FINANCIALEVALTYPE', 'FINANCIALEVALTYPE', '财政评价类别', '1', null, null, null, '2016', '87', null, null, null, '2', 'SELECT t.*,rowid FROM v_perf_enum t where t.elementcode=''FINANCIALEVALTYPE'' order by t.ordernum', null, null, 'pmkpi');

delete from perf_enum t where elementcode ='FINANCIALEVALTYPE';
insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('FINANCIALEVALTYPE01', '1', 'FINANCIALEVALTYPE', '中央对省', '1', '20240109152134', '20240109152134', '2016', '87', null, 'pmkpi', '#', 1, 1, null, null, 1);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('FINANCIALEVALTYPE03', '3', 'FINANCIALEVALTYPE', '部门预算(省直专项)', '1', '20240109152134', '20240109152134', '2016', '87', null, 'pmkpi', '#', 1, 1, null, null, 1);

insert into perf_enum (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE, VERSION, APPID, SUPERID, LEVELNO, ISLEAF, REMARK, CREATER, ORDERNUM)
values ('FINANCIALEVALTYPE02', '2', 'FINANCIALEVALTYPE', '省级对下', '1', '20240109152134', '20240109152134', '2016', '87', null, 'pmkpi', '#', 1, 1, null, null, 1);
