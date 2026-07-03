
begin

--安徽项目监控/自评导入表配置修改
update perf_t_imptemp set num = 11,endnum = 14 where temptype = 'ahxmzczpmb' and datatype = 'bgtget';

update perf_t_imptemp set num = 16 where temptype = 'ahxmzczpmb' and datatype = 'desc';

update perf_t_imptemp set num = 18 where temptype = 'ahxmzczpmb' and datatype = 'index';


update perf_t_imptemp set num = 11,endnum = 13 where temptype = 'ahxmjxjkbg' and datatype = 'bgtget';

update perf_t_imptemp set num = 17 where temptype = 'ahxmjxjkbg' and datatype = 'index';