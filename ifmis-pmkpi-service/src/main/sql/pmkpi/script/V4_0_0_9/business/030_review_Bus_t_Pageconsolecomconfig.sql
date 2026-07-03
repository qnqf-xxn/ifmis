begin
  
DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/review/report/proindex';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/proindex', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/proindex', 'buseditform', '{key:''/pmkpi/review/report/proindex''}', 'editform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/proindex', 'pmkpi_reviewproindex', '{}', 'pmkpireviewproindex', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/proindex', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:true,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,key:''/pmkpi/program/report/treeindex''}', 'indexdatatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/proindex', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/proindex', 'busuidatatable', '{key:''/pmkpi/review/proreview'',edit:true,addrow:false}', 'reviewdatatable', 'pmkpi', null);
