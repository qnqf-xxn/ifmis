-- Table: bgt_330000.perf_t_deptindexadjust

-- DROP TABLE bgt_330000.perf_t_deptindexadjust;

CREATE TABLE IF NOT EXISTS bgt_330000.perf_t_deptindexadjust
(
    guid character varying(40) COLLATE pg_catalog."default" NOT NULL,
    explain character varying(200) COLLATE pg_catalog."default",
    weight numeric(5,2),
    islinked numeric(1,0),
    agencyguid character varying(40) COLLATE pg_catalog."default",
    wfstatus character varying(40) COLLATE pg_catalog."default",
    status numeric(1,0),
    createtime character varying(17) COLLATE pg_catalog."default" NOT NULL,
    updatetime character varying(17) COLLATE pg_catalog."default",
    creater character varying(40) COLLATE pg_catalog."default" NOT NULL,
    province character varying(32) COLLATE pg_catalog."default" NOT NULL,
    year numeric(4,0) NOT NULL,
    ordernum numeric(9,0),
    finintorgguid character varying(40) COLLATE pg_catalog."default",
    wfid character varying(40) COLLATE pg_catalog."default",
    mainguid character varying(40) COLLATE pg_catalog."default",
    superid character varying(40) COLLATE pg_catalog."default",
    levelno numeric(2,0),
    rule character varying(200) COLLATE pg_catalog."default",
    computesign character varying(40) COLLATE pg_catalog."default",
    meterunit character varying(200) COLLATE pg_catalog."default",
    tindex character varying(300) COLLATE pg_catalog."default",
    targetvalue character varying(1000) COLLATE pg_catalog."default",
    kpi_id character varying(38) COLLATE pg_catalog."default" NOT NULL,
    mof_div_code character varying(9) COLLATE pg_catalog."default" NOT NULL,
    fiscal_year character varying(4) COLLATE pg_catalog."default" NOT NULL,
    dept_code character varying(21) COLLATE pg_catalog."default" NOT NULL,
    kpi_lv1 character varying(300) COLLATE pg_catalog."default" NOT NULL,
    kpi_lv2 character varying(300) COLLATE pg_catalog."default" NOT NULL,
    kpi_lv3 character varying(300) COLLATE pg_catalog."default" NOT NULL,
    kpi_content character varying(2000) COLLATE pg_catalog."default",
    kpi_evalstd character varying(2000) COLLATE pg_catalog."default" NOT NULL,
    kpi_val character varying(1000) COLLATE pg_catalog."default" NOT NULL,
    kpi_remark character varying(2000) COLLATE pg_catalog."default",
    update_time character varying(17) COLLATE pg_catalog."default" NOT NULL,
    is_deleted numeric(1,0) NOT NULL DEFAULT 2,
    create_time character varying(17) COLLATE pg_catalog."default" NOT NULL,
    name character varying(1000) COLLATE pg_catalog."default",
    code character varying(30) COLLATE pg_catalog."default",
    findex character varying(300) COLLATE pg_catalog."default",
    sindex character varying(300) COLLATE pg_catalog."default",
    indexval character varying(1000) COLLATE pg_catalog."default",
    adj_batch_no character varying(6) COLLATE pg_catalog."default",
    busi_type_code character varying(6) COLLATE pg_catalog."default" NOT NULL,
    fun_res_code character varying(40) COLLATE pg_catalog."default",
    indeximport character varying(40) COLLATE pg_catalog."default",
    score numeric(5,2),
    scorerule character varying(2000) COLLATE pg_catalog."default",
    kpi_val1 character varying(1000) COLLATE pg_catalog."default",
    kpi_val2 character varying(1000) COLLATE pg_catalog."default",
    kpi_val3 character varying(1000) COLLATE pg_catalog."default",
    proselect character varying(40) COLLATE pg_catalog."default",
    isbudget character varying(40) COLLATE pg_catalog."default",
    sname character varying(1000) COLLATE pg_catalog."default",
    opinion_remark character varying(4000) COLLATE pg_catalog."default",
    kpivalsource character varying(32) COLLATE pg_catalog."default",
    yearflag character varying(1) COLLATE pg_catalog."default",
    kpi_dep_id character varying(38) COLLATE pg_catalog."default",
    snindexval character varying(1000) COLLATE pg_catalog."default",
    qnindexval character varying(1000) COLLATE pg_catalog."default",
    computetype character varying(4000) COLLATE pg_catalog."default",
    indexstandards character varying(2000) COLLATE pg_catalog."default",
    endvaltype character varying(100) COLLATE pg_catalog."default",
    endvalsource character varying(100) COLLATE pg_catalog."default",
    valrule character varying(100) COLLATE pg_catalog."default",
    evidencefile character varying(100) COLLATE pg_catalog."default",
    kpi_val2023 character varying(1000) COLLATE pg_catalog."default",
    value_change character varying(40) COLLATE pg_catalog."default",
    indexcatlev character varying(40) COLLATE pg_catalog."default",
    lv1_perf_ind_name character varying(200) COLLATE pg_catalog."default",
    lv2_perf_ind_name character varying(200) COLLATE pg_catalog."default",
    CONSTRAINT pk_perf_t_deptindexadjust PRIMARY KEY (guid, year, province,mainguid)
);

-- Index: idx_perf_t_deptindexadjust_findex

-- DROP INDEX bgt_330000.idx_perf_t_deptindexadjust_findex;

CREATE INDEX idx_perf_t_deptindexadjust_findex
    ON bgt_330000.perf_t_deptindexadjust USING btree
    (findex COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_perf_t_deptindexadjust_provyear

-- DROP INDEX bgt_330000.idx_perf_t_deptindexadjust_provyear;

CREATE INDEX idx_perf_t_deptindexadjust_provyear
    ON bgt_330000.perf_t_deptindexadjust USING btree
    (province COLLATE pg_catalog."default" ASC NULLS LAST, year ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_perf_t_deptindexadjust_sindex

-- DROP INDEX bgt_330000.idx_perf_t_deptindexadjust_sindex;

CREATE INDEX idx_perf_t_deptindexadjust_sindex
    ON bgt_330000.perf_t_deptindexadjust USING btree
    (sindex COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: pg_oid_2023033001_index

-- DROP INDEX bgt_330000.pg_oid_2023033001_index;

CREATE UNIQUE INDEX pg_oid_2023033001_index
    ON bgt_330000.perf_t_deptindexadjust USING btree
    (oid ASC NULLS LAST)
    TABLESPACE pg_default;

-- Trigger: trg_perf_t_deptindexadjust_updatetime

-- DROP TRIGGER trg_perf_t_deptindexadjust_updatetime ON bgt_330000.perf_t_deptindexadjust;

CREATE OR REPLACE TRIGGER trg_perf_t_deptindexadjust_updatetime
    BEFORE INSERT OR UPDATE 
    ON bgt_330000.perf_t_deptindexadjust
    FOR EACH ROW
  begin 
   if UPDATING then :new.update_time := to_char(sysdate, 'yyyymmddhh24miss');
	end if;
   if :new.update_time<:new.create_time then :new.update_time := :new.create_time;
	end if;
  end;
  
  
-- View: bgt_330000.v_perf_t_deptindexadjust

-- DROP VIEW bgt_330000.v_perf_t_deptindexadjust;

CREATE OR REPLACE VIEW bgt_330000.v_perf_t_deptindexadjust
 AS
 SELECT *
   FROM perf_t_deptindexadjust
  WHERE ((perf_t_deptindexadjust.year = (bgt_330000.global_multyear_cz.v_pmyear)::numeric) AND ((perf_t_deptindexadjust.province)::text = (bgt_330000.global_multyear_cz.v_pmdivid)::text) AND (perf_t_deptindexadjust.is_deleted = (2)::numeric));


-- View: bgt_330000.v_perf_t_adjustgoal

-- DROP VIEW bgt_330000.v_perf_t_adjustgoal;

CREATE OR REPLACE VIEW bgt_330000.v_perf_t_adjustgoal
 AS
 SELECT t.*
   FROM perf_t_adjustgoal t
  WHERE t.year = bgt_330000.global_multyear_cz.v_pmyear AND t.province = bgt_330000.global_multyear_cz.v_pmdivid
  and is_deleted = 2;
