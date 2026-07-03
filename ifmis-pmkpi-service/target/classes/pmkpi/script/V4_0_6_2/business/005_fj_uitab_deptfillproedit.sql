begin

--ĞŞ¸´Òì³£µÄÒ³Ç©code
update p#busfw_T_uitabpage t set t.code = 'fileflow' where t.key = '/pmkpi/evaluation/financial/deptfill/proedit' 
  and t.code = 'filefloud' and t.config like '%finselfevapro%';