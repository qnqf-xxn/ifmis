i number;
begin

-- 删除原来的视图
select count(1) into i from user_views t where t.VIEW_NAME='PERF_V_RANDOMPROBLEM';
 if i>0 then
    execute immediate 'DROP VIEW PERF_V_RANDOMPROBLEM';
 end if;
select count(1) into i from user_views t where t.VIEW_NAME='PERF_T_RANDOMPROBLEM';
 if i>0 then
    execute immediate 'DROP VIEW PERF_T_RANDOMPROBLEM';
 end if;
 
select count(1) into i from user_views t where t.VIEW_NAME='PERF_T_RANDOMCOMMENT_PROJ';
 if i>0 then
    execute immediate 'DROP VIEW PERF_T_RANDOMCOMMENT_PROJ';
 end if;
select count(1) into i from user_views t where t.VIEW_NAME='PERF_V_RANDOMRECTIFY_PROJ';
 if i>0 then
    execute immediate 'DROP VIEW PERF_V_RANDOMRECTIFY_PROJ';
 end if;
select count(1) into i from user_views t where t.VIEW_NAME='PERF_T_RANDOMCOMMENT';
 if i>0 then
    execute immediate 'DROP VIEW PERF_T_RANDOMCOMMENT';
 end if;
select count(1) into i from user_views t where t.VIEW_NAME='PERF_T_RANDOMINDEX';
 if i>0 then
    execute immediate 'DROP VIEW PERF_T_RANDOMINDEX';
 end if;
select count(1) into i from user_views t where t.VIEW_NAME='PERF_V_RANDOMQUALITY_TYPE';
 if i>0 then
    execute immediate 'DROP VIEW PERF_V_RANDOMQUALITY_TYPE';
 end if; 
 select count(1) into i from user_views t where t.VIEW_NAME='PERF_V_DEPTEVALSECORETMP';
 if i>0 then
	execute immediate 'DROP VIEW PERF_V_DEPTEVALSECORETMP';
 end if; 
 select count(1) into i from user_views t where t.VIEW_NAME='PERF_V_DEPTEVALSECORESUB';
 if i>0 then
	execute immediate 'DROP VIEW PERF_V_DEPTEVALSECORESUB';
 end if; 
 select count(1) into i from user_views t where t.VIEW_NAME='PERF_V_DEPTEVALSECORE';
 if i>0 then
	execute immediate 'DROP VIEW PERF_V_DEPTEVALSECORE';
 end if; 
 select count(1) into i from user_views t where t.VIEW_NAME='PERF_V_RANDOMQUALITY';
 if i>0 then
	execute immediate 'DROP VIEW PERF_V_RANDOMQUALITY';
 end if; 
 select count(1) into i from user_views t where t.VIEW_NAME='PERF_T_RANDOMQUALITY';
 if i>0 then
	execute immediate 'DROP VIEW PERF_T_RANDOMQUALITY';
 end if; 
 select count(1) into i from user_views t where t.VIEW_NAME='PERF_T_RANDOMQUALITY_TYPE';
 if i>0 then
	execute immediate 'DROP VIEW PERF_T_RANDOMQUALITY_TYPE';
 end if; 
 select count(1) into i from user_views t where t.VIEW_NAME='PERF_T_RANDOMQUALITY_MENU';
 if i>0 then
	execute immediate 'DROP VIEW PERF_T_RANDOMQUALITY_MENU';
 end if; 
 select count(1) into i from user_views t where t.VIEW_NAME='PERF_T_RANDOMQUALITY_SCORE';
 if i>0 then
	execute immediate 'DROP VIEW PERF_T_RANDOMQUALITY_SCORE';
 end if; 


-- 删除原来的表
select count(*) into i from user_tables  t where t.TABLE_NAME='P#PERF_T_RANDOMCOMMENT';
if i>0 then
   execute immediate'drop table P#PERF_T_RANDOMCOMMENT';
end if;
select count(*) into i from user_tables  t where t.TABLE_NAME='P#PERF_T_RANDOMINDEX';
if i>0 then
   execute immediate'drop table P#PERF_T_RANDOMINDEX';
end if;
select count(*) into i from user_tables  t where t.TABLE_NAME='P#PERF_T_RANDOMPROBLEM';
if i>0 then
   execute immediate'drop table P#PERF_T_RANDOMPROBLEM';
end if;
select count(*) into i from user_tables  t where t.TABLE_NAME='P#PERF_T_RANDOMQUALITY';
if i>0 then
   execute immediate'drop table P#PERF_T_RANDOMQUALITY';
end if;
select count(*) into i from user_tables  t where t.TABLE_NAME='P#PERF_T_RANDOMQUALITY_MENU';
if i>0 then
   execute immediate'drop table P#PERF_T_RANDOMQUALITY_MENU';
end if;
select count(*) into i from user_tables  t where t.TABLE_NAME='P#PERF_T_RANDOMQUALITY_SCORE';
if i>0 then
   execute immediate'drop table P#PERF_T_RANDOMQUALITY_SCORE';
end if;
select count(*) into i from user_tables  t where t.TABLE_NAME='P#PERF_T_RANDOMQUALITY_TYPE';
if i>0 then
   execute immediate'drop table P#PERF_T_RANDOMQUALITY_TYPE';
end if;

select count(*) into i from user_tables where TABLE_NAME = 'PERF_T_RANDOMCOMMENT';
if i=0 then
    execute immediate '
	CREATE TABLE PERF_T_RANDOMCOMMENT
	(
		guid VARCHAR2(32) NOT NULL,
		perfgoalguid VARCHAR2(32) ,
		province VARCHAR2(32) ,
		year VARCHAR2(32) ,
		isscope VARCHAR2(32) ,
		isobject VARCHAR2(32) ,
		israndom VARCHAR2(32) ,
		wfstatus VARCHAR2(40) ,
		wfid VARCHAR2(40) ,
		createtime VARCHAR2(17) ,
		creater VARCHAR2(40) ,
		auditor VARCHAR2(32) ,
		lastupdatetime VARCHAR2(17) default to_char(sysdate,''yyyyMMddHH24miss''),
		meachguid VARCHAR2(32) ,
		issubmit VARCHAR2(40)
	)
    ';
    execute immediate 'alter table PERF_T_RANDOMCOMMENT add constraint PK_PERF_T_RANDOMCOMMENT primary key (GUID,YEAR,PROVINCE)';
end if;

select count(*) into i from user_tables where TABLE_NAME = 'PERF_T_RANDOMINDEX';
if i=0 then
    execute immediate '
	CREATE TABLE PERF_T_RANDOMINDEX
	(
		guid VARCHAR2(40) NOT NULL,
		name VARCHAR2(200) ,
		indexguid VARCHAR2(40) ,
		taskguid VARCHAR2(40) ,
		indextype VARCHAR2(40) ,
		findex VARCHAR2(40) ,
		sindex VARCHAR2(40) ,
		groupkey VARCHAR2(40) ,
		isleaf VARCHAR2(40) ,
		superid VARCHAR2(40) ,
		levelno VARCHAR2(40) ,
		seq NUMBER(3,0),
		mainguid VARCHAR2(40) ,
		projguid VARCHAR2(40) ,
		agencyguid VARCHAR2(40) ,
		wfstatus VARCHAR2(40) ,
		status NUMBER(1,0),
		createtime VARCHAR2(17) NOT NULL,
		updatetime VARCHAR2(17) ,
		creater VARCHAR2(40) NOT NULL,
		province VARCHAR2(32) NOT NULL,
		year NUMBER(4,0) NOT NULL,
		ordernum NUMBER(9,0),
		finintorgguid VARCHAR2(40) ,
		wfid VARCHAR2(40) ,
		indexremark VARCHAR2(2000) ,
		indexval VARCHAR2(1000) ,
		computesign VARCHAR2(40) ,
		meterunit VARCHAR2(200) ,
		actualvalue VARCHAR2(1000) ,
		weight NUMBER(5,2),
		score VARCHAR2(40) ,
		operation VARCHAR2(40) ,
		tindex VARCHAR2(40)
	)';
    execute immediate 'alter table PERF_T_RANDOMINDEX add constraint PK_PERF_T_RANDOMINDEX primary key (GUID,YEAR,PROVINCE)';
end if;

select count(*) into i from user_tables where TABLE_NAME = 'PERF_T_RANDOMPROBLEM';
if i=0 then
    execute immediate '
	CREATE TABLE PERF_T_RANDOMPROBLEM
	(
		guid VARCHAR2(40) NOT NULL,
		proguid VARCHAR2(40) ,
		mainguid VARCHAR2(40) ,
		vcol1 VARCHAR2(4000) ,
		vcol2 VARCHAR2(4000) ,
		vcol3 VARCHAR2(4000) ,
		vcol4 VARCHAR2(40) ,
		vcol5 VARCHAR2(40) ,
		vcol6 VARCHAR2(40) ,
		createtime VARCHAR2(20) ,
		updatetime VARCHAR2(20) ,
		year VARCHAR2(10) ,
		province VARCHAR2(20)
	)
    ';
    execute immediate 'alter table PERF_T_RANDOMPROBLEM add constraint PK_PERF_T_RANDOMPROBLEM primary key (GUID,YEAR,PROVINCE)';
end if;

select count(*) into i from user_tables where TABLE_NAME = 'PERF_T_RANDOMQUALITY';
if i=0 then
    execute immediate '
	CREATE TABLE PERF_T_RANDOMQUALITY
	(
		guid VARCHAR2(40) NOT NULL,
		mainguid VARCHAR2(40) ,
		superid VARCHAR2(40) ,
		qualityname VARCHAR2(2000) ,
		qualitynameexp VARCHAR2(2000) ,
		qualityweight NUMBER(5,2),
		qualitystand VARCHAR2(4000) ,
		levelno VARCHAR2(2) ,
		isleaf VARCHAR2(2) ,
		createuid VARCHAR2(40) ,
		createuname VARCHAR2(100) ,
		createtime VARCHAR2(20) ,
		updateuid VARCHAR2(40) ,
		updateuname VARCHAR2(100) ,
		updatetime VARCHAR2(20) ,
		delstatus VARCHAR2(2) ,
		deluid VARCHAR2(40) ,
		deluname VARCHAR2(100) ,
		deltime VARCHAR2(20) ,
		bustype VARCHAR2(40) ,
		year VARCHAR2(10) ,
		province VARCHAR2(20) ,
		ordernum NUMBER(9,0),
		vcol1 VARCHAR2(40) ,
		vcol2 VARCHAR2(40) ,
		vcol3 VARCHAR2(40) ,
		vcol4 VARCHAR2(40) ,
		vcol5 VARCHAR2(40) ,
		finintorgguid VARCHAR2(40) ,
		iscom NUMBER(1,0)
	)
    ';
    execute immediate 'alter table PERF_T_RANDOMQUALITY add constraint PK_PERF_T_RANDOMQUALITY primary key (GUID,YEAR,PROVINCE)';
end if;

select count(*) into i from user_tables where TABLE_NAME = 'PERF_T_RANDOMQUALITY_MENU';
if i=0 then
    execute immediate '
	CREATE TABLE PERF_T_RANDOMQUALITY_MENU
	(
		guid VARCHAR2(40) NOT NULL,
		code VARCHAR2(40) ,
		menuid VARCHAR2(40) ,
		bustype VARCHAR2(40) ,
		province VARCHAR2(32) ,
		year NUMBER(4,0)
	)
    ';
    execute immediate 'alter table PERF_T_RANDOMQUALITY_MENU add constraint PK_PERF_T_RANDOMQUALITY_MENU primary key (GUID,YEAR,PROVINCE)';
end if;

select count(*) into i from user_tables where TABLE_NAME = 'PERF_T_RANDOMQUALITY_SCORE';
if i=0 then
    execute immediate '
	CREATE TABLE PERF_T_RANDOMQUALITY_SCORE
	(
		guid VARCHAR2(40) ,
		mainguid VARCHAR2(40) ,
		projguid VARCHAR2(40) ,
		scroe VARCHAR2(32) ,
		buckle VARCHAR2(1000) ,
		bustype VARCHAR2(40) ,
		wfstatus VARCHAR2(40) ,
		wfid VARCHAR2(40) ,
		status NUMBER(9,0),
		createtime VARCHAR2(40) ,
		updatetime VARCHAR2(40) ,
		creater VARCHAR2(40) ,
		province VARCHAR2(32) ,
		year NUMBER(4,0),
		vcol1 VARCHAR2(40) ,
		vcol2 VARCHAR2(40) ,
		vcol3 VARCHAR2(40) ,
		vcol4 VARCHAR2(40) ,
		vcol5 VARCHAR2(40)
	)
    ';
    execute immediate 'alter table PERF_T_RANDOMQUALITY_SCORE add constraint PK_PERF_T_RANDOMQUALITY_SCORE primary key (GUID,YEAR,PROVINCE)';
end if;

select count(*) into i from user_tables where TABLE_NAME = 'PERF_T_RANDOMQUALITY_TYPE';
if i=0 then
    execute immediate '
	CREATE TABLE PERF_T_RANDOMQUALITY_TYPE
	(
		guid VARCHAR2(40) NOT NULL,
		name VARCHAR2(2000) ,
		code VARCHAR2(40) ,
		bustype VARCHAR2(40) ,
		wfstatus VARCHAR2(40) ,
		wfid VARCHAR2(40) ,
		status NUMBER(9,0),
		delstatus NUMBER(9,0),
		createtime VARCHAR2(40) ,
		updatetime VARCHAR2(40) ,
		creater VARCHAR2(40) ,
		province VARCHAR2(32) ,
		year NUMBER(4,0),
		vcol1 VARCHAR2(40) ,
		vcol2 VARCHAR2(40) ,
		vcol3 VARCHAR2(40) ,
		vcol4 VARCHAR2(40) ,
		vcol5 VARCHAR2(40) ,
		agencyguid VARCHAR2(40)
	)
    ';
    execute immediate 'alter table PERF_T_RANDOMQUALITY_TYPE add constraint PK_PERF_T_RANDOMQUALITY_TYPE primary key (GUID,YEAR,PROVINCE)';
end if;

execute immediate 'CREATE OR REPLACE VIEW v_perf_t_randomcomment AS
SELECT
	*
FROM
	perf_t_randomcomment
WHERE
	year = global_multyear_cz.Secu_f_GLOBAL_PARM ( ''YEAR'' )
	AND province = global_multyear_cz.Secu_f_GLOBAL_PARM (''DIVID'')';
	
execute immediate 'CREATE OR REPLACE VIEW v_perf_t_randomindex AS
SELECT
	*
FROM
	perf_t_randomindex
WHERE
	year = global_multyear_cz.Secu_f_GLOBAL_PARM ( ''YEAR'' )
	AND province = global_multyear_cz.Secu_f_GLOBAL_PARM (''DIVID'')';
	
execute immediate 'CREATE OR REPLACE VIEW v_perf_t_randomproblem AS
SELECT
	*
FROM
	perf_t_randomproblem
WHERE
	year = global_multyear_cz.Secu_f_GLOBAL_PARM ( ''YEAR'' )
	AND province = global_multyear_cz.Secu_f_GLOBAL_PARM (''DIVID'')';	
	
execute immediate 'CREATE OR REPLACE VIEW v_perf_t_randomquality AS
SELECT
	*
FROM
	perf_t_randomquality
WHERE
	year = global_multyear_cz.Secu_f_GLOBAL_PARM ( ''YEAR'' )
	AND province = global_multyear_cz.Secu_f_GLOBAL_PARM (''DIVID'')';
	
execute immediate 'CREATE OR REPLACE VIEW v_perf_t_randomquality_menu AS
SELECT
	*
FROM
	perf_t_randomquality_menu
WHERE
	year = global_multyear_cz.Secu_f_GLOBAL_PARM ( ''YEAR'' )
	AND province = global_multyear_cz.Secu_f_GLOBAL_PARM (''DIVID'')';
	
execute immediate 'CREATE OR REPLACE VIEW v_perf_t_randomquality_score AS
SELECT
	*
FROM
	perf_t_randomquality_score
WHERE
	year = global_multyear_cz.Secu_f_GLOBAL_PARM ( ''YEAR'' )
	AND province = global_multyear_cz.Secu_f_GLOBAL_PARM (''DIVID'')';	
	
execute immediate 'CREATE OR REPLACE VIEW v_perf_t_randomquality_type AS
SELECT
	*
FROM
	perf_t_randomquality_type
WHERE
	year = global_multyear_cz.Secu_f_GLOBAL_PARM ( ''YEAR'' )
	AND province = global_multyear_cz.Secu_f_GLOBAL_PARM (''DIVID'')';
	 
execute immediate 'CREATE OR REPLACE VIEW v_perf_randomquality
 AS
 SELECT t.guid,
    t.superid,
    t.qualityname,
    t.qualitynameexp,
    t.qualityweight,
    t.qualitystand,
    t.levelno,
    t.isleaf,
    t.ordernum,
    t1.projguid,
    t1.scroe,
    t1.buckle,
    t.year,
    t.province,
    t2.name,
    t2.code,
    t2.bustype
   FROM ((v_perf_t_randomquality t
     LEFT JOIN v_perf_t_randomquality_score t1 ON (((t.guid) = (t1.mainguid))))
     LEFT JOIN v_perf_t_randomquality_type t2 ON (((t.mainguid) = (t2.guid))))
  ORDER BY t.ordernum';
  
execute immediate 'CREATE OR REPLACE VIEW v_perf_randomquality_type
 AS
 SELECT a.*,
    b.name,
    b.code,
    b.status
   FROM (v_perf_t_randomquality a
     LEFT JOIN v_perf_t_randomquality_type b ON (((a.mainguid) = (b.guid))))';
execute immediate 'CREATE OR REPLACE VIEW v_perf_randomrectify_proj
 AS
 SELECT a.guid,
        CASE
            WHEN ((t1.pro_lev) = ''1'') THEN ''2''
            WHEN ((t1.pro_lev) = ''2'') THEN ''1''
            ELSE ''3''
        END AS projtype,
    t1.pro_code AS projcode,
    t1.pro_code,
    t1.pro_name AS projname,
    t1.pro_name,
    t1.mof_dep_code,
    t1.agencyguid,
    t1.exp_func_code,
    t1.dept_code,
    t1.ispublish,
    t1.fromguid,
    t1.pro_grade,
    t1.adjstatus,
    t1.lastupdatetime,
    t1.finintorgguid,
    t1.agency_code AS ysdw,
    t1.agency_code AS dwid,
    t1.finintorgguid AS csid,
    t1.mof_div_code,
    t1.wfid,
    a.perfgoalguid,
    d.isfinal,
    t1.ishistory,
    d.type,
        CASE
            WHEN ((t1.pro_lev) = ''1'') THEN ''2''
            WHEN ((t1.pro_lev) = ''2'') THEN ''1''
            ELSE ''3''
        END AS bustype
   FROM (((v_perf_t_randomcomment a
     LEFT JOIN ( SELECT * FROM v_perf_t_rectify
          WHERE (((delstatus) = ''0'') AND (isfinal = ''2''))) d ON (((a.guid) = (d.proguid))))
     LEFT JOIN pm_perf_goal_info b ON (((a.perfgoalguid) = (b.guid))))
     LEFT JOIN v_perf_project_info t1 ON (((b.pro_code) = (t1.pro_code))))
  WHERE ((a.issubmit) = ''1'')';

	
execute immediate '
CREATE OR REPLACE VIEW v_perf_t_randomcomment_proj
 AS
 SELECT t3.guid,
    t1.guid AS perfgoalguid,
    m.projguid,
    m.guid AS selfguid,
    m.year,
    t1.pro_name AS projname,
    t1.pro_name AS name,
    t1.pro_code,
    t1.province,
    t1.finintorgguid,
    t1.agency_code,
    t1.agency_code AS agencyguid,
    m.bustype,
        CASE
            WHEN ((m.pro_lev) = ''1'') THEN ''一级项目''
            WHEN ((m.pro_lev) = ''2'') THEN ''二级项目''
            ELSE ''''
        END AS prolev,
        CASE
            WHEN ((t3.issubmit) = ''1'') THEN ''1''
            ELSE ''0''
        END AS issubmit,
    t3.wfid,
        CASE
            WHEN ((t3.isscope) = ''1'') THEN 1
            ELSE 0
        END AS isscope,
    t3.wfstatus,
    t3.createtime,
    t3.creater,
    t3.auditor,
    t3.lastupdatetime,
    t3.meachguid,
    t3.meachguid AS meachname,
    t3.isobject,
    t3.israndom,
    m.score AS selfscore,
    m.selfresult,
    s.score,
    ((0.4 * nvl(s.score, (0))) + (0.6 * nvl(r.score, (0)))) AS actualscore,
        CASE
            WHEN (((0.4 * nvl(s.score, (0))) + (0.6 * nvl(r.score, (0)))) >= (90)) THEN ''优''
            WHEN ((((0.4 * nvl(s.score, (0))) + (0.6 * nvl(r.score, (0)))) >= (80)) AND (((0.4 * nvl(s.score, (0))) + (0.6 * nvl(r.score, (0)))) < (90))) THEN ''良''
            WHEN ((((0.4 * nvl(s.score, (0))) + (0.6 * nvl(r.score, (0)))) >= (60)) AND (((0.4 * nvl(s.score, (0))) + (0.6 * nvl(r.score, (0)))) < (80))) THEN ''中''
            WHEN (((0.4 * nvl(s.score, (0))) + (0.6 * nvl(r.score, (0)))) < (60)) THEN ''差''
            ELSE NULL
        END AS randomresult,
    t2.amt1 AS budgetamount,
    t2.amt3 AS execratenum,
    (t2.amt4 + nvl(t2.amt6, (0))) AS execamount,
    nvl(t2.amt6, (0)) AS amt6,
    t2.bgtget AS execrate
   FROM (((((perf_v_selfevaltask m
     LEFT JOIN v_perf_project_info t1 ON (((m.projguid) = (t1.pro_id))))
     LEFT JOIN ( SELECT mainguid,
            sum(amt1) AS amt1,
            sum(amt3) AS amt3,
            sum(amt4) AS amt4,
            nvl(sum(amt6), (0)) AS amt6,
            to_char((((sum(amt4) + nvl(sum(amt6), (0))) /
                DECODE(  (sum(amt2) + sum(amt1))
                    , (0)
                    , (1)
                    , (sum(amt2) + sum(amt1))
                )) * (100)), ''FM990.00'') AS bgtget
           FROM v_perf_t_selfprofund
          GROUP BY mainguid) t2 ON (((t2.mainguid) = (m.guid))))
     LEFT JOIN v_perf_t_randomcomment t3 ON (((m.projguid) = (t3.perfgoalguid))))
     LEFT JOIN ( SELECT c.projguid,
            sum((c.scroe)) AS score
           FROM v_perf_randomquality c
          WHERE ((c.levelno) = ''2'')
          GROUP BY c.projguid) s ON (((s.projguid) = (t1.pro_id))))
     LEFT JOIN ( SELECT c.mainguid,
            sum((c.score)) AS score
           FROM v_perf_t_randomindex c
          WHERE ((c.levelno) = ''3'')
          GROUP BY c.mainguid) r ON (((r.mainguid) = (m.guid))))
  WHERE ((m.wfstatus) = ''011'')';
  
execute immediate 'CREATE OR REPLACE VIEW v_perf_randomproblem
 AS
 SELECT t.*,
    p.agency_code,
    p.actualscore,
    p.randomresult,
    p.selfguid
   FROM (v_perf_t_randomproblem t
     LEFT JOIN v_perf_t_randomcomment_proj p ON (((t.mainguid) = (p.selfguid))))';