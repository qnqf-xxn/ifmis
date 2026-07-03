begin

delete from busfw_t_uitable where key = '/pmkpi/evaluatetemp/index';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/evaluatetemp/index','V_PERF_T_RANDOMQUALITY_TYPE',0.0,0.0,0.0,NULL,NULL,'pmkpi','{}',2016,'87');

delete from busfw_t_uicolumn where key = '/pmkpi/evaluatetemp/index';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/evaluatetemp/index','BUSTYPE','绩效类型',4,1,0,NULL,NULL,NULL,NULL,NULL,'#name',NULL,NULL,NULL,1,'tree','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/evaluatetemp/index','CODE','模板编码',2,1,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/evaluatetemp/index','GUID','主键',1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/evaluatetemp/index','NAME','模板名称',3,1,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'s','{}',NULL,87,2016);

delete from busfw_t_uiqueryform where key = '/pmkpi/evaluatetemp/index';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE,YEAR)
values (sys_guid(),'/pmkpi/evaluatetemp/index','NAME','模板名称',1,1,'s',NULL,NULL,NULL,'pmkpi','V_PERF_T_RANDOMQUALITY_TYPE','{}',NULL,87,2016);

delete from busfw_t_uifunction where key = '/pmkpi/evaluatetemp/index';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE,YEAR)
values (sys_guid(),'/pmkpi/evaluatetemp/index','新增',1,1,'searchicon','evaluatetemp.toAdd',NULL,'新增','pmkpi','infosave',NULL,'{}',87,2016);
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE,YEAR)
values (sys_guid(),'/pmkpi/evaluatetemp/index','修改',1,2,'searchicon','evaluatetemp.toEdit',NULL,'修改','pmkpi','edit',NULL,'{}',87,2016);
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE,YEAR)
values (sys_guid(),'/pmkpi/evaluatetemp/index','删除',1,3,'searchicon','evaluatetemp.del',NULL,'删除','pmkpi','del',NULL,'{}',87,2016);
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE,YEAR)
values (sys_guid(),'/pmkpi/evaluatetemp/index','查询',1,3,'searchicon','evaluatetemp.query',NULL,'查询','pmkpi','query',NULL,'{}',87,2016);

delete from busfw_t_uifunction where key = '/pmkpi/evaluatetemp/add';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE,YEAR)
values (sys_guid(),'/pmkpi/evaluatetemp/add','取消',1,2,'nofinishicon','tabfreamedit.close',NULL,'取消','pmkpi',NULL,NULL,'{}',87,2016);
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE,YEAR)
values (sys_guid(),'/pmkpi/evaluatetemp/add','保存',1,1,'keepicon','tabfreamedit.infosave',NULL,'保存','pmkpi',NULL,NULL,'{}',87,2016);

delete from busfw_t_uitabpage where key = '/pmkpi/evaluatetemp/add';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE,YEAR)
values (sys_guid(),'pmkpi','/pmkpi/evaluatetemp/add','评价类型基本信息','evaltype',1,1,'choosed','tabfreamedit.clickTabpage',NULL,'评价类型',NULL,NULL,'{url:''/pmkpi/evaluatetemp/add/edition.page'',action:''evaltypeinfo.infosave''}',NULL,0,'evaltypeiframe',NULL,NULL,NULL,NULL,NULL,NULL,87,2016);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE,YEAR)
values (sys_guid(),'pmkpi','/pmkpi/evaluatetemp/add','评价模板','evaltemp',1,2,'nomal','tabfreamedit.clickTabpage',NULL,'评价模板',NULL,NULL,'{url:''/pmkpi/evaluatetemp/add/randomquality.page'',action:''evaltempinfo.tempsave''}',NULL,0,'evaltempiframe',NULL,NULL,NULL,NULL,NULL,NULL,87,2016);

delete from busfw_t_uieditform where key = '/pmkpi/evaluatetemp/add/edition';
insert into busfw_t_uieditform (guid,key,tablecode,type,name,columncode,isvisiable,showlevel,requirement,defaultvalue,ordernum,colspannum,textarearows,appid,isedit,levelcontrol,config,fromsource,bottomcontrl,setvalue,province,year)
values (sys_guid(),'/pmkpi/evaluatetemp/add/edition','PERF_T_RANDOMQUALITY_TYPE','s','模板编码','CODE',0,NULL,0,NULL,1,0,0,NULL,1,0,'{}',NULL,NULL,NULL,87,2016);
insert into busfw_t_uieditform (guid,key,tablecode,type,name,columncode,isvisiable,showlevel,requirement,defaultvalue,ordernum,colspannum,textarearows,appid,isedit,levelcontrol,config,fromsource,bottomcontrl,setvalue,province,year)
values (sys_guid(),'/pmkpi/evaluatetemp/add/edition','PERF_T_RANDOMQUALITY_TYPE','s','模板名称','NAME',1,NULL,1,NULL,2,0,0,NULL,1,0,'{}',NULL,NULL,NULL,87,2016);
insert into busfw_t_uieditform (guid,key,tablecode,type,name,columncode,isvisiable,showlevel,requirement,defaultvalue,ordernum,colspannum,textarearows,appid,isedit,levelcontrol,config,fromsource,bottomcontrl,setvalue,province,year)
values (sys_guid(),'/pmkpi/evaluatetemp/add/edition','PERF_T_RANDOMQUALITY_TYPE','tree','绩效类型','BUSTYPE',1,NULL,0,NULL,3,0,0,'pmkpi',1,0,'{format:''#name''}',1,NULL,NULL,87,2016);
insert into busfw_t_uieditform (guid,key,tablecode,type,name,columncode,isvisiable,showlevel,requirement,defaultvalue,ordernum,colspannum,textarearows,appid,isedit,levelcontrol,config,fromsource,bottomcontrl,setvalue,province,year)
values (sys_guid(),'/pmkpi/evaluatetemp/add/edition','PERF_T_RANDOMQUALITY_TYPE','s','主键','GUID',0,NULL,0,NULL,0,0,0,NULL,0,0,'{}',NULL,NULL,NULL,87,2016);
insert into busfw_t_uieditform (guid,key,tablecode,type,name,columncode,isvisiable,showlevel,requirement,defaultvalue,ordernum,colspannum,textarearows,appid,isedit,levelcontrol,config,fromsource,bottomcontrl,setvalue,province,year)
values (sys_guid(),'/pmkpi/evaluatetemp/add/edition','PERF_T_RANDOMQUALITY_TYPE','tree','菜单','MENUID',1,NULL,0,NULL,4,0,0,'pmkpi',1,0,'{isMulti:true,format:''#name''}',1,NULL,NULL,87,2016);

delete from busfw_t_uifunction where key = '/pmkpi/evaluatetemp/add/randomquality';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE,YEAR)
values (sys_guid(),'/pmkpi/evaluatetemp/add/randomquality','新增',1,1,'keepicon','evaltempinfo.toAdd',NULL,'新增','pmkpi',NULL,NULL,'{}',87,2016);

delete from busfw_t_uitable where key = '/pmkpi/evaluatetemp/add/randomquality';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE,YEAR)
values (sys_guid(),'/pmkpi/evaluatetemp/add/randomquality','V_PERF_T_RANDOMQUALITY',0,0,0,NULL,NULL,'pmkpi','{}',87,2016);

delete from busfw_t_uicolumn where key = '/pmkpi/evaluatetemp/add/randomquality';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/evaluatetemp/add/randomquality','FININTORGGUID','业务处室',9,1,1,0,0,0,NULL,NULL,'#name',NULL,0,NULL,1,'tree','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/evaluatetemp/add/randomquality','GUID','主键',1,0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/evaluatetemp/add/randomquality','ISCOM','是否为综合处室',10,1,1,0,NULL,0,NULL,NULL,'#name',NULL,NULL,NULL,1,'tree','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/evaluatetemp/add/randomquality','ISLEAF','是否叶子节点',8,1,1,0,NULL,0,NULL,NULL,'#name',NULL,NULL,NULL,1,'tree','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/evaluatetemp/add/randomquality','LEVELNO','级次',7,0,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/evaluatetemp/add/randomquality','OBLIGATE1','操作',0,1,0,0,0,0,1,NULL,NULL,NULL,0,100,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/evaluatetemp/add/randomquality','QUALITYNAME','评价内容',2,1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/evaluatetemp/add/randomquality','QUALITYNAMEEXP','评价内容解释',3,1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/evaluatetemp/add/randomquality','QUALITYSTAND','评分标准',4,1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,200,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/evaluatetemp/add/randomquality','QUALITYWEIGHT','分值',5,1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,50,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/evaluatetemp/add/randomquality','SUPERID','SUPERID',6,0,0,0,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,0,'s','{}',NULL,87,2016);
