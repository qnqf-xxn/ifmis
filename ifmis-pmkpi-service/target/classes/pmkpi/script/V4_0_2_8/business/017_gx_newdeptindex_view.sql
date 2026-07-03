begin

--¥¥Ω® ”Õº
execute immediate '
create or replace view v_perf_t_case_enum as
select
    t.*
from
    perf_t_case t
where
    t.province = global_multyear_cz.Secu_f_Global_Parm(''DIVID'')
    and t.is_deleted = 2
    and t.wfstatus = ''011''
    and nvl(t.status, 2) <> 3
order by createtime desc
';