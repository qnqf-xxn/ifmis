
  i integer;
begin
  --绩效枚举表
  select count(*) into i from user_tab_columns  t where t.TABLE_NAME='PERF_ENUM';
  if i=0 then
     execute immediate '
     create table PERF_ENUM
      (
        guid        VARCHAR2(64) not null,
        code        VARCHAR2(100),
        elementcode VARCHAR2(100),
        name        VARCHAR2(200),
        status      CHAR(1),
        createtime  VARCHAR2(17),
        updatetime  VARCHAR2(17),
        year        CHAR(4),
        province    VARCHAR2(9),
        version     NUMBER(9),
        appid       VARCHAR2(100),
        superid     VARCHAR2(38),
        levelno     NUMBER(2) default 1,
        isleaf      NUMBER(1) default 1,
        remark      VARCHAR2(4000),
        creater     VARCHAR2(40),
        ordernum    VARCHAR2(9)
      )';
      execute immediate'alter table PERF_ENUM 
      add constraint PK_PERF_ENUM primary key (GUID,PROVINCE) using index ';
	  execute immediate 'create or replace view V_PERF_ENUM as 
      select * FROM PERF_ENUM T 
      WHERE T.PROVINCE = global_multyear_cz.Secu_f_Global_Parm(''DIVID'')';
end if;
  --中介库
  select count(*) into i from user_tab_columns  t where t.TABLE_NAME='PERF_INTERMEDIARYINFO';
  if i=0 then
     execute immediate '
     create table PERF_INTERMEDIARYINFO
      (
        guid          VARCHAR2(64) not null,
        code          VARCHAR2(100),
        name          VARCHAR2(200),
        status        CHAR(1),
        creater       VARCHAR2(40),
        createtime    VARCHAR2(17),
        updatetime    VARCHAR2(17),
        year          CHAR(4) not null,
        province      VARCHAR2(9) not null,
        legalperson   VARCHAR2(100),
        opendate      VARCHAR2(17),
        institutional VARCHAR2(40),
        creditno      VARCHAR2(40),
        cods          VARCHAR2(200),
        cpa           VARCHAR2(200),
        cta           VARCHAR2(200),
        assessor      VARCHAR2(200),
        address       VARCHAR2(1000),
        phone         VARCHAR2(40),
        tel           VARCHAR2(40),
        email         VARCHAR2(40),
        fax           VARCHAR2(40),
        editpeople    VARCHAR2(40),
        scopebusiness VARCHAR2(40),
        category01    VARCHAR2(40),
        category02    VARCHAR2(40),
        category03    VARCHAR2(40),
        isbadrecord   VARCHAR2(40),
        perfpro       VARCHAR2(4000),
        achievement   VARCHAR2(4000),
        evaluatenum   NUMBER(4),
        logincode     VARCHAR2(40)
      )
      partition by list (PROVINCE)
      subpartition by list (YEAR)
      (
        partition P87 values (''87'')
        (
          subpartition P87_Y2016 values (''2016'')
        )
      )';

      execute immediate'alter table PERF_INTERMEDIARYINFO 
        add constraint PK_PERF_INTERMEDIARYINFO primary key (GUID, YEAR, PROVINCE)
        using index';
        
      execute immediate 'create or replace view V_PERF_INTERMEDIARYINFO as 
      select * FROM PERF_INTERMEDIARYINFO T 
      WHERE T.PROVINCE = global_multyear_cz.Secu_f_Global_Parm(''DIVID'')';
end if;


  --专家库
  select count(*) into i from user_tab_columns  t where t.TABLE_NAME='PERF_EXPERTINIFO';
  if i=0 then
     execute immediate '
     create table PERF_EXPERTINIFO
      (
        guid         VARCHAR2(40) not null,
        code         VARCHAR2(100),
        name         VARCHAR2(200),
        status       CHAR(1),
        creater      VARCHAR2(40),
        createtime   VARCHAR2(17),
        updatetime   VARCHAR2(17),
        year         CHAR(4) not null,
        province     VARCHAR2(9) not null,
        ordernum     NUMBER(9),
        sex          VARCHAR2(40),
        workplace    VARCHAR2(200),
        idcard       VARCHAR2(40),
        nation       VARCHAR2(40),
        political    VARCHAR2(40),
        birth        VARCHAR2(40),
        education    VARCHAR2(40),
        graduate     VARCHAR2(40),
        professional VARCHAR2(40),
        region       VARCHAR2(400),
        specialty    VARCHAR2(400),
        certificate  VARCHAR2(400),
        creditno     VARCHAR2(40),
        phone        VARCHAR2(40),
        tel          VARCHAR2(40),
        email        VARCHAR2(100),
        recommender  VARCHAR2(100),
        workexperie  VARCHAR2(40),
        category     VARCHAR2(32),
        institutions VARCHAR2(32),
        category01   VARCHAR2(40),
        category02   VARCHAR2(40),
        category03   VARCHAR2(40),
        address      VARCHAR2(400),
        employdata   VARCHAR2(40),
        perfpro      VARCHAR2(4000),
        treatise     VARCHAR2(4000),
        opinion      VARCHAR2(4000),
        evaluatenum  NUMBER(4),
        logincode    VARCHAR2(40)
      )
      partition by list (PROVINCE)
      subpartition by list (YEAR)
      (
        partition P87 values (''87'')
        (
          subpartition P87_Y2016 values (''2016'')
        )
      )';

      execute immediate'alter table PERF_EXPERTINIFO 
      add constraint PK_PERF_EXPERTINIFO primary key (GUID, YEAR, PROVINCE) using index ';
        
      execute immediate 'create or replace view V_PERF_EXPERTINIFO as 
      select * FROM PERF_EXPERTINIFO T 
      WHERE T.PROVINCE = global_multyear_cz.Secu_f_Global_Parm(''DIVID'')';
end if;

  --标准库
  select count(*) into i from user_tab_columns  t where t.TABLE_NAME='PERF_STANDARDLIB';
  if i=0 then
     execute immediate '
     create table PERF_STANDARDLIB
      (
        guid          VARCHAR2(40) not null,
        code          VARCHAR2(100),
        name          VARCHAR2(200),
        status        CHAR(1),
        creater       VARCHAR2(40),
        createtime    VARCHAR2(17),
        updatetime    VARCHAR2(17),
        year          CHAR(4) not null,
        province      VARCHAR2(9) not null,
        ordernum      NUMBER(9),
        releasedata   VARCHAR2(40),
        type          VARCHAR2(40),
        releaseagency VARCHAR2(100),
        releasestatus VARCHAR2(100),
        unit          VARCHAR2(100),
        method        VARCHAR2(4000),
        line1         VARCHAR2(500),
        line2         VARCHAR2(500),
        line3         VARCHAR2(500),
        line4         VARCHAR2(500),
        desc1         VARCHAR2(4000),
        desc2         VARCHAR2(4000),
        desc3         VARCHAR2(4000),
        desc4         VARCHAR2(4000),
        remark        VARCHAR2(4000)
      )
      partition by list (PROVINCE)
      subpartition by list (YEAR)
      (
        partition P87 values (''87'')
        (
          subpartition P87_Y2016 values (''2016'')
        )
      )';

      execute immediate'alter table PERF_STANDARDLIB 
      add constraint PK_PERF_STANDARDLIB primary key (GUID, YEAR, PROVINCE) 
      using index  ';
        
      execute immediate 'create or replace view V_PERF_STANDARDLIB as 
      select * FROM PERF_STANDARDLIB T 
      WHERE T.PROVINCE = global_multyear_cz.Secu_f_Global_Parm(''DIVID'')';
end if;

  --问卷库
  select count(*) into i from user_tab_columns  t where t.TABLE_NAME='PERF_PROBLEMLIB';
  if i=0 then
     execute immediate '
     create table PERF_PROBLEMLIB
      (
        guid        VARCHAR2(40) not null,
        code        VARCHAR2(100),
        name        VARCHAR2(200),
        status      CHAR(1),
        creater     VARCHAR2(40),
        createtime  VARCHAR2(17),
        updatetime  VARCHAR2(17),
        year        CHAR(4) not null,
        province    VARCHAR2(9) not null,
        ordernum    NUMBER(9),
        problemtype VARCHAR2(40),
        descs       VARCHAR2(4000),
        options     VARCHAR2(4000),
        remark      VARCHAR2(4000)
      )
      partition by list (PROVINCE)
      subpartition by list (YEAR)
      (
        partition P87 values (''87'')
        (
          subpartition P87_Y2016 values (''2016'')
        )
      )';

      execute immediate'alter table PERF_PROBLEMLIB 
      add constraint PK_PERF_PROBLEMLIB primary key (GUID, YEAR, PROVINCE) 
      using index  ';
        
      execute immediate 'create or replace view V_PERF_PROBLEMLIB as 
      select * FROM PERF_PROBLEMLIB T 
      WHERE T.PROVINCE = global_multyear_cz.Secu_f_Global_Parm(''DIVID'')';
end if;


  --政策法规库
  select count(*) into i from user_tab_columns  t where t.TABLE_NAME='PERF_POLICYLIB';
  if i=0 then
     execute immediate '
     create table PERF_POLICYLIB
      (
        guid        VARCHAR2(40) not null,
        code        VARCHAR2(100),
        name        VARCHAR2(200),
        status      CHAR(1),
        creater     VARCHAR2(40),
        createtime  VARCHAR2(17),
        updatetime  VARCHAR2(17),
        year        CHAR(4) not null,
        province    VARCHAR2(9) not null,
        ordernum    NUMBER(9),
        filetype    VARCHAR2(40),
        keyword     VARCHAR2(4000),
        remark      VARCHAR2(4000),
        isimportant VARCHAR2(40)
      )
      partition by list (PROVINCE)
      subpartition by list (YEAR)
      (
        partition P87 values (''87'')
        (
          subpartition P87_Y2016 values (''2016'')
        )
      )';

      execute immediate'alter table PERF_POLICYLIB 
      add constraint PK_PERF_POLICYLIB primary key (GUID, YEAR, PROVINCE) 
      using index  ';
        
      execute immediate 'create or replace view V_PERF_POLICYLIB as 
      select * FROM PERF_POLICYLIB T 
      WHERE T.PROVINCE = global_multyear_cz.Secu_f_Global_Parm(''DIVID'')';
end if;
