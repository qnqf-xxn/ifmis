begin

--案例模板指标历史数据处理
update perf_t_case set is_deleted = 2 where is_deleted is null;
update perf_t_model set is_deleted = 2 where is_deleted is null;
update perf_t_casemodelindex set is_deleted = 2 where is_deleted is null;
update perf_t_casemodelgoal set is_deleted = 2 where is_deleted is null;

