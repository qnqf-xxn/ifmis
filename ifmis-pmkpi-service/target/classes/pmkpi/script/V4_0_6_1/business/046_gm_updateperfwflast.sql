begin

update p#Busfw_t_Dcworkflowbranch t
   set t.islastaudit = 1
 where t.action = 'audit'
   and t.wfstatus = '011'
   and exists (SELECT 1
          FROM p#Busfw_t_Dcworkflowplan c
         where c.province = t.province
           and c.year = t.year
           and upper(c.tablecode) like '%PERF%'
           and c.guid = t.wfid);