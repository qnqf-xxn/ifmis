-- Package: pkg_perf_indexexpdoc

-- DROP PACKAGE pkg_perf_indexexpdoc;

CREATE OR REPLACE PACKAGE pkg_perf_indexexpdoc
IS
    TYPE cs IS REF CURSOR;

    /**
    * 获取部门整体自评指标
    **/
    PROCEDURE getdeptselfindex(p_busguid character varying, OUT o_cs cs);
    
    /**
    * 获取项目自评固化指标
    **/
    PROCEDURE getproselfframe(p_busguid character varying, OUT o_cs cs);

    /**
    * 获取项目自评指标
    **/
    PROCEDURE getproperfself(p_busguid character varying, OUT o_cs cs);
    
    /**
    * 获取财政评价自评指标(项目)
    **/
    PROCEDURE getprofinevalindex(p_busguid character varying, OUT o_cs cs);
    
    /**
    * 获取财政评价自评指标(部门)
    **/
    PROCEDURE getdeptfinevalindex(p_busguid character varying, OUT o_cs cs);
	
	/**
    * 获取部门整体自评指标
    **/
    PROCEDURE getzjdeptself(p_busguid character varying, OUT o_cs cs);
END pkg_perf_indexexpdoc;

CREATE OR REPLACE PACKAGE BODY pkg_perf_indexexpdoc
IS
 
    /**
  * 获取部门申报指标数据.
  **/
    PROCEDURE getdeptselfindex(p_busguid character varying, OUT o_cs cs) IS
    t_sql   varchar2(3000);

    begin
            --select global_multyear_cz.Secu_f_Global_Setparm('','340000000','2021','') into t_sql from dual;
             --循环数据插入name,
             t_sql :='select cc.*,ss.findexnum findexnum, dd.sindexnum,ss.yjweightsum,dd.ejweightsum from (select a.*,
b.name as findexname,
s.name tindexname,
             case when (d.name = ''定性'' or d.name = ''＝'') then s.indexval || s.meterunit else
             d.name || s.indexval || s.meterunit end as  indexval,
             case when (d.name = ''定性'' or d.name = ''＝'') then s.actualvalue || s.meterunit else
             d.name || s.actualvalue || s.meterunit end as  actualvalue,nvl(s.score,0) as score,s.kpi_remark,s.weight,
             :1 busguid from (select
                         t.superid findex,
                         t.guid sindex,

             t.name as  sindexname,
                         t.guid frame,
                         t.ordernum
                    from v_perf_t_frame t
                   where t.frametype = ''DEPT''
                     and t.isleaf = 1) a
                     left join v_perf_t_selfperfindex s on s.findex=a.findex and s.sindex=a.sindex and s.mainguid=:2
                     left join v_perf_enum d on d.code=s.computesign and d.elementcode=''PMKPIZBXS''
                     left join v_perf_t_frame b on b.guid=a.findex)cc
                     left join
(select findex,count(findex) findexnum,sum(nvl(weight,0)) as yjweightsum from (select aa.*,s.weight from (select t.superid findex,t.guid sindex from v_perf_t_frame t
                   where t.frametype = ''DEPT'' and t.isleaf = 1) aa
                     left join v_perf_t_selfperfindex s on s.findex=aa.findex and s.sindex=aa.sindex and s.mainguid=:3) group by findex)ss on ss.findex=cc.findex
                     left join
(select sindex,count(sindex) sindexnum,sum(nvl(weight,0)) as ejweightsum from (select aa.*,s.weight from (select t.superid findex,t.guid sindex from v_perf_t_frame t
                   where t.frametype = ''DEPT'' and t.isleaf = 1) aa
                     left join v_perf_t_selfperfindex s on s.findex=aa.findex and s.sindex=aa.sindex and s.mainguid=:4) group by sindex)dd on dd.sindex=cc.sindex
                     order by cc.ordernum';
              open o_cs for t_sql using p_busguid,p_busguid,p_busguid,p_busguid;
    end;


    /**
  * 获取项目自评固化指标.
  **/
    PROCEDURE getproselfframe(p_busguid character varying, OUT o_cs cs) IS
    t_sql   varchar2(3000);

    begin
            --select global_multyear_cz.Secu_f_Global_Setparm('','340000000','2021','') into t_sql from dual;
             --循环数据插入name,
             t_sql :='select ss.findexnum,dd.sindexnum,ss.yjweightsum,dd.ejweightsum,cc.findex,cc.findexname,cc.sindex,cc.sindexname,cc.tindexname,cc.ordernum,cc.INDEXVAL,cc.ACTUALVALUE,cc.ACTUALWEIGHT,nvl(cc.SCORE,0) as score,cc.KPI_REMARK,:1 busguid from 
(select c.guid as findex,c.name as findexname,b.guid as sindex,b.name as sindexname,a.name as tindexname,a.ORDERNUM,case when (d.name = ''定性'' or d.name = ''＝'') then s.indexval || s.meterunit else
             d.name || s.indexval || s.meterunit end as  indexval,
             case when (d.name = ''定性'' or d.name = ''＝'') then s.actualvalue || s.meterunit else
             d.name || s.actualvalue || s.meterunit end as  actualvalue,s.ACTUALWEIGHT,s.SCORE,s.KPI_REMARK from 
(select * from PERF_T_SELFFRAME t where t.ISLEAF = 1 ) a
left join v_perf_t_selfperfindex s on s.tindex=a.guid and s.mainguid=:2
left join v_perf_enum d on d.code=s.computesign and d.elementcode=''PMKPIZBXS''
left join PERF_T_SELFFRAME b on b.guid=a.superid
left join PERF_T_SELFFRAME c on c.guid=b.superid) cc
left join
(select findex,count(findex) findexnum,sum(nvl(actualweight,0)) as yjweightsum from (select aa.*,s.ACTUALWEIGHT from (select t.SUPERID findex,t.GUID sindex from PERF_T_SELFFRAME t where t.ISLEAF = 0  and t.LEVELNO = ''2'') aa
                     left join v_perf_t_selfperfindex s on s.findex=aa.findex and s.sindex=aa.sindex and s.mainguid=:3) group by findex)ss on ss.findex=cc.findex

                     left join
(select sindex,count(sindex) sindexnum,sum(nvl(actualweight,0)) as ejweightsum from (select aa.*,s.ACTUALWEIGHT from (select t.superid findex,t.guid sindex from PERF_T_SELFFRAME t where t.ISLEAF = 0  and t.LEVELNO = ''2'') aa
                     left join v_perf_t_selfperfindex s on s.findex=aa.findex and s.sindex=aa.sindex and s.mainguid=:4) group by sindex)dd on dd.sindex=cc.sindex
                     order by cc.ordernum';
              open o_cs for t_sql using p_busguid,p_busguid,p_busguid,p_busguid;
    end;


    /**
  * 获取项目自评指标.
  **/
    PROCEDURE getproperfself(p_busguid character varying, OUT o_cs cs) IS
    t_sql   varchar2(3000);

    begin
            --select global_multyear_cz.Secu_f_Global_Setparm('','340000000','2021','') into t_sql from dual;
             --循环数据插入name,
             t_sql :=' select 
 ss.findexnum, dd.sindexnum,ss.yjweightsum,dd.ejweightsum,cc.findex,cc.findexname,cc.sindex,cc.sindexname,cc.tindexname,cc.ordernum,cc.indexval,
 cc.actualvalue,cc.weight as actualweight,nvl(cc.SCORE,0) as score,cc.kpi_remark,:1 busguid from (select
b.name as findexname,
i.name tindexname,
             case when (d.name = ''定性'') then i.indexval || i.meterunit else
             d.name || i.indexval || i.meterunit end as  indexval,
             case when (d.name = ''定性'') then s.actualvalue || s.meterunit else
             d.name || s.actualvalue || s.meterunit end as  actualvalue,
			 s.score,
			 s.kpi_remark,
			 i.weight,
			 a.* from (select
                         t.superid findex,
                         t.guid sindex,
                         t.name sindexname,
                         t.ordernum
                    from v_perf_t_frame t
                   where t.frametype = ''PM001''
                     and t.isleaf = 1) a
					 left join v_pm_perf_indicator i  on i.findex=a.findex and i.sindex=a.sindex and i.pro_code = (select code from PERF_V_SELFEVALTASK where guid=:2) and i.yearflag = ''0'' and i.is_deleted = ''2''
                     left join v_perf_t_selfperfindex s on s.findex=a.findex and s.sindex=a.sindex and i.guid = s.tindex and s.mainguid=:3
                     left join v_perf_enum d on d.code=s.computesign and d.elementcode=''PMKPIZBXS''
                     left join v_perf_t_frame b on b.guid=a.findex)cc
                     left join
(select findex,count(findex) findexnum,sum(nvl(weight,0)) as yjweightsum from (select aa.*,s.weight from (select t.superid findex,t.guid sindex from v_perf_t_frame t
                   where t.frametype = ''PM001'' and t.isleaf = 1) aa
                     left join v_pm_perf_indicator s on s.findex=aa.findex and s.sindex=aa.sindex and s.pro_code = (select code from PERF_V_SELFEVALTASK where guid=:4) and s.yearflag = ''0'' and s.is_deleted = ''2'') group by findex)ss on ss.findex=cc.findex
                     left join
(select sindex,count(sindex) sindexnum,sum(nvl(weight,0)) as ejweightsum from (select aa.*,s.weight from (select t.superid findex,t.guid sindex from v_perf_t_frame t
                   where t.frametype = ''PM001'' and t.isleaf = 1) aa
                     left join v_pm_perf_indicator s on s.findex=aa.findex and s.sindex=aa.sindex and s.pro_code = (select code from PERF_V_SELFEVALTASK where guid=:5) and s.yearflag = ''0'' and s.is_deleted = ''2'') group by sindex)dd on dd.sindex=cc.sindex
                     order by ordernum
';
              open o_cs for t_sql using p_busguid,p_busguid,p_busguid,p_busguid,p_busguid;
    end;
   
    /**
    * 获取财政评价自评指标(项目)
    **/
    PROCEDURE getprofinevalindex(p_busguid character varying, OUT o_cs cs) IS
    t_sql   varchar2(5000);

    begin
            --select global_multyear_cz.Secu_f_Global_Setparm('','340000000','2021','') into t_sql from dual;
             --循环数据插入name,
             t_sql :='select * from (
select :1 as busguid,cc.*,ss.findexnum,dd.sindexnum,ss.yjscoresum,dd.ejscoresum from (select b.GUID as findex,b.NAME as findexname,a.guid as sindex,a.name as sindexname,s.guid as tindex,s.name as tindexname,''——'' as sjindexname,s.EXPLAIN,s.EVALSTD,s.SCORE,s.SELFSCORE,s.REMARK,s.ORDERNUM,1 as tindexnum from (select * from V_PERF_T_EVALUATETEMP t where t.LEVELNO = ''2'' and t.bustype = ''programevaluatescore'') a
left join V_PERF_T_DEPTSCORE s on s.SUPERID=a.guid and s.mainguid=:2
left join V_PERF_T_EVALUATETEMP b on b.guid=a.SUPERID where s.isleaf = ''1'')cc
left join
(select findex,count(findex) findexnum,sum(nvl(score,0)) as yjscoresum from (select aa.*,s.score from (select t.superid findex,t.guid sindex from V_PERF_T_EVALUATETEMP t where t.LEVELNO = ''2'') aa
                     left join (select t.*,t1.SUPERID as findex from V_PERF_T_DEPTSCORE t left join V_PERF_T_EVALUATETEMP t1 on t.SUPERID = t1.GUID) s on s.findex=aa.findex and s.SUPERID=aa.sindex and s.mainguid=:3) group by findex)ss on ss.findex=cc.findex
                     left join
(select sindex,count(sindex) sindexnum,sum(nvl(score,0)) as ejscoresum from (select aa.*,s.score from (select t.superid findex,t.guid sindex from V_PERF_T_EVALUATETEMP t where t.LEVELNO = ''2'') aa
                     left join (select t.*,t1.SUPERID as findex from V_PERF_T_DEPTSCORE t left join V_PERF_T_EVALUATETEMP t1 on t.SUPERID = t1.GUID) s on s.findex=aa.findex and s.SUPERID=aa.sindex and s.mainguid=:4) group by sindex)dd on dd.sindex=cc.sindex

union all
select :5 as busguid,cc.*,kk.tindexnum,ss.findexnum,dd.sindexnum,ss.yjscoresum,dd.ejscoresum from (select m.guid as findex,m.NAME as findexname,b.GUID as sindex,b.NAME as sindexname,a.guid as tindex,a.name as tindexname,s.NAME as sjindexname,s.EXPLAIN,s.EVALSTD,s.SCORE,s.SELFSCORE,s.REMARK,s.ORDERNUM from (select * from V_PERF_T_EVALUATETEMP t where t.LEVELNO = ''3'' and t.ISLEAF = 0  and t.bustype = ''programevaluatescore'') a
left join V_PERF_T_DEPTSCORE s on s.SUPERID=a.guid and s.mainguid=:6
left join V_PERF_T_EVALUATETEMP b on b.guid=a.SUPERID
left join V_PERF_T_EVALUATETEMP m on m.guid=b.SUPERID)cc
left join
(select tindex,count(tindex) tindexnum from (select aa.* from (select t.superid sindex,t.guid tindex from V_PERF_T_EVALUATETEMP t where t.LEVELNO = ''3'') aa
                     left join (select t.*,t1.SUPERID as findex from V_PERF_T_DEPTSCORE t left join V_PERF_T_EVALUATETEMP t1 on t.SUPERID = t1.GUID) s on s.findex=aa.sindex and s.SUPERID=aa.tindex and s.mainguid=:7) group by tindex)kk on kk.tindex=cc.tindex

left join
(select findex,count(findex) findexnum,sum(nvl(score,0)) as yjscoresum from (select aa.*,s.score from (select t.superid findex,t.guid sindex from V_PERF_T_EVALUATETEMP t where t.LEVELNO = ''2'') aa
                     left join (select t.*,t1.GUID as tindex,t2.GUID as sindex,t3.guid as findex from  V_PERF_T_DEPTSCORE t 
left join V_PERF_T_EVALUATETEMP t1 on t.SUPERID = t1.guid
left join V_PERF_T_EVALUATETEMP t2 on t1.SUPERID = t2.guid
left join V_PERF_T_EVALUATETEMP t3 on t2.SUPERID = t3.guid
where t.LEVELNO = ''4'') s on s.findex=aa.findex and s.sindex=aa.sindex and s.mainguid=:8) group by findex)ss on ss.findex=cc.findex
                     left join
(select sindex,count(sindex) sindexnum,sum(nvl(score,0)) as ejscoresum from (select aa.*,s.score from (select t.superid findex,t.guid sindex from V_PERF_T_EVALUATETEMP t where t.LEVELNO = ''2'') aa
                     left join (select t.*,t1.GUID as tindex,t2.GUID as sindex,t3.guid as findex from  V_PERF_T_DEPTSCORE t 
left join V_PERF_T_EVALUATETEMP t1 on t.SUPERID = t1.guid
left join V_PERF_T_EVALUATETEMP t2 on t1.SUPERID = t2.guid
left join V_PERF_T_EVALUATETEMP t3 on t2.SUPERID = t3.guid
where t.LEVELNO = ''4'') s on s.findex=aa.findex and s.sindex=aa.sindex and s.mainguid=:9) group by sindex)dd on dd.sindex=cc.sindex
) order by ordernum';
              open o_cs for t_sql using p_busguid,p_busguid,p_busguid,p_busguid,p_busguid,p_busguid,p_busguid,p_busguid,p_busguid;
    end;

  /**
    * 获取财政评价自评指标(部门)
    **/
    PROCEDURE getdeptfinevalindex(p_busguid character varying, OUT o_cs cs) IS
    t_sql   varchar2(5000);

    begin
            --select global_multyear_cz.Secu_f_Global_Setparm('','340000000','2021','') into t_sql from dual;
             --循环数据插入name,
             t_sql :='select * from (
select :1 as busguid,cc.*,qq.tindexnum,ss.findexnum,dd.sindexnum,ss.yjscoresum,dd.ejscoresum from (select b.GUID as findex,b.NAME as findexname,a.guid as sindex,a.name as sindexname,s.guid as tindex,s.name as tindexname,nvl(s1.NAME,''——'') as sjindexname,s.EXPLAIN,s.EVALSTD,s.targetvalue,s.evaluationrule,s.SCORE,s.SELFSCORE,s.REMARK,s.remarks,s.ORDERNUM from (select * from V_PERF_T_EVALUATETEMP t where t.LEVELNO = ''2'' and t.bustype = ''deptevaluatescore'') a
left join V_PERF_T_DEPTSCORE s on s.SUPERID=a.guid and s.mainguid=:2
left join V_PERF_T_DEPTSCORE s1 on s1.SUPERID = s.GUID
left join V_PERF_T_EVALUATETEMP b on b.guid=a.SUPERID)cc
left join
(select findex,count(findex) findexnum,sum(nvl(score,0)) as yjscoresum from (select aa.*,s.score from (select t.superid findex,t.guid sindex from V_PERF_T_EVALUATETEMP t where t.LEVELNO = ''2'') aa
                     left join (select t.*,t1.SUPERID as findex from V_PERF_T_DEPTSCORE t left join V_PERF_T_EVALUATETEMP t1 on t.SUPERID = t1.GUID) s on s.findex=aa.findex and s.SUPERID=aa.sindex and s.mainguid=:3) group by findex)ss on ss.findex=cc.findex
                     left join
(select sindex,count(sindex) sindexnum,sum(nvl(score,0)) as ejscoresum from (select aa.*,s.score from (select t.superid findex,t.guid sindex from V_PERF_T_EVALUATETEMP t where t.LEVELNO = ''2'') aa
                     left join (select t.*,t1.SUPERID as findex from V_PERF_T_DEPTSCORE t left join V_PERF_T_EVALUATETEMP t1 on t.SUPERID = t1.GUID) s on s.findex=aa.findex and s.SUPERID=aa.sindex and s.mainguid=:4) group by sindex)dd on dd.sindex=cc.sindex
left join
(select tindex,count(tindex) tindexnum from (select aa.* from (select t.superid sindex,t.guid tindex from V_PERF_T_DEPTSCORE t where t.LEVELNO = ''3'') aa
                     left join (select t.*,t1.SUPERID as findex from V_PERF_T_DEPTSCORE t left join V_PERF_T_EVALUATETEMP t1 on t.SUPERID = t1.GUID) s on s.findex=aa.sindex and s.SUPERID=aa.tindex and s.mainguid=:5) group by tindex)qq on qq.tindex=cc.tindex

union all
select :6 as busguid,cc.*,kk.tindexnum,ss.findexnum,dd.sindexnum,ss.yjscoresum,dd.ejscoresum from (select m.guid as findex,m.NAME as findexname,b.GUID as sindex,b.NAME as sindexname,a.guid as tindex,a.name as tindexname,s.NAME as sjindexname,s.EXPLAIN,s.EVALSTD,s.targetvalue,s.evaluationrule,s.SCORE,s.SELFSCORE,s.REMARK,s.remarks,s.ORDERNUM from (select * from V_PERF_T_EVALUATETEMP t where t.LEVELNO = ''3'' and t.ISLEAF = 0  and t.bustype = ''deptevaluatescore'') a
left join V_PERF_T_DEPTSCORE s on s.SUPERID=a.guid and s.mainguid=:7
left join V_PERF_T_EVALUATETEMP b on b.guid=a.SUPERID
left join V_PERF_T_EVALUATETEMP m on m.guid=b.SUPERID)cc
left join
(select tindex,count(tindex) tindexnum from (select aa.* from (select t.superid sindex,t.guid tindex from V_PERF_T_EVALUATETEMP t where t.LEVELNO = ''3'') aa
                     left join (select t.*,t1.SUPERID as findex from V_PERF_T_DEPTSCORE t left join V_PERF_T_EVALUATETEMP t1 on t.SUPERID = t1.GUID) s on s.findex=aa.sindex and s.SUPERID=aa.tindex and s.mainguid=:8) group by tindex)kk on kk.tindex=cc.tindex

left join
(select findex,count(findex) findexnum,sum(nvl(score,0)) as yjscoresum from (select aa.*,s.score from (select t.superid findex,t.guid sindex from V_PERF_T_EVALUATETEMP t where t.LEVELNO = ''2'') aa
                     left join (select t.*,t1.GUID as tindex,t2.GUID as sindex,t3.guid as findex from  V_PERF_T_DEPTSCORE t 
left join V_PERF_T_EVALUATETEMP t1 on t.SUPERID = t1.guid
left join V_PERF_T_EVALUATETEMP t2 on t1.SUPERID = t2.guid
left join V_PERF_T_EVALUATETEMP t3 on t2.SUPERID = t3.guid
where t.LEVELNO = ''4'') s on s.findex=aa.findex and s.sindex=aa.sindex and s.mainguid=:9) group by findex)ss on ss.findex=cc.findex
                     left join
(select sindex,count(sindex) sindexnum,sum(nvl(score,0)) as ejscoresum from (select aa.*,s.score from (select t.superid findex,t.guid sindex from V_PERF_T_EVALUATETEMP t where t.LEVELNO = ''2'') aa
                     left join (select t.*,t1.GUID as tindex,t2.GUID as sindex,t3.guid as findex from  V_PERF_T_DEPTSCORE t 
left join V_PERF_T_EVALUATETEMP t1 on t.SUPERID = t1.guid
left join V_PERF_T_EVALUATETEMP t2 on t1.SUPERID = t2.guid
left join V_PERF_T_EVALUATETEMP t3 on t2.SUPERID = t3.guid
where t.LEVELNO = ''4'') s on s.findex=aa.findex and s.sindex=aa.sindex and s.mainguid=:10) group by sindex)dd on dd.sindex=cc.sindex
) order by ordernum';
              open o_cs for t_sql using p_busguid,p_busguid,p_busguid,p_busguid,p_busguid,p_busguid,p_busguid,p_busguid,p_busguid,p_busguid;
    end;
 
    /**
  * 获取自评部门整体指标（浙江）.
  **/
    PROCEDURE getzjdeptself(p_busguid character varying, OUT o_cs cs) IS
    t_sql   varchar2(5000);

    begin
             t_sql :='selectss.findexnum,dd.sindexnum,ss.yjweightsum,dd.ejweightsum,cc.findex,cc.findexname,cc.sindex,cc.sindexname,cc.tindexname,cc.ordernum,cc.indexval,cc.actualvalue,cc.weight as actualweight,nvl(cc.SCORE,0) as score,cc.kpi_remark,:1 busguid from (select b.name as findexname,i.name tindexname,
             case when (d.name = ''定性'') then i.indexval || i.meterunit else
             d.name || i.indexval || i.meterunit end as  indexval,
             case when (d.name = ''定性'') then s.actualvalue || s.meterunit else
             d.name || s.actualvalue || s.meterunit end as  actualvalue,
			 s.score,
			 s.kpi_remark,
			 i.weight,
			 a.* from (
			select t.kpi_lv1 as findex,t.kpi_lv2 as sindex,t.sname as sindexname,t.ordernum
                        from V_BGT_PERF_INDICATOR t where t.agencyguid = (select code from PERF_V_SELFEVALTASK where guid=:2) and is_deleted = ''2''
                group by kpi_lv1,kpi_lv2,sname,ordernum order by ordernum) a
					 left join (
                select guid,kpi_id,kpi_lv2 as sindex,findex,explain,score as weight,islinked,agencyguid,wfstatus,status,creater,province,
                        year,ordernum,finintorgguid,wfid,mainguid,kpi_lv2 as superid,''3'' as levelno,rule,computesign,meterunit,tindex,targetvalue,
                        mof_div_code,fiscal_year,dept_code,kpi_lv1,kpi_lv2,kpi_lv3,kpi_content,kpi_evalstd,kpi_val,kpi_remark,is_deleted,
                        name,code,kpi_val as  indexval,adj_batch_no,busi_type_code,fun_res_code,indeximport,score,scorerule,kpi_val1,kpi_val2,
                        kpi_val3,proselect,isbudget,sname,opinion_remark,kpivalsource from V_BGT_PERF_INDICATOR t where t.agencyguid = (select code from PERF_V_SELFEVALTASK where guid=:3) and is_deleted = ''2''
					 )i on i.findex=a.findex and i.sindex=a.sindex 
                     left join v_perf_t_selfperfindex s on s.findex=a.findex and s.sindex=a.sindex and i.guid = s.tindex and s.mainguid=:4
                     left join v_perf_enum d on d.code=s.computesign and d.elementcode=''PMKPIZBXS''
                     left join v_perf_t_frame b on b.guid=a.findex)cc
                     left join(select findex,count(findex) findexnum,sum(nvl(weight,0)) as yjweightsum from (select aa.*,s.weight from (
			select t.kpi_lv1 as findex,t.kpi_lv2 as sindex,t.sname as sindexname,t.ordernum
                        from V_BGT_PERF_INDICATOR t where t.agencyguid = (select code from PERF_V_SELFEVALTASK where guid=:5) and is_deleted = ''2''
                group by kpi_lv1,kpi_lv2,sname,ordernum order by ordernum) aa
                     left join (
					 select guid,kpi_id,kpi_lv2 as sindex,findex,explain,score as weight,islinked,agencyguid,wfstatus,status,creater,province,
                        year,ordernum,finintorgguid,wfid,mainguid,kpi_lv2 as superid,''3'' as levelno,rule,computesign,meterunit,tindex,targetvalue,
                        mof_div_code,fiscal_year,dept_code,kpi_lv1,kpi_lv2,kpi_lv3,kpi_content,kpi_evalstd,kpi_val,kpi_remark,is_deleted,
                        name,code,kpi_val as  indexval,adj_batch_no,busi_type_code,fun_res_code,indeximport,score,scorerule,kpi_val1,kpi_val2,
                        kpi_val3,proselect,isbudget,sname,opinion_remark,kpivalsource from V_BGT_PERF_INDICATOR t where t.agencyguid = (select code from PERF_V_SELFEVALTASK where guid=:6) and is_deleted = ''2''
					 ) s on s.findex=aa.findex and s.sindex=aa.sindex) group by findex)ss on ss.findex=cc.findex
                     left join
(select sindex,count(sindex) sindexnum,sum(nvl(weight,0)) as ejweightsum from (select aa.*,s.weight from (
			select t.kpi_lv1 as findex,t.kpi_lv2 as sindex,t.sname as sindexname,t.ordernum
                        from V_BGT_PERF_INDICATOR t where t.agencyguid = (select code from PERF_V_SELFEVALTASK where guid=:7) and is_deleted = ''2''
                group by kpi_lv1,kpi_lv2,sname,ordernum order by ordernum) aa
                     left join (
					  select guid,kpi_id,kpi_lv2 as sindex,findex,explain,score as weight,islinked,agencyguid,wfstatus,status,creater,province,
                        year,ordernum,finintorgguid,wfid,mainguid,kpi_lv2 as superid,''3'' as levelno,rule,computesign,meterunit,tindex,targetvalue,
                        mof_div_code,fiscal_year,dept_code,kpi_lv1,kpi_lv2,kpi_lv3,kpi_content,kpi_evalstd,kpi_val,kpi_remark,is_deleted,
                        name,code,kpi_val as  indexval,adj_batch_no,busi_type_code,fun_res_code,indeximport,score,scorerule,kpi_val1,kpi_val2,
                        kpi_val3,proselect,isbudget,sname,opinion_remark,kpivalsource from V_BGT_PERF_INDICATOR t where t.agencyguid = (select code from PERF_V_SELFEVALTASK where guid=:8) and is_deleted = ''2''
					 ) s on s.findex=aa.findex and s.sindex=aa.sindex) group by sindex)dd on dd.sindex=cc.sindex
                     order by ordernum
';
              open o_cs for t_sql using p_busguid,p_busguid,p_busguid,p_busguid,p_busguid,p_busguid,p_busguid,p_busguid;
    end;

END pkg_perf_indexexpdoc;