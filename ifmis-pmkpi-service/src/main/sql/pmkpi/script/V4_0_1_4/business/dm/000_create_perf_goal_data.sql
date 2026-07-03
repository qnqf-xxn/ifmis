
  i NUMBER;
begin
  --目标内置数据表（增加字段并加入主键和索引）
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_GOAL_DATA';
  if i=0 then
  execute immediate '
    create table PERF_GOAL_DATA
    (
      guid        VARCHAR2(40),
      totalgoal   VARCHAR2(2000),
      yeargoal    VARCHAR2(2000),
      year        VARCHAR2(4) not null,
      province    VARCHAR2(9) not null,
      projectkind VARCHAR2(40) not null
    )';

  execute immediate 'alter table PERF_GOAL_DATA  add constraint PK_GOAL_DATA primary key (YEAR, PROVINCE, PROJECTKIND)';
  end if;

  execute immediate '
  create or replace view v_perf_goal_data as select * from perf_goal_data where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
  ';
