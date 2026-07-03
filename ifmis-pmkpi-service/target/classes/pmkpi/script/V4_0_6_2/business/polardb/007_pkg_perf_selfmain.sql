-- Package: pkg_perf_selfmain

-- DROP PACKAGE pkg_perf_selfmain;

CREATE OR REPLACE PACKAGE pkg_perf_selfmain
IS
    TYPE cs IS REF CURSOR;

    /**
    * 获取项目执行情况
    **/
    PROCEDURE getdeptexp(p_busguid character varying, OUT o_cs cs);
 	/**
    * 获取部门执行情况
    **/
    PROCEDURE getdeptexps(p_busguid character varying, OUT o_cs cs);
	
END pkg_perf_selfmain;

CREATE OR REPLACE PACKAGE BODY pkg_perf_selfmain
IS
 
    /**
  * 获取项目执行情况
  **/
    PROCEDURE getdeptexp(p_busguid character varying, OUT o_cs cs) IS
    
        t_sql   varchar2(3000);
        t_procode varchar2(200);
        begin

                 t_sql := 'select code FROM v_perf_t_selfevaltask s where s.guid = :1 and s.bustype = ''program''';
                 execute immediate t_sql using p_busguid into t_procode;
  				 t_sql := 'select PERF_FUNDPAY_VIEW.set_procode(:1) from dual';
                 execute immediate t_sql using t_procode ;                      
                 t_sql :='SELECT :1 AS busguid,
        t.name,
        '''' AS completion,
        round(nvl(to_number(t.amt1), 0) / 10000, 2) AS amt1,
        round(nvl(t.amt3, 0) / 10000, 2) AS amt3,
        ''0.00'' AS amt5,
        round(nvl(t.amt4, 0) / 10000, 2) AS amt4,
        round(nvl(b.amt6, 0) / 10000, 2) AS amt6,
            CASE
                WHEN (nvl(to_number(t.amt1), 0) + nvl(t.amt2, 0)) = 0 THEN ''0%''
                ELSE round((nvl(t.amt4, 0) + nvl(b.amt6, 0)) / (nvl(to_number(t.amt1), 0) + nvl(t.amt2, 0)) * 100, 2) || ''%''
            END AS bgtget
       FROM v_perf_selfbdgpay_project t
         LEFT JOIN v_perf_t_selfprofund b ON b.name = t.name
       where b.mainguid = :2';
                  open o_cs for t_sql using p_busguid,p_busguid;
    end;

    /**
  * 获取部门执行情况
  **/
    PROCEDURE getdeptexps(p_busguid character varying, OUT o_cs cs) IS
    
        t_sql   varchar2(3000);
        t_procode varchar2(200);
        begin

                 t_sql := 'select code FROM v_perf_t_selfevaltask s where s.guid = :1 and s.bustype = ''dept''';
                 execute immediate t_sql using p_busguid into t_procode;
				 t_sql := 'select PERF_FUNDPAY_VIEW.set_agencyguid(:1) from dual';
                 execute immediate t_sql using t_procode ;                   
				   
                 t_sql :='SELECT :1 AS busguid,
        t.name,
        '''' AS completion,
        round(nvl(to_number(t.amt1), 0) / 10000, 2) AS amt1,
        round(nvl(t.amt3, 0) / 10000, 2) AS amt3,
        ''0.00'' AS amt5,
        round(nvl(t.amt4, 0) / 10000, 2) AS amt4,
        round(nvl(b.amt6, 0) / 10000, 2) AS amt6,
            CASE
                WHEN (nvl(to_number(t.amt1), 0) + nvl(t.amt2, 0)) = 0 THEN ''0%''
                ELSE round((nvl(t.amt4, 0) + nvl(b.amt6, 0)) / (nvl(to_number(t.amt1), 0) + nvl(t.amt2, 0)) * 100, 2) || ''%''
            END AS bgtget
       FROM v_perf_selfbdgpay_dept t
         LEFT JOIN v_perf_t_selfprofund b ON b.name = t.name
       where  b.mainguid = :2 ';
	open o_cs for t_sql using p_busguid,p_busguid;
    end;
 

END pkg_perf_selfmain;