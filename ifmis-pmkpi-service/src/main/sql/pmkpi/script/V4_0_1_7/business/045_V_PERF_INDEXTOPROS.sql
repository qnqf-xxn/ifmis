begin
execute immediate '
CREATE OR REPLACE VIEW V_PERF_INDEXTOPROS AS
SELECT c.GUID,
       t.MAINGUID,
       t.AGENCYGUID,
       t.FUN_RES_CODE,
       t.FINDEX,
       t.SNAME,
       t.NAME,
       c.PRO_CODE,
       c.PRO_NAME,
       c.PRO_ID,
       c.PRO_TOTAL_AMT
  FROM v_bgt_perf_indicator t, V_perf_bgt_indexpro c
 where t.GUID = c.INDEXGUID
   and t.MAINGUID = c.MAINGUID
   and c.AGENCYGUID = c.AGENCYGUID
 order by t.FUN_RES_CODE, t.SNAME, t.NAME, c.PRO_CODE';