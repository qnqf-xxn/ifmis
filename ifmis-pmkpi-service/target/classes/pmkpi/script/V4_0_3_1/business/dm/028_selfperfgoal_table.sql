 i number;
begin
select count(1) into i from user_tables t where t.table_name = 'PERF_T_SELFPERFGOAL';
if i=0 then
    execute immediate 'create table PERF_T_SELFPERFGOAL
    (
      guid           VARCHAR2(40) not null,
      agencyguid     VARCHAR2(40),
      zqgoal         VARCHAR2(4000),
      ndgoal         VARCHAR2(4000),
      mainguid       VARCHAR2(40),
      createtime     VARCHAR2(17),
      updatetime     VARCHAR2(17),
      creater        VARCHAR2(40),
      province       VARCHAR2(40) not null,
      year           NUMBER(4) not null,
      kpi_dep_id     VARCHAR2(38),
      mof_div_code   VARCHAR2(9),
      fiscal_year    VARCHAR2(4),
      dept_code      VARCHAR2(21),
      kpi_target     VARCHAR2(2000),
      update_time    VARCHAR2(17),
      is_deleted     NUMBER(1) default 2 not null,
      create_time    VARCHAR2(17),
      adj_batch_no   VARCHAR2(6),
      busi_type_code VARCHAR2(6),
      remark         VARCHAR2(2000),
      yearflag       VARCHAR2(1),
      ordernum       NUMBER(4),
      goalname       VARCHAR2(100)
    )';
    -- Add comments to the columns
    execute immediate 'comment on column PERF_T_SELFPERFGOAL.kpi_dep_id is ''部门绩效目标主键''';
    execute immediate 'comment on column PERF_T_SELFPERFGOAL.mof_div_code is ''财政区划代码''';
    execute immediate 'comment on column PERF_T_SELFPERFGOAL.fiscal_year is ''预算年度''';
    execute immediate 'comment on column PERF_T_SELFPERFGOAL.dept_code is ''部门代码''';
    execute immediate 'comment on column PERF_T_SELFPERFGOAL.kpi_target is ''绩效目标''';
    execute immediate 'comment on column PERF_T_SELFPERFGOAL.update_time is ''更新时间''';
    execute immediate 'comment on column PERF_T_SELFPERFGOAL.is_deleted is ''是否删除''';
    execute immediate 'comment on column PERF_T_SELFPERFGOAL.create_time is ''创建时间''';
    -- Create/Recreate primary, unique and foreign key constraints
    execute immediate 'alter table PERF_T_SELFPERFGOAL add constraint PK_PERF_T_SELFPERFGOAL primary key (GUID, YEAR, PROVINCE)';
end if;


delete from bus_t_diccolumn where tablecode = 'PERF_T_SELFPERFGOAL';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'AGENCYGUID', '1', '2016', '87', 'EC4C749AAF71442AE0533315A8C0ED09', 'AGENCYGUID', 'PERF_T_SELFPERFGOAL', '单位', 'S', '40', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'CREATER', '1', '2016', '87', 'EC4C749AAF72442AE0533315A8C0ED09', 'CREATER', 'PERF_T_SELFPERFGOAL', '创建人', 'S', '40', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'CREATETIME', '1', '2016', '87', 'EC4C749AAF73442AE0533315A8C0ED09', 'CREATETIME', 'PERF_T_SELFPERFGOAL', '新增时间', 'S', '40', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'GOALNAME', '1', '2016', '87', 'EC4C749AAF74442AE0533315A8C0ED09', 'GOALNAME', 'PERF_T_SELFPERFGOAL', '名称', 'S', '100', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'GUID', '1', '2016', '87', 'EC4C749AAF75442AE0533315A8C0ED09', 'GUID', 'PERF_T_SELFPERFGOAL', '主键', 'S', '40', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'MAINGUID', '1', '2016', '87', 'EC4C749AAF76442AE0533315A8C0ED09', 'MAINGUID', 'PERF_T_SELFPERFGOAL', '主单guid', 'S', '40', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'NDGOAL', '1', '2016', '87', 'EC4C749AAF77442AE0533315A8C0ED09', 'NDGOAL', 'PERF_T_SELFPERFGOAL', '中期目标', 'S', '4000', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ORDERNUM', '1', '2016', '87', 'EC4C749AAF78442AE0533315A8C0ED09', 'ORDERNUM', 'PERF_T_SELFPERFGOAL', '排序', 'N', '4', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PROVINCE', '1', '2016', '87', 'EC4C749AAF79442AE0533315A8C0ED09', 'PROVINCE', 'PERF_T_SELFPERFGOAL', '区划', 'S', '40', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'REMARK', '1', '2016', '87', 'EC4C749AAF7A442AE0533315A8C0ED09', 'REMARK', 'PERF_T_SELFPERFGOAL', '指标说明', 'S', '2000', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'UPDATETIME', '1', '2016', '87', 'EC4C749AAF7B442AE0533315A8C0ED09', 'UPDATETIME', 'PERF_T_SELFPERFGOAL', '修改时间', 'S', '40', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'YEAR', '1', '2016', '87', 'EC4C749AAF7C442AE0533315A8C0ED09', 'YEAR', 'PERF_T_SELFPERFGOAL', '年度', 'S', '40', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'YEARFLAG', '1', '2016', '87', 'EC4C749AAF7D442AE0533315A8C0ED09', 'YEARFLAG', 'PERF_T_SELFPERFGOAL', '中长期标识', 'S', '1', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ZQGOAL', '1', '2016', '87', 'EC4C749AAF7E442AE0533315A8C0ED09', 'ZQGOAL', 'PERF_T_SELFPERFGOAL', '年度目标', 'S', '4000', null, 1, 1, null, sysdate);




execute immediate '
create or replace view v_perf_t_selfperfgoal as
select
    *
from
    perf_t_selfperfgoal
where
    year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted = 2
';


