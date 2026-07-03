
 i number;
begin
  
--更新字段展示类型参数名称
update p#busfw_t_uicolumn t set t.config=replace(t.config,'{type:','{lefttabtype:') where t.key like'/pmkpi/%' and t.config like'{type:%';
--监控任务下达修改
update p#busfw_t_uicolumn t set t.ISVISIABLE=0 where t.key='/pmkpi/perfself/taskmanage' and t.columncode='CODE';
update p#busfw_t_uicolumn t set t.config='{}' where t.key='/pmkpi/perfself/taskmanage' and t.columncode='AGENCYGUID';
update p#busfw_t_uicolumn t set t.NAME='项目名称',config='{lefttabtype:''program''}' where t.key='/pmkpi/perfself/taskmanage' and t.columncode='NAME';

--删除列表配置重复字段
select count(1) into i from user_tables t where t.table_name ='P#BUSFW_T_UICOLUMN_TMP1';
if i=0 then
    execute immediate 'create table p#busfw_t_uicolumn_tmp1 as select * from p#busfw_t_uicolumn';
end if;

delete from p#busfw_t_uicolumn t where (key,columncode,year,province) in (select key,columncode,year,province from p#busfw_t_uicolumn group by key,columncode,year,province having count(*) > 1) and rowid not in (select min(rowid) from p#busfw_t_uicolumn group by key, columncode,year,province having count(*) > 1);
--更新绩效配置
update p#busfw_t_uicolumn t set t.name='名称',t.config='{}' where t.columncode='NAME' and t.key in('/pmkpi/adjust/report/list','/pmkpi/evaluation/dept/program','/pmkpi/evaluation/financial/deptassessment','/pmkpi/evaluation/financial/program','/pmkpi/perfself/query','/pmkpi/workevaluate/report/list');
update p#busfw_t_uicolumn t set t.name='编码',t.config='{}' where t.columncode='CODE' and t.key in('/pmkpi/perfself/query','/pmkpi/workevaluate/report/list');