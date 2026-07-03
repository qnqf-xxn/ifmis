i integer;
begin

select count(1) into i from user_tab_cols t where t.table_name='PERF_T_PROMONITOR' and t.column_name='CONAUDITTYPE';
if i=0 then
   execute immediate 'alter table PERF_T_PROMONITOR add CONAUDITTYPE VARCHAR2(40)';
end if;

execute immediate 'create or replace view v_perf_t_promonitor as
select * from perf_t_promonitor t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

execute immediate '
create or replace view perf_v_promonitor as
select T.*,
           case
             when to_number(to_date(b.enddate, ''yyyymmdd'') -
                              to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')) >
                    to_number(b.warndays) then
                ''black''
               when to_number(to_date(b.enddate, ''yyyymmdd'') -
                              to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')) <=
                    to_number(b.warndays) then
                ''red''
               when to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') >
                    to_date(b.enddate, ''yyyymmdd'') then
                ''000''
             end warn,
             to_date(b.enddate, ''yyyymmdd'') -
             to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') as warndays,
             t.update_time as updatetime,
             b.taskstage,
             b.startdate,
             b.enddate,
             b.tasktype,
             b.bustype,
             b.name as taskname
        from v_perf_t_promonitor t
        left join v_perf_t_taskset b
          on b.guid = t.taskguid
       where to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') >=
             to_date(b.startdate, ''yyyymmdd'') - 1
';

DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_PROMONITOR' and t.columncode='CONAUDITTYPE';
insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'CONAUDITTYPE', null, '1', 'CONAUDITTYPE', '1', '2020', '87', 'C231A8592DD172DDE053B11FA8C02712', 'CONAUDITTYPE', 'PERF_T_PROMONITOR', '结论审核类型', 'S', '40', null, 1, 1, null, sysdate);

delete FROM BUS_t_DICCOLUMN WHERE TABLECODE = 'PERF_V_PROMONITOR' AND DBCOLUMNCODE = 'CONAUDITTYPE';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'CONAUDITTYPE', null, '1', 'CONAUDITTYPE', '1', '2020', '87', 'B73465ACA41840FCE0530100007F9134', 'CONAUDITTYPE', 'PERF_V_PROMONITOR', '审核结论', 'S', '40', null, 1, 1, null, sysdate);

delete from fasp_t_dicdssource t where t.CODE='CONAUDITTYPE';
insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('CONAUDITTYPE', 'CONAUDITTYPE', 'CONAUDITTYPE', '浙江审核结论', '1', null, null, null, '2016', '87', null, null, null, '2', 'select code as guid,code,name from v_perf_enum where elementcode = ''PERFCONREVIEW'' order by ordernum', null, 1, 'pmkpi');

delete fasp_t_dicdssource where guid in('PMKPIAUDITTYPECFG');
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIAUDITTYPECFG', 'PMKPIAUDITTYPECFG', 'PMKPIAUDITTYPECFG', '绩效审核流程配置', '1', null, null, null, '2016', '87', null, null, null, '1', '[{guid:"opinion",code:"opinion",name:"意见审核"},{guid:"nature",code:"nature",name:"四性审核"},{guid:"traceopinion",code:"traceopinion",name:"监控审核"},{guid:"evaluation",code:"evaluation",name:"评估审核"},{guid:"perfconreview",code:"perfconreview",name:"监控结论审核"}]', sysdate, null, null);

