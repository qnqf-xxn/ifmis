 
  i integer;
begin
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_PROJECT_INFO';
  if i=0 then
     execute immediate '
      create table PERF_PROJECT_INFO
      (
  pro_id               VARCHAR2(38) not null,
  pro_code             VARCHAR2(21),
  pro_name             VARCHAR2(360),
  pro_cat_code         VARCHAR2(2),
  agency_code          VARCHAR2(21),
  mof_dep_code         VARCHAR2(6),
  finintorgguid        VARCHAR2(6),
  dept_code            VARCHAR2(21),
  manage_dept_code     VARCHAR2(21),
  manage_mof_dep_code  VARCHAR2(6),
  traobj_agency_code   VARCHAR2(21),
  cen_tra_pro_code     VARCHAR2(21),
  pro_source_code      VARCHAR2(1),
  setup_year           VARCHAR2(4),
  pro_start_year       VARCHAR2(4),
  pro_term             VARCHAR2(2),
  distri_type_code     VARCHAR2(1),
  draft_template_code  VARCHAR2(32),
  pro_desc             VARCHAR2(300),
  exp_func_code        VARCHAR2(7),
  pro_total_amt        NUMBER(20,2),
  scoi_invest_fund     NUMBER(20,2),
  fun_res_code         VARCHAR2(6),
  is_useset            NUMBER(1),
  is_track             NUMBER(1),
  is_end               NUMBER(1),
  is_captial_cons_pro  NUMBER(1),
  is_scientific        NUMBER(1),
  pro_depreview        VARCHAR2(4000),
  pro_bgtreview        VARCHAR2(4000),
  dep_aud_opinion_code VARCHAR2(1),
  mof_aud_opinion_code VARCHAR2(1),
  create_time          VARCHAR2(14),
  update_time          VARCHAR2(14),
  version              VARCHAR2(38),
  version_name         VARCHAR2(800),
  is_deleted           NUMBER(1),
  guid                 VARCHAR2(32),
  mof_div_code         VARCHAR2(9),
  lastaudit            NUMBER(1),
  store_phase          VARCHAR2(2),
  pro_phase            VARCHAR2(2),
  pro_levone_id        VARCHAR2(38),
  pro_levone_code      VARCHAR2(21),
  pro_levone_name      VARCHAR2(180),
  pro_lev              VARCHAR2(2),
  leader_name          VARCHAR2(100),
  leader_tel           VARCHAR2(20),
  leader_phone         VARCHAR2(20),
  is_perform           NUMBER(1),
  is_attach            NUMBER(1),
  is_govpur            NUMBER(1),
  is_bgt               NUMBER(1),
  is_thin              NUMBER(1),
  is_other_edit        NUMBER(1),
  is_wait_divide       NUMBER(1),
  is_divide_pro        NUMBER(1),
  is_to_down           NUMBER(1),
  mid_plan_year        VARCHAR2(4),
  orderno1             NUMBER(9),
  orderno2             NUMBER(9),
  orderno3             NUMBER(9),
  orderno4             NUMBER(9),
  vchtypeid            VARCHAR2(32),
  wfstatus             VARCHAR2(32),
  wfid                 VARCHAR2(32),
  creater              VARCHAR2(32),
  lastupdatetime       VARCHAR2(17),
  auditor              VARCHAR2(32),
  v_col1               VARCHAR2(300),
  v_col2               VARCHAR2(300),
  v_col3               VARCHAR2(300),
  v_col4               VARCHAR2(300),
  v_col5               VARCHAR2(300),
  v_col6               VARCHAR2(300),
  v_col7               VARCHAR2(300),
  v_col8               VARCHAR2(300),
  v_col9               VARCHAR2(300),
  v_col10              VARCHAR2(300),
  v_col11              VARCHAR2(300),
  v_col12              VARCHAR2(300),
  v_col13              VARCHAR2(300),
  v_col14              VARCHAR2(300),
  v_col15              VARCHAR2(300),
  v_col16              VARCHAR2(300),
  v_col17              VARCHAR2(300),
  v_col18              VARCHAR2(300),
  v_col19              VARCHAR2(300),
  v_col20              VARCHAR2(300),
  v_col21              VARCHAR2(300),
  v_col22              VARCHAR2(300),
  v_col23              VARCHAR2(300),
  v_col24              VARCHAR2(300),
  v_col25              VARCHAR2(300),
  v_col26              VARCHAR2(300),
  v_col27              VARCHAR2(300),
  v_col28              VARCHAR2(300),
  v_col29              VARCHAR2(300),
  v_col30              VARCHAR2(300),
  n_col1               NUMBER(20,2),
  n_col2               NUMBER(20,2),
  n_col3               NUMBER(20,2),
  n_col4               NUMBER(20,2),
  n_col5               NUMBER(20,2),
  n_col6               NUMBER(20,2),
  n_col7               NUMBER(20,2),
  n_col8               NUMBER(20,2),
  province             VARCHAR2(9) not null,
  year                 CHAR(4) not null,
  adjstatus            NUMBER(1),
  fromguid             VARCHAR2(32),
  ishistory            NUMBER(1),
  ispublish            NUMBER(1),
  agencyguid           VARCHAR2(21),
  projectkind          VARCHAR2(32)
)
      partition by list (PROVINCE)
      subpartition by list (YEAR)
      (
        partition P87 values (''87'')
          pctfree 10
          initrans 1
          maxtrans 255
        (
          subpartition P87_Y2017 values (''2016'')
        )
      )';
     execute immediate 'alter table PERF_PROJECT_INFO
  add constraint PK_PERF_PROJECT_INFO primary key (GUID, YEAR, PROVINCE)
  using index ';
  end if;


  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_OUTPAYPROJECT';
  if i=0 then
     execute immediate '
      create table PERF_T_OUTPAYPROJECT
      (
        guid        VARCHAR2(40) not null,
        mainguid    VARCHAR2(40),
        expfunc     VARCHAR2(40),
        economic    VARCHAR2(40),
        goveconomic VARCHAR2(40),
        c1          NUMBER(18,2),
        c2          NUMBER(18,2),
        c3          NUMBER(18,2),
        c4          NUMBER(18,2),
        c5          NUMBER(18,2),
        c6          NUMBER(18,2),
        c7          NUMBER(18,2),
        c8          NUMBER(18,2),
        c9          NUMBER(18,2),
        c10         NUMBER(18,2),
        c11         NUMBER(18,2),
        c12         NUMBER(18,2),
        c13         NUMBER(18,2),
        c14         NUMBER(18,2),
        c15         NUMBER(18,2),
        c16         NUMBER(18,2),
        c17         NUMBER(18,2),
        c18         NUMBER(18,2),
        c19         NUMBER(18,2),
        c20         NUMBER(18,2),
        c21         NUMBER(18,2),
        c22         NUMBER(18,2),
        c23         NUMBER(18,2),
        c24         NUMBER(18,2),
        c25         NUMBER(18,2),
        c26         NUMBER(18,2),
        agencyguid  VARCHAR2(40),
        creater     VARCHAR2(40) not null,
        createtime  VARCHAR2(17),
        updatetime  VARCHAR2(17),
        budgetyear  NUMBER(4),
        status      NUMBER(1),
        year        NUMBER(4) not null,
        province    VARCHAR2(40) not null,
        remark      VARCHAR2(2000)
      )
      partition by list (PROVINCE)
      subpartition by list (YEAR)
      (
        partition P87 values (''87'')
          pctfree 10
          initrans 1
          maxtrans 255
        (
          subpartition P87_Y2017 values (''2016'')
        )
      )';
     execute immediate 'create index PERF_IND_OUTPAYPROJECT_1 on PERF_T_OUTPAYPROJECT (AGENCYGUID)';
     execute immediate 'create index PERF_IND_OUTPAYPROJECT_3 on PERF_T_OUTPAYPROJECT (MAINGUID)';
     execute immediate 'alter table PERF_T_OUTPAYPROJECT
        add constraint PK_PERF_OUTPAYPROJECT01 primary key (GUID, YEAR, PROVINCE)
        using index ';
  end if;

  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_INDEXTYPE';
  if i=0 then
     execute immediate '
      create table PERF_T_INDEXTYPE
      (
        guid       VARCHAR2(40) not null,
        code       VARCHAR2(50),
        name       VARCHAR2(200),
        remark     VARCHAR2(2000) not null,
        status     NUMBER(1) not null,
        createtime VARCHAR2(17),
        updatetime VARCHAR2(17) not null,
        creater    VARCHAR2(40)
      )';
  end if;

execute immediate '
create or replace view V_PERF_PROJECT_INFO  as 
select * 
from PERF_PROJECT_INFO where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

execute immediate '
create or replace view v_perf_t_outpayproject as
select * 
from PERF_T_OUTPAYPROJECT where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';


