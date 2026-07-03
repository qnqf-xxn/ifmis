 i number;
begin
--perf_bgt_projectpf（批复项目表）
select count(1) into i from user_tables t where t.table_name = 'PERF_BGT_PROJECTPF';
if i=0 then
    execute immediate 'create table PERF_BGT_PROJECTPF
    (
      guid                     VARCHAR2(32) not null,
      pro_id                   VARCHAR2(38) not null,
      pro_code                 VARCHAR2(21) not null,
      pro_name                 VARCHAR2(180) not null,
      agency_code              VARCHAR2(21) not null,
      agencyguid               VARCHAR2(21),
      pro_start_year           VARCHAR2(4),
      setup_year               VARCHAR2(4),
      pro_total_amt            NUMBER(20,2),
      cen_tra_pro_code         VARCHAR2(21),
      create_time              VARCHAR2(14) not null,
      update_time              VARCHAR2(14) not null,
      is_deleted               NUMBER(1) not null,
      year                     CHAR(4) not null,
      province                 VARCHAR2(9) not null
    )
    ';
    execute immediate 'alter table PERF_BGT_PROJECTPF add constraint PK_PERF_BGT_PROJECTPF primary key (GUID, YEAR, PROVINCE)';
end if;

execute immediate '
create or replace view v_perf_bgt_projectpf as
select
    *
from
    perf_bgt_projectpf
where
    year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted = 2
';


