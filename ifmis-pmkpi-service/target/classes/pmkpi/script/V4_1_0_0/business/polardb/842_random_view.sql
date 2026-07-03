
v_sql varchar2(5000);
ln_i integer;
begin
	v_sql :='CREATE OR REPLACE VIEW V_PERF_RANDOMRECTIFY_PROJ
 AS
 SELECT A.GUID,
        CASE
            WHEN ((T1.LEVEL_NO) = ''1'') THEN ''2''
            WHEN ((T1.LEVEL_NO) = ''2'') THEN ''1''
            ELSE ''3''
        END AS PROJTYPE,
    T1.PRO_CODE AS PROJCODE,
    T1.PRO_CODE,
    T1.PRO_NAME AS PROJNAME,
    T1.PRO_NAME,
    T1.MOF_DEP_CODE,
    T1.AGENCYGUID,
    --T1.EXP_FUNC_CODE,
    T1.DEPT_CODE,
    --T1.ISPUBLISH,
    T1.FROMGUID,
    --T1.PRO_GRADE,
    T1.ADJSTATUS,
    T1.LASTUPDATETIME,
    T1.FININTORGGUID,
    T1.AGENCY_CODE AS YSDW,
    T1.AGENCY_CODE AS DWID,
    T1.FININTORGGUID AS CSID,
    T1.MOF_DIV_CODE,
    T1.WFID,
    A.PERFGOALGUID,
    D.ISFINAL,
    T1.ISHISTORY,
    D.TYPE,
        CASE
            WHEN ((T1.LEVEL_NO) = ''1'') THEN ''2''
            WHEN ((T1.LEVEL_NO) = ''2'') THEN ''1''
            ELSE ''3''
        END AS BUSTYPE
   FROM (((V_PERF_T_RANDOMCOMMENT A
     LEFT JOIN ( SELECT * FROM V_PERF_T_RECTIFY
          WHERE (((DELSTATUS) = ''0'') AND (ISFINAL = ''2''))) D ON (((A.GUID) = (D.PROGUID))))
     LEFT JOIN PM_PERF_GOAL_INFO B ON (((A.PERFGOALGUID) = (B.GUID))))
     LEFT JOIN V_PERF_PROJECT_INFO T1 ON (((B.PRO_CODE) = (T1.PRO_CODE))))
  WHERE ((A.ISSUBMIT) = ''1'')';
	select fn_alterview('V_PERF_RANDOMRECTIFY_PROJ',v_sql) into ln_i;
	if ln_i = 0 then
	    return;
	end if;
	
	v_sql :='CREATE OR REPLACE VIEW V_PERF_T_RANDOMCOMMENT_PROJ
 AS
 SELECT T3.GUID,
    T1.GUID AS PERFGOALGUID,
    M.PROJGUID,
    M.GUID AS SELFGUID,
    M.YEAR,
    T1.PRO_NAME AS PROJNAME,
    T1.PRO_NAME AS NAME,
    T1.PRO_CODE,
    T1.PROVINCE,
    T1.FININTORGGUID,
    T1.AGENCY_CODE,
    T1.AGENCY_CODE AS AGENCYGUID,
    M.BUSTYPE,
        CASE
            WHEN ((M.PRO_LEV) = ''1'') THEN ''一级项目''
            WHEN ((M.PRO_LEV) = ''2'') THEN ''二级项目''
            ELSE ''''
        END AS PROLEV,
        CASE
            WHEN ((T3.ISSUBMIT) = ''1'') THEN ''1''
            ELSE ''0''
        END AS ISSUBMIT,
    T3.WFID,
        CASE
            WHEN ((T3.ISSCOPE) = ''1'') THEN 1
            ELSE 0
        END AS ISSCOPE,
    T3.WFSTATUS,
    T3.CREATETIME,
    T3.CREATER,
    T3.AUDITOR,
    T3.LASTUPDATETIME,
    T3.MEACHGUID,
    T3.MEACHGUID AS MEACHNAME,
    T3.ISOBJECT,
    T3.ISRANDOM,
    M.SCORE AS SELFSCORE,
    M.SELFRESULT,
    S.SCORE,
    ((0.4 * NVL(S.SCORE, (0))) + (0.6 * NVL(R.SCORE, (0)))) AS ACTUALSCORE,
        CASE
            WHEN (((0.4 * NVL(S.SCORE, (0))) + (0.6 * NVL(R.SCORE, (0)))) >= (90)) THEN ''优''
            WHEN ((((0.4 * NVL(S.SCORE, (0))) + (0.6 * NVL(R.SCORE, (0)))) >= (80)) AND (((0.4 * NVL(S.SCORE, (0))) + (0.6 * NVL(R.SCORE, (0)))) < (90))) THEN ''良''
            WHEN ((((0.4 * NVL(S.SCORE, (0))) + (0.6 * NVL(R.SCORE, (0)))) >= (60)) AND (((0.4 * NVL(S.SCORE, (0))) + (0.6 * NVL(R.SCORE, (0)))) < (80))) THEN ''中''
            WHEN (((0.4 * NVL(S.SCORE, (0))) + (0.6 * NVL(R.SCORE, (0)))) < (60)) THEN ''差''
            ELSE NULL
        END AS RANDOMRESULT,
    T2.AMT1 AS BUDGETAMOUNT,
    T2.AMT3 AS EXECRATENUM,
    (T2.AMT4 + NVL(T2.AMT6, (0))) AS EXECAMOUNT,
    NVL(T2.AMT6, (0)) AS AMT6,
    T2.BGTGET AS EXECRATE
   FROM (((((PERF_V_SELFEVALTASK M
     LEFT JOIN V_PERF_PROJECT_INFO T1 ON (((M.PROJGUID) = (T1.PRO_ID))))
     LEFT JOIN ( SELECT MAINGUID,
            SUM(AMT1) AS AMT1,
            SUM(AMT3) AS AMT3,
            SUM(AMT4) AS AMT4,
            NVL(SUM(AMT6), (0)) AS AMT6,
            TO_CHAR((((SUM(AMT4) + NVL(SUM(AMT6), (0))) /
                DECODE(  (SUM(AMT2) + SUM(AMT1))
                    , (0)
                    , (1)
                    , (SUM(AMT2) + SUM(AMT1))
                )) * (100)), ''FM990.00'') AS BGTGET
           FROM V_PERF_T_SELFPROFUND
          GROUP BY MAINGUID) T2 ON (((T2.MAINGUID) = (M.GUID))))
     LEFT JOIN V_PERF_T_RANDOMCOMMENT T3 ON (((M.PROJGUID) = (T3.PERFGOALGUID))))
     LEFT JOIN ( SELECT C.PROJGUID,
            SUM((C.SCROE)) AS SCORE
           FROM V_PERF_RANDOMQUALITY C
          WHERE ((C.LEVELNO) = ''2'')
          GROUP BY C.PROJGUID) S ON (((S.PROJGUID) = (T1.PRO_ID))))
     LEFT JOIN ( SELECT C.MAINGUID,
            SUM((C.SCORE)) AS SCORE
           FROM V_PERF_T_RANDOMINDEX C
          WHERE ((C.LEVELNO) = ''3'')
          GROUP BY C.MAINGUID) R ON (((R.MAINGUID) = (M.GUID))))
  WHERE ((M.WFSTATUS) = ''011'')';
	select fn_alterview('V_PERF_T_RANDOMCOMMENT_PROJ',v_sql) into ln_i;
	if ln_i = 0 then
	    return;
	end if;

	v_sql :='CREATE OR REPLACE VIEW V_PERF_RANDOMPROBLEM
 AS
 SELECT T.*,
    P.AGENCY_CODE,
    P.ACTUALSCORE,
    P.RANDOMRESULT,
    P.SELFGUID
   FROM (V_PERF_T_RANDOMPROBLEM T
     LEFT JOIN V_PERF_T_RANDOMCOMMENT_PROJ P ON (((T.MAINGUID) = (P.SELFGUID))))';
	select fn_alterview('V_PERF_RANDOMPROBLEM',v_sql) into ln_i;
	if ln_i = 0 then
	    return;
	end if;