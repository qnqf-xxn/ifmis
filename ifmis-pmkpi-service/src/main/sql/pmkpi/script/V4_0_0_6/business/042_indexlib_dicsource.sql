begin
delete from Fasp_t_Dicdssource t where t.elementcode in ('IDEXCOMCLS','INDEXSTANDARDS','INDEXCOMFUNC');
insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('IDEXCOMCLS', 'IDEXCOMCLS', 'IDEXCOMCLS', '共性指标项目分类', '1', '20180613113621631', '20180613113621631', null, '2020', '87', null, null, '1', '2', 'select * from v_perf_enum where elementcode = ''IDEXCOMCLS''', null, 1, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('INDEXSTANDARDS', 'INDEXSTANDARDS', 'INDEXSTANDARDS', '行业标准', '1', '20140422000000000', '20140422000000000', null, '2020', '87', null, null, '1', '2', 'select * from v_perf_enum where elementcode = ''INDEXSTANDARDS''', sysdate, 1, 'pmkpi');

insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('INDEXCOMFUNC', 'INDEXCOMFUNC', 'INDEXCOMFUNC', '财政个性行业', '1', '20140422000000000', '20150423', null, '2020', '87', null, '8717', '1', '2', 'select t.guid,
       t.code,
       t.name,
       t.superguid,
       t.superguid SUPERID,
       t.levelno,
       case
         when t.isleaf = 0 and t.superguid <> ''#'' then
          1
         else
          t.isleaf
       end isleaf,
       t.status
  from V_ELE_VD10004 t
 where t.status = 1
   and t.levelno in (1, 2)
 order by t.code', null, 1, 'pmkpi');

delete from Busfw_t_Dcworkflowplan t where t.CODE = 'V_BAS_PERF_INDICATOR';
insert into Busfw_t_Dcworkflowplan (GUID, CODE, TABLECODE, NAME, STATUS, YEAR, PROVINCE, VERSION, DBVERSION, REMARK, CREATER, CREATETIME, TYPE)
values ('2F62B0E1A972408B8330D3653F836522', 'V_BAS_PERF_INDICATOR', 'V_BAS_PERF_INDICATOR', '部门绩效指标库', '1', '2016', '87', null, null, null, null, '20200827225021776', 'B876713347C31372A297A0234F30FFB8');