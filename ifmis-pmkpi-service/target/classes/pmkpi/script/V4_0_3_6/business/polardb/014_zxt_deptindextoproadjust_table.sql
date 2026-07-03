-- Table: bgt_330000.perf_bgt_indexproadjust

-- DROP TABLE bgt_330000.perf_bgt_indexproadjust;

CREATE TABLE IF NOT EXISTS bgt_330000.perf_bgt_indexproadjust
(
    guid character varying(40) COLLATE pg_catalog."default" NOT NULL,
    pro_id character varying(40) COLLATE pg_catalog."default",
    pro_code character varying(40) COLLATE pg_catalog."default",
    pro_name character varying(180) COLLATE pg_catalog."default",
    pro_total_amt numeric(18,2),
    agencyguid character varying(40) COLLATE pg_catalog."default",
    status numeric(1,0),
    is_deleted numeric(1,0) NOT NULL DEFAULT 2,
    createtime character varying(17) COLLATE pg_catalog."default" NOT NULL,
    updatetime character varying(17) COLLATE pg_catalog."default",
    creater character varying(40) COLLATE pg_catalog."default" NOT NULL,
    province character varying(32) COLLATE pg_catalog."default" NOT NULL,
    year numeric(4,0) NOT NULL,
    ordernum numeric(9,0),
    finintorgguid character varying(40) COLLATE pg_catalog."default",
    mainguid character varying(40) COLLATE pg_catalog."default",
    indexguid character varying(40) COLLATE pg_catalog."default",
    remark character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT pk_perf_bgtindexproadjust PRIMARY KEY (guid, province, year,mainguid)
);

-- Index: pg_oid_2023033002_index

-- DROP INDEX bgt_330000.pg_oid_2023033002_index;

CREATE UNIQUE INDEX pg_oid_2023033002_index
    ON bgt_330000.perf_bgt_indexproadjust USING btree
    (oid ASC NULLS LAST)
    TABLESPACE pg_default;
	
	
-- View: bgt_330000.v_perf_bgt_indexproadjust

-- DROP VIEW bgt_330000.v_perf_bgt_indexproadjust;

CREATE OR REPLACE VIEW bgt_330000.v_perf_bgt_indexproadjust
 AS
 SELECT *
   FROM perf_bgt_indexproadjust
  WHERE ((perf_bgt_indexproadjust.year = (bgt_330000.global_multyear_cz.v_pmyear)::numeric) AND ((perf_bgt_indexproadjust.province)::text = (bgt_330000.global_multyear_cz.v_pmdivid)::text) AND (perf_bgt_indexproadjust.is_deleted <> (1)::numeric));


-- View: bgt_330000.v_perf_indextoprosadjust

-- DROP VIEW bgt_330000.v_perf_indextoprosadjust;

CREATE OR REPLACE VIEW bgt_330000.v_perf_indextoprosadjust
 AS
 SELECT c.guid,
    t.mainguid,
    t.agencyguid,
    t.fun_res_code,
    t.findex,
    t.sname,
    t.name,
    c.pro_code,
    c.pro_name,
    c.pro_id,
    c.pro_total_amt
   FROM v_perf_t_deptindexadjust t,
    v_perf_bgt_indexproadjust c
  WHERE (((t.guid)::text = (c.indexguid)::text) AND ((t.mainguid)::text = (c.mainguid)::text) AND ((c.agencyguid)::text = (c.agencyguid)::text))
  ORDER BY t.fun_res_code, t.sname, t.name, c.pro_code;
  
  
CREATE OR REPLACE VIEW bgt_330000.v_perf_indextobgt
 AS
 SELECT t.*,t1.bgtamt1,t1.bgtamt2,t1.bgtamt3,
 t1.baseperiod,t1.coupleamt,t1.couplerate,t1.remark
 from V_BGT_PERF_INDICATOR t left join 
v_perf_bgt_linkbgtinfo t1 on t.agencyguid = t1.agencyguid and t.mainguid= t1.mainguid and t.guid = t1.indexguid

CREATE OR REPLACE VIEW bgt_330000.v_perf_indextobgtadjust
 AS
 SELECT t.*,t1.bgtamt1,t1.bgtamt2,t1.bgtamt3,
 t1.baseperiod,t1.coupleamt,t1.couplerate,t1.remark
 from V_PERF_T_DEPTINDEXADJUST t left join 
v_perf_bgt_linkbgtinfoadjust t1 on t.agencyguid = t1.agencyguid and t.mainguid= t1.mainguid and t.guid = t1.indexguid