--1.新建表-perf_t_pushremind
i INTEGER;
BEGIN
	SELECT count( * ) INTO i FROM user_tables t WHERE t.TABLE_NAME = 'PERF_T_PUSHREMIND';
	IF i = 0 THEN execute IMMEDIATE '
			CREATE TABLE PERF_T_PUSHREMIND (
        BGTGE1T VARCHAR2 ( 255 ),
        AMT3 NUMBER,
        AMT4 NUMBER,
        PROGUID VARCHAR2 ( 40 ),
        ISEDIT VARCHAR2 ( 255 ),
        UPDATE_TIME VARCHAR2 ( 255 ),
        STARTDATE VARCHAR2 ( 255 ),
        ORDERNUM VARCHAR2 ( 255 ),
        GUID VARCHAR2 ( 40 ) NOT NULL ENABLE,
        AMT1 NUMBER,
        AMT2 NUMBER,
        ISJK VARCHAR2 ( 1 ) 
      )';
		execute IMMEDIATE 'COMMENT ON COLUMN PERF_T_PUSHREMIND.AMT1 IS ''金额''';
		execute IMMEDIATE 'COMMENT ON COLUMN PERF_T_PUSHREMIND.ISJK IS ''是否监控：1-是；0否；''';
		execute IMMEDIATE 'ALTER TABLE PERF_T_PUSHREMIND ADD CONSTRAINT SYS_C00385160 PRIMARY KEY (GUID) USING INDEX';
	END IF;
--2.新建视图-v_perf_t_pushremind
execute IMMEDIATE ' create or replace view v_perf_t_pushremind as select * from perf_t_pushremind';

