begin
  
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/program/trace/report/ordinaryedit';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/trace/report/ordinaryedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,analysisformaleditform],footer:[toolbutton]}', null, null, 0);


DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/program/trace/report/ordinaryedit';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report/ordinaryedit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report/ordinaryedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report/ordinaryedit', 'bustoolbutton', '{key:''/pmkpi/program/trace/report/edit''}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report/ordinaryedit', 'buseditform', '{key:''/pmkpi/program/trace/report/edit/analysis'',title:''监控分析'',tablecode:''v_perf_t_protraceanalysis''}', 'analysisformaleditform', null, null);



DELETE FROM P#busfw_t_Uitabpage t where t.key='/pmkpi/program/trace/report/ordinaryedit';
insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BDCC68F03DA61BE6E053B11FA8C07281', 'pmkpi', '/pmkpi/program/trace/report/ordinaryedit', '基本信息', 'traceinfo', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, null, '{url:''/pmkpi/program/trace/report/edit/info.page'',busguid:''B7279B405D6C7EB4E0530100007FD738'',action:''protraceinfo.save''}', null, '0', 'taskinfoiframe', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BDCC68F03DA71BE6E053B11FA8C07281', 'pmkpi', '/pmkpi/program/trace/report/ordinaryedit', '预算执行情况', 'tracefund', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '预算执行情况', null, null, '{url:''/pmkpi/program/trace/report/edit/fund.page'',busguid:''B74D29A870344446E0530100007F1A5A'',action:''tracefund.save''}', null, '0', 'taskfundiframe', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BDCC68F03DA81BE6E053B11FA8C07281', 'pmkpi', '/pmkpi/program/trace/report/ordinaryedit', '绩效指标完成情况', 'tracetarget', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效目标完成情况', null, null, '{url:''/pmkpi/program/trace/report/edit/indextarget.page'',busguid:''B760B51D6FA06B86E0530100007F27AE'',action:''proindextrace.save''}', null, '0', 'targetiframe', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BDCC68F03DA91BE6E053B11FA8C07281', 'pmkpi', '/pmkpi/program/trace/report/ordinaryedit', '监控分析', 'traceanalysis', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '监控分析', null, null, '{busguid:''B760B51D6F9E6B86E0530100007F27AE''}', null, '0', 'analysisformaleditform', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BDCC68F03DAA1BE6E053B11FA8C07281', 'pmkpi', '/pmkpi/program/trace/report/ordinaryedit', '附件上传', 'tracefile', 1, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '附件上传', null, '保存', '{url:''/pmkpi/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BDCC68F03DAB1BE6E053B11FA8C07281', 'pmkpi', '/pmkpi/program/trace/report/ordinaryedit', '阶段监控填报', 'protracefund', 0, 12, 'nomal', 'tabfreamedit.clickTabpage', null, '阶段监控填报', null, null, '{url:''/pmkpi/trace/report/proedit/warn.page'',busguid:''BA6668DFDF231167E053B11FA8C08965'',action:''tracewarn.save''}', null, '0', 'taskfundiframe', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BDCC68F03DAC1BE6E053B11FA8C07281', 'pmkpi', '/pmkpi/program/trace/report/ordinaryedit', '绩效目标调整', 'progoal', 0, 10, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效目标调整', null, null, '{busguid:''B9B1886CA7A600A1E053B11FA8C0DBA4'',url:''/pmkpi/adjust/report/proedit/goal.page?istrace=1'',action:''adjustgoal.save''}', null, '0', 'progoaliframe', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BDCC68F03DAD1BE6E053B11FA8C07281', 'pmkpi', '/pmkpi/program/trace/report/ordinaryedit', '绩效指标调整', 'proindex', 0, 11, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效指标调整', null, null, '{busguid:''B9B1886CA7A700A1E053B11FA8C0DBA4'',url:''/pmkpi/adjust/report/proedit/index.page?istrace=1'',action:''adjustindex.save''}', null, '0', 'proindexiframe', null, null, null, null, null, null);
