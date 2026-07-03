 i number;
begin

-- 创建项目表虚拟视图，问题整改选项目使用
  execute immediate'
  CREATE OR REPLACE VIEW PERF_V_PROJECT_INFO AS
   SELECT *
       FROM
   PERF_PROJECT_INFO
     WHERE year = global_multyear_cz.Secu_f_GLOBAL_PARM (''YEAR'')
      AND province = global_multyear_cz.Secu_f_GLOBAL_PARM (''DIVID'')';     
 
  --创建部门表虚拟视图，问题整改选项目使用
  execute immediate'
    CREATE OR REPLACE VIEW V_PERF_V_DEPTPERFDECLARE AS
    SELECT *
       FROM
       PERF_T_DEPTPERFDECLARE
      WHERE year = global_multyear_cz.Secu_f_GLOBAL_PARM (''YEAR'')
      AND province = global_multyear_cz.Secu_f_GLOBAL_PARM (''DIVID'')';
 

