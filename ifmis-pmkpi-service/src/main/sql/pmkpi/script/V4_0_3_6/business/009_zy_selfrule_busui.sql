begin
  
delete from p#busfw_t_uifunction where key = '/pmkpi/perfself/apply/edit/goalandindex';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/edit/goalandindex', '评分说明', 1, 1, 'searchicon', 'selfgoalindex.selfrule', null, '评分说明', 'pmkpi', 'selfrule', null, null, null, null);

update p#busfw_t_uitable set config = '{"tipmark":"部门自评采取评分的形式，满分为100分，不设置加分项，可以不评级。\n 其中:预算执行情况20分，产出指标40分、效益指标和满意度指标40分。省直部门根据各项指标重要程度确定二、三级绩效指标的权重。\n 定性指标根据指标完成情况分为:达成预期指标、部分达成预期指标并具有一定效果、未达成预期指标且效果较差三档，分别按照该指标对应分值区间100-80%(含80%)、80-50%(含50%)、50-0%合理确定分值。"}' where key = '/pmkpi/perfself/apply/edit/hbprogoal';

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/perfself/apply/edit/goalandindex' and componentid = 'bustoolbutton';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/edit/goalandindex', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);


delete from bus_t_pageconsole where url = '/pmkpi/perfself/apply/edit/goalandindex';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/apply/edit/goalandindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfself.page.PerfSelfApplyPage', 'hbgoalindex', '{main:[maintable,toolbutton,datatable]}', null, null, null);


