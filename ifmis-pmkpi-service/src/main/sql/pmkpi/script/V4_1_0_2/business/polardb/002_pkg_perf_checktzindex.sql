-- Package: pkg_perf_checktzindex

-- DROP PACKAGE pkg_perf_checktzindex;

CREATE OR REPLACE PACKAGE pkg_perf_checktzindex
IS
  TYPE cs IS REF CURSOR;
  --  调整绩效目标校验
  PROCEDURE checkproindex(OUT o_cs cs);

END pkg_perf_checktzindex;

CREATE OR REPLACE PACKAGE BODY pkg_perf_checktzindex
IS
  PROCEDURE checkproindex(OUT o_cs cs) IS
       tmainsql      varchar(4000);
       tinsertsql    varchar(4000);
       tcs             cs;
       tprocs          cs;
       tramark       varchar(4000);--提示信息
       tagencyname   varchar(4000); --单位名称
       tablecatcode  varchar2(32); -- 项目类别
       tablecode     varchar(400); --物理表名
       tablename     varchar(400); --中文表名
       tauditName    varchar(400); --审核定义名称
       talarmlevels  varchar(1);    -- 0 :强制性审核   1：提示性审核
       tnum          number(20);
       tchecktype    varchar2(1);
       tyear         number(4);     --年度
       tprovince     varchar2(200); --区划
       tproname      varchar2(400); -- 项目名称
       tproguid      varchar2(200); -- 项目guid
       tprocode      varchar(200);  -- 项目code
       tfindex       varchar2(40); -- 一级指标
       tsindex       varchar2(40); -- 二级指标
       tsindexname   varchar2(4000); -- 三级指标名称
	   tprolev   	 varchar2(2); -- 项目级次
	   tdept   	     varchar2(50); -- 部门
       tcount        number(10);
       tisperform    varchar2(4); --特殊绩效
       tfound_type_code number(10); 
    begin
      talarmlevels:= '0';
      select global_multyear_cz.v_pmYear into tyear from dual;       --年度
      select global_multyear_cz.v_pmDivID into tprovince from dual;  -- 区划

      select global_multyear_cz.Secu_f_Global_Setparm('',''||tprovince||'',''||tyear||'','') into tcount from dual;
    
        tmainsql := 'select t.name as pro_name,t.guid,t.pro_code,a.code||''-''||a.name,t.pro_lev 
		from perf_t_adjust t left join pmkpi_fasp_t_pubagency a on t.agencyguid=a.guid 
		where t.bustype = ''program'' and t.wfstatus != ''011'' and exists(select 1 from perf_tmp_guids a where a.guid=t.guid)';

        tablecode:='perf_t_adjustgoal';
        tablename:='项目绩效目标调整表';
        tauditName:='绩效目标调整审核';
        open tprocs for tmainsql;
          loop
            fetch tprocs into tproname,tproguid,tprocode,tagencyname,tprolev;
            EXIT WHEN tprocs%NOTFOUND;
       
			-- 校验年度二级项目 或 年度一级项目
			if (tprolev = '2') or (tprolev = '1') then
				--年度绩效目标
				tmainsql:='select nvl(count(1),0) from perf_t_adjustgoal t where is_deleted = 2 and t.pro_code=:1 and t.mainguid =:2 and trim(REPLACE(REPLACE(adjustndgoal, CHR(13), ''''), CHR(10), '''')) = '''' ';
				execute immediate tmainsql into tnum using tprocode,tproguid;
				if tnum = 1 and tproguid is not null then
					tramark := tproname || '- 项目年度目标不能填写空格,换位符,回车！ ';
					tinsertsql := 'insert into perf_tmp_auditerrorinfo(guid,busguid,remark,agencyname,tablecode,tablename,auditname,alarmlevels) values(:1,:2,:3,:4,:5,:6,:7,:8)';
					execute immediate tinsertsql using tproguid,tproguid,tramark,tagencyname,tablecode,tablename,tauditName,talarmlevels;
				end if;
				tmainsql:='select nvl(count(1),0) from perf_t_adjustgoal t where is_deleted = 2 and t.pro_code=:1 and t.mainguid =:2 and (TRIM(adjustndgoal ) = ''-'' OR  TRIM(adjustndgoal ) = ''_'' OR  TRIM(adjustndgoal ) = ''*'') ';
				execute immediate tmainsql into tnum using tprocode,tproguid;
				if tnum = 1 and tproguid is not null then
					tramark := tproname || '- 项目年度目标不能填写特殊符号(*_-)！  ';
					tinsertsql := 'insert into perf_tmp_auditerrorinfo(guid,busguid,remark,agencyname,tablecode,tablename,auditname,alarmlevels) values(:1,:2,:3,:4,:5,:6,:7,:8)';
					execute immediate tinsertsql using tproguid,tproguid,tramark,tagencyname,tablecode,tablename,tauditName,talarmlevels;
				end if;
				-- 年度绩效指标
                tablecode:='perf_t_adjustindex';
                tablename:='项目绩效指标调整表';
                tauditName:='绩效指标调整审核';
				
                --产出指标下至少填报一条三级指标
                tmainsql := 'select nvl(count(1),0) from perf_t_adjustindex t where yearflag= ''0'' and is_deleted = 2 and t.findex =''1'' and t.pro_code=:1 and t.mainguid =:2';
                execute immediate tmainsql into tnum using tprocode,tproguid;
                if tnum=0 and tproguid is not null then
                  tramark :=  tproname || '- 年度绩效 - 产出指标下至少填报一条三级指标';
                  tinsertsql := 'insert into perf_tmp_auditerrorinfo(guid,busguid,remark,agencyname,tablecode,tablename,auditname,alarmlevels) values(:1,:2,:3,:4,:5,:6,:7,:8)';
                  execute immediate tinsertsql using tproguid,tproguid,tramark,tagencyname,tablecode,tablename,tauditName,talarmlevels;
                end if;
                --效益指标下至少填报一条三级指标
                tmainsql := 'select nvl(count(1),0) from perf_t_adjustindex t where yearflag= ''0'' and is_deleted = 2 and t.findex =''2'' and t.pro_code=:1 and t.mainguid =:2';
                execute immediate tmainsql into tnum using tprocode,tproguid;
                if tnum=0 and tproguid is not null then
                  tramark := tproname || '- 年度绩效 - 效益指标下至少填报一条三级指标';
                  tinsertsql := 'insert into perf_tmp_auditerrorinfo(guid,busguid,remark,agencyname,tablecode,tablename,auditname,alarmlevels) values(:1,:2,:3,:4,:5,:6,:7,:8)';
                  execute immediate tinsertsql using tproguid,tproguid,tramark,tagencyname,tablecode,tablename,tauditName,talarmlevels;
                end if;
			end if;
          end loop;
        close tprocs;
        tmainsql := 'select * from perf_tmp_auditerrorinfo';
        open o_cs for tmainsql;
    end;

END pkg_perf_checktzindex;