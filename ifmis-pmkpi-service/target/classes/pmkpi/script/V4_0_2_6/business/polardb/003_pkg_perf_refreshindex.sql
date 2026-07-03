-- Package: bgt_330000.pkg_perf_refreshindex

-- DROP PACKAGE bgt_330000.pkg_perf_refreshindex;

CREATE OR REPLACE PACKAGE bgt_330000.pkg_perf_refreshindex
IS
    TYPE cs IS REF CURSOR;

    PROCEDURE refreshindex(pyear character varying, ptablecode character varying, pindexcodenum integer);

    PROCEDURE refreshbasindex(pindexcodenum integer);

    PROCEDURE refreshbasindexcode(ptablecode character varying, pindexcodenum integer);
    
    PROCEDURE setindexcode(pindexcodenum integer, OUT o_cs cs);
END pkg_perf_refreshindex;

CREATE OR REPLACE PACKAGE BODY bgt_330000.pkg_perf_refreshindex
IS
  /**
  * 更新全部指标编码.
  * pindexcodenum 三级指标个数
  **/
    PROCEDURE refreshindex(pyear character varying, ptablecode character varying, pindexcodenum integer) IS
    tmainsql   varchar2(3000);
    tcs          cs;
    tscs          cs;
    t_tcs          cs;
    tprovince    varchar2(9);
    tnum         number(9);
    tfindex      varchar2(40);
    tsindex      varchar2(40);
    t_tindex     varchar2(40);
    tmaxcode     varchar2(30);
    tcode        number(30);
    tguid        varchar2(40);
    tcountnum    number(9);
    begin
      --获取数据表区划，循环区划刷新指标
      tmainsql := 'select province from ' || ptablecode || ' group by province,year having year=:1';
      open tcs for tmainsql using pyear;
       loop
            fetch tcs into tprovince;
            EXIT WHEN tcs%NOTFOUND;
            select global_multyear_cz.Secu_f_Global_Setparm('',''||tprovince||'',''||pyear||'','') into tnum from dual;
            tnum := 0;
            pkg_perf_refreshindex.setIndexCode(pindexcodenum,tscs);
            --获取二级指标

                  tmainsql := 'select findex,sindex,max(to_number(nvl(substr(tindex,3),0))) as tindex,guid from v_perf_index_code';
                  open tscs for tmainsql;
                  loop
                    fetch tscs into tfindex,tsindex,tmaxcode,tguid;
                    EXIT WHEN tscs%NOTFOUND;
                         if tmaxcode is not null then
                            tcode := tmaxcode;
                         else
                            tcode := 0;
                         end if;
                         tcountnum := 0;
                         --查询所有编码
                         tmainsql := 'select guid from '||ptablecode||' t where t.findex=:1 and sindex=:2 and t.code is null and year=:3 and province=:4' ;
                          open t_tcs for tmainsql using tfindex,tsindex,pyear,tprovince;
                          loop
                            fetch t_tcs into t_tindex;
                            EXIT WHEN t_tcs%NOTFOUND;
                                 tcode := tcode + 1;
                                 tcountnum := tcountnum + 1;
                                 tmainsql := 'update ' || ptablecode || ' t set t.code=''' || tsindex || lpad(tcode,pindexcodenum,'0') || ''' where t.guid=:1';
                                 execute immediate tmainsql using t_tindex;
                                 if tcountnum > 1000 then
                                   commit;
                                 end if;
                          end loop;
                          close t_tcs;
                          tmainsql := 'update v_perf_index_code t set t.tindex=''' || tsindex || lpad(tcode,pindexcodenum,'0') || ''' where t.guid=:1';
                          execute immediate tmainsql using tguid;
                  end loop;
                  close tscs;

       end loop;
       close tcs;
       if ptablecode = 'pm_perf_indicator' then
          tmainsql := 'update pm_perf_indicator t set t.code=(select code from perf_v_checkindex i where i.guid=t.tindex and nvl(i.code,0)<>0) where nvl(t.tindex, ''0'') <> ''0'' and exists(select 1 from perf_v_checkllindex a where a.guid=t.tindex) ';
          execute immediate tmainsql;
          tmainsql := 'update pm_perf_indicator t set t.kpi_lv3=t.code where t.year=:1';
          execute immediate tmainsql using pyear;
       end if;
       if ptablecode = 'bgt_perf_indicator' then
          tmainsql := 'update bgt_perf_indicator t set t.kpi_lv3=t.code where t.year=:1';
          execute immediate tmainsql using pyear;
       end if;

    end;

    /**
      * 更新指标库指标编码分区划不分年度
      * pindexcodenum 三级指标个数
      **/
    PROCEDURE refreshbasindex(pindexcodenum integer) IS
    tmainsql   varchar2(3000);
    tcs          cs;
    tscs          cs;
    t_tcs          cs;
    tprovince    varchar2(9);
    tnum         number(9);
    tfindex      varchar2(40);
    tsindex      varchar2(40);
    t_tindex     varchar2(40);
    tmaxcode     varchar2(30);
    tcode        number(30);
    tcountnum    number(9);
    begin
      --获取数据表区划，循环区划刷新指标
      tmainsql := 'select province from bas_perf_indicator group by province';
      open tcs for tmainsql;
       loop
            fetch tcs into tprovince;
            EXIT WHEN tcs%NOTFOUND;
            tnum := 0;

            --获取二级指标
                  tmainsql := 'select t.ele_id as sindex,t.parent_id as findex from perf_t_frame t where t.is_deleted=2 and t.level_no=2 and year=2016 and province=87';
                  open tscs for tmainsql;
                  loop
                    fetch tscs into tsindex,tfindex;
                    EXIT WHEN tscs%NOTFOUND;
                         --查询一二级指标下最大的编码
                         tmainsql := 'select max(to_number(nvl(substr(code,3),0))) as code from bas_perf_indicator t where findex=:1 and sindex =:2 and province = :3';
                         execute immediate tmainsql into tmaxcode using tfindex,tsindex, tprovince;
                         if tmaxcode is not null then
                            tcode := tmaxcode;
                         else
                            tcode := 0;
                         end if;
                         tcountnum := 0;
                         --查询所有编码
                         tmainsql := 'select guid from bas_perf_indicator t where t.findex=:1 and sindex=:2 and t.province=:3';
                          open t_tcs for tmainsql using tfindex,tsindex,tprovince;
                          loop
                            fetch t_tcs into t_tindex;
                            EXIT WHEN t_tcs%NOTFOUND;
                                 tcountnum := tcountnum+1;
                                 tnum := tnum+1;
                                 tcode := tcode + 1;
                                 tmainsql := 'update bas_perf_indicator t set t.code=''' || tsindex || lpad(tcode,pindexcodenum,'0') || ''' where t.guid=:1 and t.province=:2';
                                 execute immediate tmainsql using t_tindex,tprovince;
                                /* if tcountnum > 1000 then
                                   commit;
                                   tcountnum := 0;
                                 end if;*/
                          end loop;
                          close t_tcs;
                  end loop;
                  close tscs;
       end loop;
       close tcs;
       tmainsql := 'update bas_perf_indicator t set t.perf_ind_code=t.code';
       execute immediate tmainsql;

    end;

    /**
    导入刷新指标编码
    * pindexcodenum 三级指标个数
    **/
    PROCEDURE refreshbasindexcode(ptablecode character varying, pindexcodenum integer) IS
    tmainsql   varchar2(3000);
    tscs          cs;
    t_tcs          cs;
    tfindex      varchar2(40);
    tsindex      varchar2(40);
    t_tindex     varchar2(40);
    tmaxcode     varchar2(30);
    tcode        number(30);
    tguid        varchar2(40);
    begin
       --select global_multyear_cz.Secu_f_Global_Setparm('','340000000','2021','') into tcode from dual;
       pkg_perf_refreshindex.setIndexCode(pindexcodenum,tscs);
       --查询一二级指标下最大的编码
       tmainsql := 'select findex,sindex,max(to_number(nvl(substr(tindex,3),0)))as tindex,guid from v_perf_index_code';
                  open tscs for tmainsql;
                  loop
                    fetch tscs into tfindex,tsindex,tmaxcode,tguid;
                    EXIT WHEN tscs%NOTFOUND;
                       if tmaxcode is not null then
                            tcode := tmaxcode;
                         else
                            tcode := 0;
                         end if;
                         --查询所有编码
                         tmainsql := 'select guid from '||ptablecode||' t where t.findex=:1 and sindex=:2 and t.code=''000000000''' ;
                          open t_tcs for tmainsql using tfindex,tsindex;
                          loop
                            fetch t_tcs into t_tindex;
                            EXIT WHEN t_tcs%NOTFOUND;
                                 tcode := tcode + 1;
                                 tmainsql := 'update ' || ptablecode || ' t set t.code=''' || tsindex || lpad(tcode,pindexcodenum,'0') || ''' where t.guid=:1';
                                 execute immediate tmainsql using t_tindex;
                                 
                          end loop;
                          close t_tcs;
                          tmainsql := 'update v_perf_index_code t set t.tindex=''' || tsindex || lpad(tcode,pindexcodenum,'0') || ''' where t.guid=:1';
                          execute immediate tmainsql using tguid;
                  end loop;
                  close tscs;

       if ptablecode = 'v_bas_perf_indicator' then
            tmainsql := 'update v_bas_perf_indicator t set t.perf_ind_code=(select a.code from v_bas_perf_indicator a where t.guid=a.guid) where t.perf_ind_code=''000000000''';
            execute immediate tmainsql;
       end if;
       if ptablecode = 'v_pm_perf_indicator' or ptablecode = 'v_bgt_perf_indicator' then
            tmainsql := 'update '||ptablecode||' t set t.kpi_lv3=(select a.code from '||ptablecode||' a where t.guid=a.guid) where t.kpi_lv3=''000000000''';
            execute immediate tmainsql;
       end if;
    end;

    /**
    获取指标编码
    **/
    PROCEDURE setindexcode(pindexcodenum integer, OUT o_cs cs) IS
    tmainsql   varchar2(3000);
    tinsertsql   varchar2(3000);
    tcs          cs;
    tfindex      varchar2(40);--一级指标
    tsindex      varchar2(40);--二级指标
    tmaxcode     varchar2(30);--最大指标值
    tcode        varchar2(30);--
    tnum         number(3);
    tguid        varchar2(40);
    tyear        varchar2(4);
    tprovince    varchar2(9);
    t_time         varchar2(17);
    begin
       --select global_multyear_cz.Secu_f_Global_Setparm('','340000000','2021','') into tcode from dual;
       select global_multyear_cz.v_pmYear into tyear from dual;
       select global_multyear_cz.v_pmDivID into tprovince from dual;
       select to_char(sysdate,'yyyymmddhh24miss') into t_time from dual;
       --获取二级指标
        tmainsql := 'select t.guid sindex,t.superid findex from v_perf_t_frame t where t.levelno=2';
        open tcs for tmainsql;
          loop
          fetch tcs into tsindex,tfindex;
          EXIT WHEN tcs%NOTFOUND;
            tmainsql := 'select count(1) from v_perf_index_code t where t.findex = :1 and t.sindex = :2';
            execute immediate tmainsql into tnum using tfindex,tsindex;
            if tnum = 0 then
              select sys_guid() into tguid from dual;
              tmainsql := 'select max(to_number(COALESCE(substr(code,3),'0'))) as code from perf_v_queryallindex where findex=:1 and sindex =:2';
              execute immediate tmainsql into tmaxcode using tfindex,tsindex;
              if tmaxcode is not null and tmaxcode <> 0 then
                 tcode := tmaxcode;
              else
                 tcode := 0;
              end if;
              tcode := tsindex || lpad((tcode+1),pindexcodenum,'0');
              tinsertsql := 'insert into v_perf_index_code(guid, findex, sindex, tindex, province, year, createtime, updatetime)
              values(:1,:2,:3,:4,:5,:6,:7,:8)';
              execute immediate tinsertsql using tguid,tfindex,tsindex,tcode,tprovince,tyear,t_time,t_time;
            end if;
          end loop;
        close tcs;
        tmainsql := 'select * from v_perf_index_code a where exists(select 1 from v_perf_t_frame t where t.levelno=2 and a.findex=t.superid and a.sindex=t.guid) order by a.findex,a.sindex';
        open o_cs for tmainsql;
    end;

END pkg_perf_refreshindex;