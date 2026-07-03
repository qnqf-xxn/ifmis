i number;
begin

select count(*) into i from user_tables where TABLE_NAME = 'PERF_T_UITABPAGE_CHEC';
if i=0 then
    execute immediate '
      create table PERF_T_UITABPAGE_CHEC
      (
        guid       VARCHAR2(40) not null,
        mainguid   VARCHAR2(40),
        tabname    VARCHAR2(255),
        key        VARCHAR2(255),
        code       VARCHAR2(255),
        ischecktab NUMBER(1),
        checktable VARCHAR2(255),
        createtime VARCHAR2(17),
        updatetime VARCHAR2(17),
        year       VARCHAR2(4) not null,
        province   VARCHAR2(9) not null
      )
    ';
    execute immediate 'alter table PERF_T_UITABPAGE_CHEC add constraint PK_PERF_T_UITABPAGE_CHEC primary key (GUID, YEAR, PROVINCE)';
end if;

--÷ÿππ ”Õº
execute immediate '
create or replace view v_perf_t_uitabpage_chec as
select * from perf_t_uitabpage_chec
where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
';
