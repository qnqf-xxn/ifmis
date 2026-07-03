
--只保留中间表指标最大的数据，只分区划
i number;
begin
  --备份中间表数据
  select count(*) into i from user_tables where TABLE_NAME = 'PERF_INDEX_CODE_BAK_0729';
  if i=0 then
      execute immediate '
      create table PERF_INDEX_CODE_BAK_0729 as select * from perf_index_code';
  end if;
 

  for c in(select d.province from perf_index_code d group by d.province) loop
    delete from perf_index_code t
     where not exists
     (select 1
              from (select max(substr(a.tindex, 3)) maxindex, findex, sindex
                      from perf_index_code a
                     where a.province = c.province
                     group by findex, sindex) b
             where b.maxindex = substr(t.tindex, 3)
               and b.findex = t.findex
               and b.sindex = t.sindex)
			   
       and t.province = c.province;
  end loop;

delete from perf_index_code a where (province,findex,sindex,tindex) 
in (select province,findex,sindex,tindex from perf_index_code group by province,findex,sindex,tindex having count(*) > 1)
   and rowid not in (select min(rowid) from perf_index_code group by province,findex,sindex,tindex having count(*) > 1);