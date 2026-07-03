begin
--年中追加表 处理create_time新增字段的历史数据
update PERF_T_DEPTPERFMIDDECLARE t
   set create_time =
         (select max(a.CREATE_TIME)
            from PERF_PROJECT_INFO a
           where a.pro_code = t.pro_code
             and a.is_deleted = '2');
