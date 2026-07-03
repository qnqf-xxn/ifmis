begin
delete FROM p#Busfw_t_Uieditform t where t.key in
('/pmkpi/perfselftaskmanage/index','/pmkpi/perfself/apply/edit/projinfo','/pmkpi/perfself/apply/edit/selfdesc');

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6DB9AA6A3FD33734E053D100A8C062A1', '/pmkpi/perfself/apply/edit/projinfo', 'V_PERF_PROJECT_INFO', 'tree', '项目类别', 'PROJECTKIND', 1, null, 1, null, 10, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6DB9AA6A3FC43734E053D100A8C062A1', '/pmkpi/perfself/apply/edit/projinfo', 'V_PERF_PROJECT_INFO', 's', '负责人电话', 'LEADER_TEL', 1, null, 0, null, 18, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('4EF7922FE51E4A718B07A03D3776D267', '/pmkpi/perfself/apply/edit/projinfo', 'V_PERF_PROJECT_INFO', 's', '合计得分', 'EXTRACOL1', 0, null, 1, null, 36, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6DB9AA6A3FCD3734E053D100A8C062A1', '/pmkpi/perfself/apply/edit/projinfo', 'V_PERF_PROJECT_INFO', 'tree', '申报单位', 'AGENCYGUID', 1, null, 1, null, 5, null, null, 'pmkpi', 0, null, '{"format":"#name"}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6DB9AA6A3FD73734E053D100A8C062A1', '/pmkpi/perfself/apply/edit/projinfo', 'V_PERF_PROJECT_INFO', 'd', '开始时间', 'STARTDATE', 1, null, 0, null, 13, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6DB9AA6A3FCB3734E053D100A8C062A1', '/pmkpi/perfself/apply/edit/projinfo', 'V_PERF_PROJECT_INFO', 's', '项目名称', 'PRO_NAME', 1, null, 1, null, 2, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6DB9AA6A3FCA3734E053D100A8C062A1', '/pmkpi/perfself/apply/edit/projinfo', 'V_PERF_PROJECT_INFO', 's', '项目编码', 'PRO_CODE', 1, null, 1, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6DB9AA6A3FC93734E053D100A8C062A1', '/pmkpi/perfself/apply/edit/projinfo', 'V_PERF_PROJECT_INFO', 'textarea', '项目内容', 'PRODESC', 1, null, 0, null, 25, 2, '4', 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6DB9AA6A3FD63734E053D100A8C062A1', '/pmkpi/perfself/apply/edit/projinfo', 'V_PERF_PROJECT_INFO', 'tree', '是否政府采购', 'IS_GOVPUR', 1, null, 0, null, 20, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6DB9AA6A3FD53734E053D100A8C062A1', '/pmkpi/perfself/apply/edit/projinfo', 'V_PERF_PROJECT_INFO', 'tree', '清理状态', 'CLEARSTATUS', 0, null, 1, null, 12, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6DB9AA6A3FD43734E053D100A8C062A1', '/pmkpi/perfself/apply/edit/projinfo', 'V_PERF_PROJECT_INFO', 'tree', '项目业务状态', 'PRO_PHASE', 0, null, 1, null, 11, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6DB9AA6A3FD23734E053D100A8C062A1', '/pmkpi/perfself/apply/edit/projinfo', 'V_PERF_PROJECT_INFO', 'tree', '项目属性', 'PROPERTY', 1, null, 1, null, 9, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6DB9AA6A3FC33734E053D100A8C062A1', '/pmkpi/perfself/apply/edit/projinfo', 'V_PERF_PROJECT_INFO', 's', '负责人姓名', 'LEADER_NAME', 1, null, 0, null, 17, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6DB9AA6A3FC53734E053D100A8C062A1', '/pmkpi/perfself/apply/edit/projinfo', 'V_PERF_PROJECT_INFO', 's', '负责人手机', 'LEADER_PHONE', 1, null, 0, null, 19, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6DB9AA6A3FC63734E053D100A8C062A1', '/pmkpi/perfself/apply/edit/projinfo', 'V_PERF_PROJECT_INFO', 'tree', '是否绩效', 'IS_PERFORM', 1, null, 0, null, 21, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6DB9AA6A3FC73734E053D100A8C062A1', '/pmkpi/perfself/apply/edit/projinfo', 'V_PERF_PROJECT_INFO', 'tree', '是否附件', 'IS_ATTACH', 1, null, 0, null, 22, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6DB9AA6A3FC83734E053D100A8C062A1', '/pmkpi/perfself/apply/edit/projinfo', 'V_PERF_PROJECT_INFO', 'tree', '是否基建', 'IS_CAPTIAL_CONS_PRO', 1, null, 0, null, 23, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6DB9AA6A3FCC3734E053D100A8C062A1', '/pmkpi/perfself/apply/edit/projinfo', 'V_PERF_PROJECT_INFO', 's', '主键ID', 'GUID', 0, null, 0, null, 0, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6DB9AA6A3FCE3734E053D100A8C062A1', '/pmkpi/perfself/apply/edit/projinfo', 'V_PERF_PROJECT_INFO', 'tree', '管理处室', 'FININTORGGUID', 1, null, 1, null, 5, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6DB9AA6A3FC03734E053D100A8C062A1', '/pmkpi/perfself/apply/edit/projinfo', 'V_PERF_PROJECT_INFO', 'tree', '业务处室', 'BUSIORGGUID', 1, null, 1, null, 4, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6DB9AA6A3FC13734E053D100A8C062A1', '/pmkpi/perfself/apply/edit/projinfo', 'V_PERF_PROJECT_INFO', 's', '资金申请起始年', 'PRO_START_YEAR', 1, null, 0, null, 15, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6DB9AA6A3FC23734E053D100A8C062A1', '/pmkpi/perfself/apply/edit/projinfo', 'V_PERF_PROJECT_INFO', 's', '资金申报结束年', 'FUNDENDYEAR', 1, null, 0, null, 16, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6E1CF26E6EDEE009E053D100A8C02AF8', '/pmkpi/perfself/apply/edit/projinfo', 'V_PERF_PROJECT_INFO', 'tree', '项目标识', 'VCOL1', 1, null, 1, null, 24, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6DB9AA6A3FCF3734E053D100A8C062A1', '/pmkpi/perfself/apply/edit/projinfo', 'V_PERF_PROJECT_INFO', 'tree', '项目分类', 'PRO_CAT_CODE', 1, null, 1, null, 6, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6DB9AA6A3FD03734E053D100A8C062A1', '/pmkpi/perfself/apply/edit/projinfo', 'V_PERF_PROJECT_INFO', 'tree', '一级项目', 'PRO_LEVONE_NAME', 1, null, 1, null, 7, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6DB9AA6A3FD13734E053D100A8C062A1', '/pmkpi/perfself/apply/edit/projinfo', 'V_PERF_PROJECT_INFO', 'tree', '功能分类', 'EXP_FUNC_CODE', 1, null, 1, null, 8, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('S020706D12084842E0530603A8C0BFDD', '/pmkpi/perfself/apply/edit/selfdesc', 'V_PERF_SELFPERFDESC', 's', '主键ID', 'GUID', 0, null, 0, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('S020706D12154842E0530603A8C0BFDD', '/pmkpi/perfself/apply/edit/selfdesc', 'V_PERF_SELFPERFDESC', 's', '自评得分', 'SCORE', 1, null, 0, null, 2, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('S020706D120F4842E0530603A8C0BFDD', '/pmkpi/perfself/apply/edit/selfdesc', 'V_PERF_SELFPERFDESC', 's', '偏差状态', 'WARN', 0, null, 0, null, 3, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('S020706D12094892E0530603A8C0BFDD', '/pmkpi/perfself/apply/edit/selfdesc', 'V_PERF_SELFPERFDESC', 's', '自评结论', 'SELFRESULT', 1, null, 0, null, 3, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('S020706D12094842E0530603A8C0BFDD', '/pmkpi/perfself/apply/edit/selfdesc', 'V_PERF_SELFPERFDESC', 'textarea', '绩效目标', 'YEARGOAL', 1, null, 0, null, 4, 3, '4', 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('S020706D120A4842E0530603A8C0BFDD', '/pmkpi/perfself/apply/edit/selfdesc', 'V_PERF_SELFPERFDESC', 'textarea', '全年目标完成情况', 'ALLYEARGOAL', 1, null, 1, null, 5, 3, '4', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('S964C005655642A6E0533315A8C04211', '/pmkpi/perfself/apply/edit/selfdesc', 'V_PERF_SELFPERFDESC', 'textarea', '绩效目标偏离原因分析', 'RECTIFICATION', 1, null, 0, null, 6, 3, '4', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('S020706D120E4842E0530603A8C0BFDD', '/pmkpi/perfself/apply/edit/selfdesc', 'V_PERF_SELFPERFDESC', 'textarea', '整改措施及建议', 'DEVIATIONANALY', 1, null, 0, null, 7, 3, '4', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('S020706D120B4842E0530603A8C0BFDD', '/pmkpi/perfself/apply/edit/selfdesc', 'V_PERF_SELFPERFDESC', 'textarea', '其他需说明问题', 'SELFADDINFO', 1, null, 0, null, 8, 3, '4', 'pmkpi', 1, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('P29A1F3980EF4CEBAB28D4A8C8523DD2', '/pmkpi/perfselftaskmanage/index', 'V_PERF_T_SELFEVALTASK', 'i', '预警天数', 'REMAININGDAYS', 1, null, 1, null, 4, null, null, 'pmkpi', 1, null, '{"format":"#name"}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('P596F0E114FA45AE80E3B87CA16F0A67', '/pmkpi/perfselftaskmanage/index', 'V_PERF_T_SELFEVALTASK', 'd', '自评结束时间', 'EVALEND', 1, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('P7AB553764A146D1A664F19BAF525848', '/pmkpi/perfselftaskmanage/index', 'V_PERF_T_SELFEVALTASK', 'd', '自评开始时间', 'EVALSTART', 1, null, 1, null, 2, null, null, 'pmkpi', 1, null, '{}', null, null, null);

delete from p#busfw_t_uieditform t where key in('/pmkpi/perfself/apply/projsfelvtask');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('perfselfapplyprojsfelvtask001', '/pmkpi/perfself/apply/projsfelvtask', 'V_PERF_T_SELFEVALTASK', 'i', '截止天数', 'REMAININGDAYS', 1, null, 0, null, 3, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('perfselfapplyprojsfelvtask002', '/pmkpi/perfself/apply/projsfelvtask', 'V_PERF_T_SELFEVALTASK', 'd', '开始时间', 'EVALSTART', 1, null, 1, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('perfselfapplyprojsfelvtask003', '/pmkpi/perfself/apply/projsfelvtask', 'V_PERF_T_SELFEVALTASK', 'd', '结束时间', 'EVALEND', 1, null, 1, null, 2, null, null, 'pmkpi', 0, null, '{}', null, null, null);
