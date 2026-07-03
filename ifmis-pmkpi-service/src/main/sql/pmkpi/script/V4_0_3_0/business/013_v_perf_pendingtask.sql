begin

--重建视图
execute immediate '
create or replace view V_PERF_PENDINGTASK as
select * from PERF_PENDINGTASK  where status = 1
';


delete from perf_pendingtask where key = '/pmkpi/rectification/dept/index';
insert into perf_pendingtask (GUID, KEY, NAME, STATUS, PROVINCE, YEAR, PARAM, TABCODE, LEFTTABNUM)
values ('4B920409728671B96FA06E960BAB7657', '/pmkpi/rectification/dept/index', '部门整改下达', 1, '87', 2016, '{
    bustype: "1",
    treeid: undefined,
    superguid: undefined,
    tabcode: "waitaudit",
    isleaf: "0",
    saveAgency: "treeroot",
    leftmenuid: "programrectifydepthide",
    querySql: "",
    defquery: "",
    tablecode: "V_PERF_T_RECTIFY",
    tabfilter: null,
    beanid: "pmkpi.rectification.dept.RectificationDeptBOTX",
    lefttabtype: "program",
    menuid: "6D057E3C39B46759E053B11FA8C06045",
    orderby: null,
    queryConfig: undefined,
    tablesql: null,
    taskguid: undefined,
    treename: undefined,
    type: "TRACE"
}', null, null);


