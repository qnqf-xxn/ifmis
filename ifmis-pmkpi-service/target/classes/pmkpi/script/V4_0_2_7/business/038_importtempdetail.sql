begin

update p#fw_t_importtempdetail t set t.importdscfg='t.levelno=1 and t.frametype=''PM001''' where t.tempid='0CCEB959EB0AB5B4A07D0E41EB004CF4' and t.columnid ='V412538AA08B62E3E0535164A8C0C98B';
update p#fw_t_importtempdetail t set t.importdscfg='t.frametype=''PM001'' and exists(select 1 from v_perf_t_frame a where a.guid=t.superguid and a.levelno=1 and a.frametype=''PM001'') order by code' where t.tempid='0CCEB959EB0AB5B4A07D0E41EB004CF4' and t.columnid ='V412538AA08C62E3E0535164A8C0C98B';
update p#fw_t_importtempdetail t set t.importds='checked' where t.tempid='0CCEB959EB0AB5B4A07D0E41EB004CF4' and t.columnid in('V7A738A2A10A42538A319BBC13E839DA','V412538AA08B62E3E0535164A8C0C98B','V412538AA08C62E3E0535164A8C0C98B','V686DC99B6E90CCAE0530100007FB3EC','V7625FA0D4E347EAACD5F0253ABC5975');

update p#fw_t_importtempdetail t set t.importdscfg='t.levelno=1 and t.frametype=''PM001''' where t.tempid='C0EC31E80960F7D9E053B11FA8C07BC8' and t.columnid ='V412538AA08B62E3E0535164A8C0C98B';
update p#fw_t_importtempdetail t set t.importdscfg='t.frametype=''PM001'' and exists(select 1 from v_perf_t_frame a where a.guid=t.superguid and a.levelno=1 and a.frametype=''PM001'') order by code' where t.tempid='C0EC31E80960F7D9E053B11FA8C07BC8' and t.columnid ='V412538AA08C62E3E0535164A8C0C98B';
update p#fw_t_importtempdetail t set t.importds='checked' where t.tempid='C0EC31E80960F7D9E053B11FA8C07BC8' and t.columnid in('V686DC99B6E90CCAE0530100007FB3EC','V7625FA0D4E347EAACD5F0253ABC5975','V412538AA08C62E3E0535164A8C0C98B','V412538AA08B62E3E0535164A8C0C98B','V7A738A2A10A42538A319BBC13E839DA');

update p#fw_t_importtempdetail t set t.importdscfg='t.levelno=1 and t.frametype=''PM001''' where t.tempid='DF3090872F61D51E869508819570FD1E' and t.columnid ='V412538AA08B62E3E0535164A8C0C98B';
update p#fw_t_importtempdetail t set t.importdscfg='t.frametype=''PM001'' and exists(select 1 from v_perf_t_frame a where a.guid=t.superguid and a.levelno=1 and a.frametype=''PM001'') order by code' where t.tempid='DF3090872F61D51E869508819570FD1E' and t.columnid ='V412538AA08C62E3E0535164A8C0C98B';
update p#fw_t_importtempdetail t set t.importds='checked' where t.tempid='DF3090872F61D51E869508819570FD1E' and t.columnid in('V7625FA0D4E347EAACD5F0253ABC5975','V7A738A2A10A42538A319BBC13E839DA','V412538AA08B62E3E0535164A8C0C98B','V412538AA08C62E3E0535164A8C0C98B','VC79169FC8344B758B85C73BAF7D81F5');


update p#fw_t_importtempdetail t set t.importdscfg='t.levelno=1 and t.frametype=''DEPT''' where t.tempid='C3C0E32D46E2D2FFE053B11FA8C09CE8' and t.columnid ='V47721D4F9CA1010E0535164A8C05EF7';
update p#fw_t_importtempdetail t set t.importdscfg='t.frametype=''DEPT'' and exists(select 1 from v_perf_t_frame a where a.guid=t.superguid and a.levelno=1 and a.frametype=''DEPT'') order by code' where t.tempid='C3C0E32D46E2D2FFE053B11FA8C09CE8' and t.columnid ='V47721D4F9CB1010E0535164A8C05EF7';
update p#fw_t_importtempdetail t set t.importds='checked' where t.tempid='C3C0E32D46E2D2FFE053B11FA8C09CE8' and t.columnid in('V47721D4F9CB1010E0535164A8C05EF7','V522E34BFB994994AEBF0705157E4F03','V47721D4F9CA1010E0535164A8C05EF7');

update p#fw_t_importtempdetail t set t.importdscfg='t.levelno=1 and t.frametype=''PM001''' where t.tempid='F22550FECC0C4266E3A75BE686315FC4' and t.columnid ='V412538AA09862E3E0535164A8C0C98B';
update p#fw_t_importtempdetail t set t.importdscfg='t.frametype=''PM001'' and exists(select 1 from v_perf_t_frame a where a.guid=t.superguid and a.levelno=1 and a.frametype=''PM001'') order by code' where t.tempid='F22550FECC0C4266E3A75BE686315FC4' and t.columnid ='V412538AA09B62E3E0535164A8C0C98B';
update p#fw_t_importtempdetail t set t.importds='checked' where t.tempid='F22550FECC0C4266E3A75BE686315FC4' and t.columnid in('V412538AA09B62E3E0535164A8C0C98B','V412538AA09862E3E0535164A8C0C98B','VB63374F64074736AC7C9DC78FE0A1D2');
