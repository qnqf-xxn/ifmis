i number;
begin
  delete FROM Fasp_t_Dicdssource t where t.elementcode in ('INDEXCOMFUNC_ZJ','INDEXCOMFUNC_HuBei');
  
  insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
  values ('INDEXCOMFUNC_ZJ', 'INDEXCOMFUNC_ZJ', 'INDEXCOMFUNC_ZJ', '浙江个性指标分类', '1', '20140422000000000', '20150423', null, '2020', '87', null, '8717', '1', '2', 'select * from v_perf_indexcomfunc order by code', null, 1, 'pmkpi');

  insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
  values ('INDEXCOMFUNC_HuBei', 'INDEXCOMFUNC_HuBei', 'INDEXCOMFUNC_HuBei', '湖北个性指标分类', '1', '20140422000000000', '20150423', null, '2020', '87', null, '8717', '1', '2', 'select * from v_perf_indexcomfunchubei order by code', null, 1, 'pmkpi');

  execute immediate 'create or replace view v_perf_indexcomfunc as
select t.guid,
       t.AGENCYGUID  as code,
       t.name,
       t.SUPERID superguid,
       t.SUPERID,
       t.levelno-1 as levelno,
       t.AGENCYGUID,
       t.isleaf,
       t.PROVINCE,
       t.status,
       ''indexdept'' as mogamisuperid
  from V_PERF_T_INDEXCOMFUNC t';
  execute immediate 'create or replace view v_perf_indexcomfunchubei as
select t.guid,
       t.AGENCYGUID  as code,
       t.name,
       t.SUPERID superguid,
       t.SUPERID,
       t.levelno+1 as levelno,
       t.AGENCYGUID,
       t.isleaf,
       t.PROVINCE,
       t.status,
      ''indexdept'' as mogamisuperid
  from V_PERF_T_INDEXCOMFUNC t';

execute immediate 'CREATE OR REPLACE VIEW V_PERF_T_INDEXHUBEI AS
SELECT
       ''idexcomcls'' guid,
       ''01'' code,
       ''共性'' name,
       ''#'' superguid,
       ''#'' superid,
       1 levelno,
       0 isleaf,
       1 status,
       ''1'' is_common_ind
FROM dual
 union all
 select guid,
       code,
       name,
       ''idexcomcls'' superguid,
       ''idexcomcls'' superid,
       2 levelno,
       1 isleaf,
       1 status,
       ''1'' is_common_ind
 from v_perf_enum where elementcode = ''IDEXCOMCLS''';
execute immediate 'CREATE OR REPLACE VIEW V_PERF_T_INDEXZJ AS
SELECT
       ''idexcomcls'' guid,
       ''01'' code,
       ''共性'' name,
       ''#'' superguid,
       ''#'' superid,
       1 levelno,
       0 isleaf,
       1 status,
       ''1'' is_common_ind
FROM dual
 union all
 select guid,
       code,
       name,
       ''idexcomcls'' superguid,
       ''idexcomcls'' superid,
       2 levelno,
       1 isleaf,
       1 status,
       ''1'' is_common_ind
 from v_perf_enum where elementcode = ''IDEXCOMCLS''';