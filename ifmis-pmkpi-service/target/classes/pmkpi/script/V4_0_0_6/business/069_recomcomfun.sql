begin
execute immediate '
CREATE OR REPLACE VIEW V_PERF_T_INDEX AS
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
 from v_perf_enum where elementcode = ''IDEXCOMCLS''
 union all
  SELECT
         ''indexcomfunc'' guid,
         ''02'' code,
         ''个性'' name,
         ''#'' superguid,
         ''#'' superid,
         1 levelno,
         0 isleaf,
         1 status,
         ''0'' is_common_ind
  FROM dual
 union all
 select t.guid,
       t.code,
       t.name,
       case
          when t.superguid <> ''#'' then
            t.superguid
          else
            ''indexcomfunc''
       end superguid,
       case
          when t.superguid <> ''#'' then
            t.superguid
          else
            ''indexcomfunc''
       end SUPERID,
       nvl(t.levelno,0)+1,
       case
         when t.isleaf = 0 and t.superguid <> ''#'' then
          1
         else
          t.isleaf
       end isleaf,
       t.status,
       ''0'' is_common_ind
  from V_ELE_VD10004 t
 where t.status = 1
   and t.levelno in (1, 2)';