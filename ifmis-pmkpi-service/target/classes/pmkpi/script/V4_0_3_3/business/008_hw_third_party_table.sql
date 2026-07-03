    i number;
begin

--第三方信息
select count(1) into i from user_tables t where t.table_name = 'PERF_THIRD_PARTY_INFO';
if i=0 then
    execute immediate 'create table PERF_THIRD_PARTY_INFO
    (
      guid                VARCHAR2(32) not null,
      mainguid            VARCHAR2(40) not null,
      institution_name    VARCHAR2(255),
      leader_name         VARCHAR2(255),
      creater             VARCHAR2(40) not null,
      create_time         VARCHAR2(14) not null,
      update_time         VARCHAR2(14) not null,
      is_deleted          NUMBER(1) not null,
      year                CHAR(4) not null,
      province            VARCHAR2(9) not null
    )
    ';
    execute immediate 'alter table PERF_THIRD_PARTY_INFO add constraint PK_PERF_THIRD_PARTY_INFO primary key (GUID, YEAR, PROVINCE)';
end if;

execute immediate 'create or replace view v_perf_third_party_info as
select
    *
from
    perf_third_party_info
where
    province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted = 2
';

