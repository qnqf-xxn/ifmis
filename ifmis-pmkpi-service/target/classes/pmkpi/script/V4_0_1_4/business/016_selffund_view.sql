begin
  execute immediate 'CREATE OR REPLACE VIEW V_PERF_SELFBDGPAY_PROJECT AS
SELECT
 ''当年财政资金'' as AMTNAME,
 0  as AMT1,
0 as AMT2,
0 as AMT3,
0 as AMT4,
0 as AMT5,
'''' as SCORE,
'''' as proguid
FROM  dual

union all

 SELECT
''上年结转资金'' as AMTNAME,
0 as AMT1,
0 as AMT2,
0 as AMT3,
0 as AMT4,
0 as AMT5,
'''' as SCORE,
'''' as proguid
FROM  dual
union all
 SELECT
''其他资金'' as AMTNAME,
0 as AMT1,
0 as AMT2,
0 as AMT3,
0 as AMT4,
0 as AMT5,
'''' as SCORE,
'''' as proguid
FROM  dual';

execute immediate 'CREATE OR REPLACE VIEW V_PERF_SELFBDGPAY_DEPT AS
SELECT
 ''当年财政资金'' as AMTNAME,
 0 as AMT1,
0 as AMT2,
0 as AMT3,
0 as AMT4,
0 as AMT5,
'''' as SCORE,
'''' as agencyguid
FROM  dual

union all

 SELECT
''上年结转资金'' as AMTNAME,
0 as AMT1,
0 as AMT2,
0 as AMT3,
0 as AMT4,
0 as AMT5,
'''' as SCORE,
'''' as agencyguid
FROM  dual
union all
 SELECT
''其他资金'' as AMTNAME,
0 as AMT1,
0 as AMT2,
0 as AMT3,
0 as AMT4,
0 as AMT5,
'''' as SCORE,
'''' as agencyguid
FROM  dual';
