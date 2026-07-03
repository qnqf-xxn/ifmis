-- Table: bgt_330000.perf_bgt_linkbgtinfoadjust

-- DROP TABLE bgt_330000.perf_bgt_linkbgtinfoadjust;

CREATE TABLE IF NOT EXISTS bgt_330000.perf_bgt_linkbgtinfoadjust
(
    guid character varying(40) COLLATE pg_catalog."default" NOT NULL,
    findex character varying(300) COLLATE pg_catalog."default",
    sindex character varying(300) COLLATE pg_catalog."default",
    name character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    kpi_val1 character varying(1000) COLLATE pg_catalog."default",
    kpi_val2 character varying(1000) COLLATE pg_catalog."default",
    kpi_val3 character varying(1000) COLLATE pg_catalog."default",
    computesign character varying(40) COLLATE pg_catalog."default",
    kpi_val character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    meterunit character varying(200) COLLATE pg_catalog."default",
    bgtamt1 numeric(18,2),
    bgtamt2 numeric(18,2),
    bgtamt3 numeric(18,2),
    score numeric(5,2),
    baseperiod character varying(200) COLLATE pg_catalog."default",
    couplerate numeric(5,2),
    coupleamt numeric(18,2),
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
    remark character varying(1000) COLLATE pg_catalog."default",
    indexguid character varying(40) COLLATE pg_catalog."default",
    kpi_val2023 character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT pk_perfbgtlinkbgtinfoadjust PRIMARY KEY (guid, province, year,mainguid)
);

-- Index: pg_oid_2023033003_index

-- DROP INDEX bgt_330000.pg_oid_2023033003_index;

CREATE UNIQUE INDEX pg_oid_2023033003_index
    ON bgt_330000.perf_bgt_linkbgtinfo USING btree
    (oid ASC NULLS LAST)
    TABLESPACE pg_default;
	
	
-- View: bgt_330000.v_perf_bgt_linkbgtinfoadjust

-- DROP VIEW bgt_330000.v_perf_bgt_linkbgtinfoadjust;

CREATE OR REPLACE VIEW bgt_330000.v_perf_bgt_linkbgtinfoadjust
 AS
 SELECT t.*
   FROM perf_bgt_linkbgtinfoadjust t
  WHERE ((t.year = (bgt_330000.global_multyear_cz.v_pmyear)::numeric) AND ((t.province)::text = (bgt_330000.global_multyear_cz.v_pmdivid)::text) AND (t.is_deleted <> (1)::numeric));

