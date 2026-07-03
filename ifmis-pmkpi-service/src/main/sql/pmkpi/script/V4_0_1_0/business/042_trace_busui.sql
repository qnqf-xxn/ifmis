begin

update p#busfw_t_uitable t set t.defquery =' t.wfstatus=011 and exists(select 1 from pm_perf_goal_info gl where gl.mainguid=t.guid and gl.yearflag=0) ' where key in('/pmkpi/program/trace/manage/prolist');
