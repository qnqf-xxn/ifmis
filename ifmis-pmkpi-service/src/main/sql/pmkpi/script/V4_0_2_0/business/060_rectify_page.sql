begin
  --整改页面配置，去掉框架的js
delete from bus_t_pagecomponent where id in('pmkpi_rectification','pmkpi_rectificationadd',
                                      'pmkpi_rectificationaudit','pmkpi_feedback','pmkpi_feedbackAudit',
                                      'pmkpi_reftifyfile','pmkpi_rectifyinfo','pmkpi_feedbackinfo');
--整改通知编制
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_rectification', '整改通知下达', null, '整改通知下达', '/pmkpi/rectification/rectificationIndex.js', 'Ext.lt.pmkpi.rectification.index', 'pmkpi', 'pmkpi.rectification.RectificationService');

--选项目
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_rectificationadd', '选择项目', null, '选择项目', '/pmkpi/rectification/rectificationproj.js', 'Ext.lt.pmkpi.rectification.add.proj', 'pmkpi', 'pmkpi.rectification.RectificationAddProjService');

--整改通知审核
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_rectificationaudit', '整改通知审核', null, '整改通知审核', '/pmkpi/rectification/rectificationaudit.js', 'Ext.lt.pmkpi.rectification.audit.index', 'pmkpi', 'pmkpi.rectification.RectificationAuditService');

--整改情况反馈
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_feedback', '整改情况反馈', null, '整改情况反馈', '/pmkpi/rectification/feedbackIndex.js', 'Ext.lt.pmkpi.rectification.feedback.index', 'pmkpi', 'pmkpi.rectification.FeedbackIndexService');

--整改情况审核
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_feedbackAudit', '整改情况审核', null, '整改情况审核', '/pmkpi/rectification/feedbackauditIndex.js', 'Ext.lt.pmkpi.feedback.audit.index', 'pmkpi', 'pmkpi.rectification.FeedbackAuditIndexService');



--整改通知附件
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_reftifyfile', '整改通知附件', null, '整改通知附件', '/pmkpi/rectification/rectificationfile.js', 'Ext.lt.pmkpi.rectification.rectificationfile', 'pmkpi', 'pmkpi.rectification.RectificationFileService');

--整改通知详情
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_rectifyinfo', '整改通知详情', null, '整改通知详情', '/pmkpi/rectification/rectificationinfo.js', 'Ext.lt.pmkpi.rectification.info', 'pmkpi', 'pmkpi.rectification.RectificationAddService');

--反馈信息详情
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_feedbackinfo', '反馈信息详情', null, '反馈信息详情', '/pmkpi/rectification/feedbackInfo.js', 'Ext.lt.pmkpi.rectification.feedback.info', 'pmkpi', 'pmkpi.rectification.FeedbackInfoService');
