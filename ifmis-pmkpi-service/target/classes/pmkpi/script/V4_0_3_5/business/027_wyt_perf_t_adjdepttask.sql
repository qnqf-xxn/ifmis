i number;
begin
 select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_ADJDEPTTASK';
  if i = 0 then
   execute immediate '
      create table PERF_T_ADJDEPTTASK
      (
        guid          VARCHAR2(40) not null,
        agencyguid    VARCHAR2(40),
        name          VARCHAR2(500),
        context       VARCHAR2(4000),
        totalamt      NUMBER(20,2),
        financialfund NUMBER(20,2),
        otherfund     NUMBER(20,2),
        mainguid      VARCHAR2(40),
        createtime    VARCHAR2(17) not null,
        updatetime    VARCHAR2(17),
        creater       VARCHAR2(40) not null,
        province      VARCHAR2(40) not null,
        year          NUMBER(4) not null,
        basicfund     NUMBER(20,2),
        projectfund   NUMBER(20,2),
        ordernum      NUMBER(9),
        isedit        VARCHAR2(40)
      )';
  end if;
  
  --÷ÿππ ”Õº
  execute immediate '
    CREATE OR REPLACE VIEW V_PERF_T_ADJDEPTTASK AS
    SELECT t.*
    FROM
      PERF_T_ADJDEPTTASK t
    WHERE
      year = global_multyear_cz.Secu_f_GLOBAL_PARM ( ''YEAR'' )
      AND province = global_multyear_cz.Secu_f_GLOBAL_PARM (''DIVID'')';
