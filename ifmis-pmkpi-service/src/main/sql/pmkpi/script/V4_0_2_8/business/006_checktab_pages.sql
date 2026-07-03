begin

--1、部门绩效申报填报-送审
delete from perf_t_uitabpage_chec where key = '/pmkpi/deptperformance/report/edit';
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('0702B63159AC1C2FFAE1F06F9D79A346', 'D4D3D3E379A5274CE0533315A8C0ACDD', '部门基本信息', '/pmkpi/deptperformance/report/edit', 'deptinfo', 2, 'perf_t_deptperfdeclare', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('939ABF8FFA29C5BB78C92B04EA0EF7C7', 'D4D3D3E379A6274CE0533315A8C0ACDD', '主要任务', '/pmkpi/deptperformance/report/edit', 'depttask', 2, 'v_perf_t_depttask', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('E0795335D253C194CA95862D24487A69', 'D4D3D3E379A7274CE0533315A8C0ACDD', '绩效目标', '/pmkpi/deptperformance/report/edit', 'deptgoal', 2, 'v_bgt_perf_goal_info', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('C006DAA9FDB61100E3A627543205AA0A', '072A10673CB144C4A171A85DD8BF6E6F', '年度绩效指标', '/pmkpi/deptperformance/report/edit', 'yearindex', 2, 'v_bgt_perf_indicator', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('342D42A9865F784356935F8C943B275D', 'D4D3D3E379A8274CE0533315A8C0ACDD', '年度绩效指标', '/pmkpi/deptperformance/report/edit', 'deptindex', 2, 'bgt_perf_indicator', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('CF947DE2E90C87A001E3358F244292E6', 'D4D3D3E379AA274CE0533315A8C0ACDD', '附件管理', '/pmkpi/deptperformance/report/edit', 'file', 2, 'v_perf_file', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('240FDF5DB9D6D6130A352FDE97CE785A', 'D4D3D3E379AB274CE0533315A8C0ACDD', '广西-整体绩效目标', '/pmkpi/deptperformance/report/edit', 'depttarget', 2, 'v_bgt_perf_goal_info', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('24ADFE20771A9C125160B8EE1AD9AE03', 'D4D3D3E379AC274CE0533315A8C0ACDD', '广西-部门职能活动', '/pmkpi/deptperformance/report/edit', 'deptfun', 2, 'v_perf_t_deptfunction', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('F2F6095D53CA32072ED592475B27A5A3', 'D4D3D3E379AD274CE0533315A8C0ACDD', '考评一类指标', '/pmkpi/deptperformance/report/edit', 'oneindex', 2, 'v_perf_t_deptauditindex', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('0A03AFD2B6C90A95EDF55F2AB110BA58', 'D4D3D3E379AE274CE0533315A8C0ACDD', '绩效指标情况表', '/pmkpi/deptperformance/report/edit', 'indexsituation', 2, null, to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('4BADE86631908D4259C111CA17265F97', 'D4D3D3E379AF274CE0533315A8C0ACDD', '年度主要任务(天津)', '/pmkpi/deptperformance/report/edit', 'yeartask', 2, 'v_perf_t_depttask', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2AA12DBA48939146345CE5A59FFE4E7A', 'DE678C0FD1381E76E0533315A8C03DB1', '部门总体资金情况', '/pmkpi/deptperformance/report/edit', 'deptamt', 2, 'v_perf_t_deptamt', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('D33C947773B115B58BE864F3DCA7C031', 'DE678C0FD1381E76D0533315A8C03DB1', '项目支出情况', '/pmkpi/deptperformance/report/edit', 'deptproexp', 2, 'v_perf_t_deptproexp', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('C08CC179DD6A8F65987259E5693D8A7E', 'DE678C0FD1381E76F0533315A8C03DB1', '部门整体绩效', '/pmkpi/deptperformance/report/edit', 'deptperf', 2, 'v_bgt_perf_goal_info,v_bgt_perf_indicator', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');


--2、绩效监控填报-送审
--2-1、重点监控
delete from perf_t_uitabpage_chec where key = '/pmkpi/program/trace/report/edit';
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('D09302254B79EBB12C82748DF36A6F45', 'D4D3D3E37A99274CE0533315A8C0ACDD', '监控分析', '/pmkpi/program/trace/report/edit', 'traceanalysis', 2, 'v_perf_t_protraceanalysis', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('CCA74F7BB4751032FA52C2EAB510688C', 'D4D3D3E37A7D274CE0533315A8C0ACDD', '基本信息', '/pmkpi/program/trace/report/edit', 'traceinfo', 2, 'v_perf_t_promonitor', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('EC1119473B4E9894426C6432B3EE456F', 'D4D3D3E37A7E274CE0533315A8C0ACDD', '附件上传', '/pmkpi/program/trace/report/edit', 'tracefile', 2, 'v_perf_file', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('BCD816E2AF8051F2F0D328D343E22C48', 'D4D3D3E37A7F274CE0533315A8C0ACDD', '阶段监控填报', '/pmkpi/program/trace/report/edit', 'protracefund', 2, 'v_perf_t_probgtfund,v_perf_t_protraceanalysis', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('FB39827195591C0686DF96E296F4F6F5', 'D4D3D3E37A80274CE0533315A8C0ACDD', '绩效目标调整', '/pmkpi/program/trace/report/edit', 'progoal', 2, 'v_perf_t_adjustgoal', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('5916D70835ADF613F28993865A6A3BFF', 'D4D3D3E37A81274CE0533315A8C0ACDD', '绩效指标调整', '/pmkpi/program/trace/report/edit', 'proindex', 2, 'v_perf_t_adjustindex', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('4FBF8C0BCB852B4FD8C7DB391A0D9F44', 'D4D3D3E37A97274CE0533315A8C0ACDD', '预算执行情况', '/pmkpi/program/trace/report/edit', 'tracefund', 2, 'v_perf_t_probgtfund', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('BA2DB8F6EF2FF0F3B25D67D0EE1690B2', 'D4D3D3E37A98274CE0533315A8C0ACDD', '绩效指标完成情况', '/pmkpi/program/trace/report/edit', 'tracetarget', 2, 'v_perf_t_proindextrace', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');

--2-2、一般监控
delete from perf_t_uitabpage_chec where key = '/pmkpi/program/trace/report/ordinaryedit';
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('81D42F1EB984219E8A6949CA6F8017BF', 'D4D3D3E3797C274CE0533315A8C0ACDD', '基本信息', '/pmkpi/program/trace/report/ordinaryedit', 'traceinfo', 2, 'v_perf_t_promonitor', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('CF30065A606C326EFB5925319E2183D5', 'D4D3D3E3797E274CE0533315A8C0ACDD', '阶段监控填报', '/pmkpi/program/trace/report/ordinaryedit', 'protracefund', 2, 'v_perf_t_probgtfund,v_perf_t_protraceanalysis', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('BCCD2E9BCCD7D5CC8AA82D0BA26E8E61', 'D4D3D3E3797D274CE0533315A8C0ACDD', '预算执行情况', '/pmkpi/program/trace/report/ordinaryedit', 'tracefund', 2, 'v_perf_t_probgtfund', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('1106B0DD309A1DE3F3F34ACB44660C22', 'D4D3D3E3797F274CE0533315A8C0ACDD', '绩效目标调整', '/pmkpi/program/trace/report/ordinaryedit', 'progoal', 2, 'v_perf_t_adjustgoal', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('215F1BC1BFD17D2F17720A61F6271F46', 'D4D3D3E37980274CE0533315A8C0ACDD', '绩效指标调整', '/pmkpi/program/trace/report/ordinaryedit', 'proindex', 2, 'v_perf_t_adjustindex', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('97088EFC5293E74D6523605C45AC2E3F', 'D4D3D3E37981274CE0533315A8C0ACDD', '绩效指标完成情况', '/pmkpi/program/trace/report/ordinaryedit', 'tracetarget', 2, 'v_perf_t_proindextrace', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('3EDE55A610774AA0CDC8E98F7C00052A', 'D4D3D3E37982274CE0533315A8C0ACDD', '监控分析', '/pmkpi/program/trace/report/ordinaryedit', 'traceanalysis', 2, 'v_perf_t_protraceanalysis', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('66D4974D7AE57E0B51D06954688226D8', 'D4D3D3E37983274CE0533315A8C0ACDD', '附件上传', '/pmkpi/program/trace/report/ordinaryedit', 'tracefile', 2, 'v_perf_file', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');

--2-3、部门整体
delete from perf_t_uitabpage_chec where key = '/pmkpi/trace/report/deptedit';
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('7E9DEADE1642DA0D30ABC0029AF348E2', 'D4D3D3E378A3274CE0533315A8C0ACDD', '基本信息', '/pmkpi/trace/report/deptedit', 'depttraceinfo', 2, 'v_perf_t_promonitor', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('41188284921E950AABE23CB2B7FA9532', 'D4D3D3E378A4274CE0533315A8C0ACDD', '阶段监控填报', '/pmkpi/trace/report/deptedit', 'depttracefund', 2, 'v_perf_t_probgtfund,v_perf_t_protraceanalysis', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('A2E0985A0D6A7BF2F0949844EF6A93DB', 'D4D3D3E37A75274CE0533315A8C0ACDD', '预算执行情况', '/pmkpi/trace/report/deptedit', 'tracefund', 2, 'v_perf_t_probgtfund', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('F0AF0C6EB43F737E7247744BDD069480', 'D4D3D3E379EE274CE0533315A8C0ACDD', '绩效目标调整', '/pmkpi/trace/report/deptedit', 'deptgoal', 2, 'v_perf_t_adjustgoal', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('CF01B3C1927C7687CBCA3AE59CD0FE14', 'D4D3D3E379EF274CE0533315A8C0ACDD', '绩效指标调整', '/pmkpi/trace/report/deptedit', 'deptindex', 2, 'v_perf_t_adjustindex', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('4B4B7E7ACD16E2B70B2A0C00406E9B52', 'D4D3D3E378A5274CE0533315A8C0ACDD', '绩效指标完成情况', '/pmkpi/trace/report/deptedit', 'depttracetarget', 2, 'v_perf_t_proindextrace', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('0BFD3275161BB979D58A8F592B40335C', 'D4D3D3E378A7274CE0533315A8C0ACDD', '年度任务', '/pmkpi/trace/report/deptedit', 'deptyeartrace', 2, null, to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('BADBD5985E565CC9B0923D0F2A2A090F', '24D3D3E37A99274CE0533315A8C0ACDD', '监控分析', '/pmkpi/trace/report/deptedit', 'traceanalysis', 2, 'v_perf_t_protraceanalysis', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('9A263AA61C9DFCBA7D724230F3120168', 'D4D3D3E378A6274CE0533315A8C0ACDD', '附件上传', '/pmkpi/trace/report/deptedit', 'depttracefile', 2, 'v_perf_file', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');

--3、绩效自评填报-送审
--3-1、项目支出
delete from perf_t_uitabpage_chec where key = '/pmkpi/perfself/apply/edit';
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('9C37C650E68BC4F7C52BBC9AACB2564D', 'D4D3D3E37A1C274CE0533315A8C0ACDD', '项目基本信息', '/pmkpi/perfself/apply/edit', 'projinfo', 2, 'v_perf_t_selfevaltask', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('4C0FAA43299053FE9A6ABF582ABA873B', 'D4D3D3E37A1E274CE0533315A8C0ACDD', '预算执行情况', '/pmkpi/perfself/apply/edit', 'bdgpay', 2, 'v_perf_t_selfprofund', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('EBF3A0390B94B354B213D2C5958E4F8C', 'D4D3D3E37A1D274CE0533315A8C0ACDD', '预算执行情况(合肥)', '/pmkpi/perfself/apply/edit', 'selfbdgpay', 2, 'v_perf_t_selfprofund', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('EC33D1E860E65EBBE2B7902605BA1FDD', 'D4D3D3E37A1F274CE0533315A8C0ACDD', '指标完成情况', '/pmkpi/perfself/apply/edit', 'selfindex', 2, 'v_perf_t_selfperfindex', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('AC0AEFE00D64AA07E91FA7EB1BB18AE9', 'D4D3D3E37A20274CE0533315A8C0ACDD', '自评补充信息', '/pmkpi/perfself/apply/edit', 'selfdesc', 2, 'v_perf_t_selfperfdesc', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('154BEF65AC815A96B3AB9DE648AA0E11', 'D4D3D3E37A21274CE0533315A8C0ACDD', '附件管理', '/pmkpi/perfself/apply/edit', 'file', 2, 'v_perf_file', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('B3DF8E7AEA8F863C94981C846C85CD25', 'D4D3D3E37A22274CE0533315A8C0ACDD', '评审意见', '/pmkpi/perfself/apply/edit', 'opinion', 2, 'v_perf_t_selfperfopinion', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');

--3-2、部门整体
delete from perf_t_uitabpage_chec where key = '/pmkpi/perfself/apply/dept/edit';
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('B362A4B67F81250DA63E890810B8D2AB', 'D4D3D3E37A6C274CE0533315A8C0ACDD', '部门基本信息', '/pmkpi/perfself/apply/dept/edit', 'projinfo', 2, 'v_perf_t_selfevaltask', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('0FCE8B89705A3B6498C0A71F22FB70E6', 'D4D3D3E37A6D274CE0533315A8C0ACDD', '预算执行情况', '/pmkpi/perfself/apply/dept/edit', 'selffund', 2, 'v_perf_t_selfprofund', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2294AE50353736DC6F747DDB038AD6DE', 'D4D3D3E3797A274CE0533315A8C0ACDD', '预算执行情况(合肥)', '/pmkpi/perfself/apply/dept/edit', 'selfbdgpay', 2, 'v_perf_t_selfprofund', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('0DCA9C17A1CE5D50BC35EDA28CE451F9', 'D4D3D3E37A70274CE0533315A8C0ACDD', '指标完成情况', '/pmkpi/perfself/apply/dept/edit', 'selfindex', 2, 'v_perf_t_selfperfindex', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('02D9CB15CEE4F18D3C21D3CEDB7DEB53', 'D4D3D3E37A72274CE0533315A8C0ACDD', '自评补充信息', '/pmkpi/perfself/apply/dept/edit', 'selfdesc', 2, 'v_perf_t_selfperfdesc', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('1995A6E6E605ED060C8FA80DE3F88577', 'D4D3D3E37A6F274CE0533315A8C0ACDD', '附件管理', '/pmkpi/perfself/apply/dept/edit', 'file', 2, 'v_perf_file', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('A2B31B5CB4D8A20715FD1139ABF330FF', 'D4D3D3E37A71274CE0533315A8C0ACDD', '部门职能概述', '/pmkpi/perfself/apply/dept/edit', 'deptfun', 2, null, to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('150BF0F177D7CAD31FDC43DB63166252', 'D4D3D3E37A51274CE0533315A8C0ACDD', '年度绩效目标', '/pmkpi/perfself/apply/dept/edit', 'deptgoal', 2, null, to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2301033E13D2C1BE67D4C8B1CED94723', 'D4D3D3E37A52274CE0533315A8C0ACDD', '整体绩效目标', '/pmkpi/perfself/apply/dept/edit', 'depttarget', 2, null, to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('05F0308F5C7E29BD202F7BD283C24F03', 'D4D3D3E379FD274CE0533315A8C0ACDD', '评审意见', '/pmkpi/perfself/apply/dept/edit', 'opinion', 2, 'v_perf_t_selfperfopinion', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');

--4、事前绩效评估申报-送审 'v_perf_t_evaluation'
delete from perf_t_uitabpage_chec where key = '/pmkpi/evaluation/report/proedit';
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('FA8181FEAF84FCA200FAFDF50B72A16C', 'DEE0A674AC940DDFE0533315A8C07A45', '基本信息', '/pmkpi/evaluation/report/proedit', 'proinfo', 2, null, to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('6A10E56CEDE4FBB2095638CC67EDCF5D', 'DEE0A674AC920DDFE0533315A8C07A45', '事前绩效评估信息', '/pmkpi/evaluation/report/proedit', 'evaluationinfo', 2, null, to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('A84E514968B66BBAB3C46CABC2A29768', 'DEE0A674AC930DDFE0533315A8C07A45', '附件管理', '/pmkpi/evaluation/report/proedit', 'file', 2, 'v_perf_file', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');

--5、绩效目标修订填报-送审校验[项目支出]
delete from perf_t_uitabpage_chec where key = '/pmkpi/prorevision/report/proedit';
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('6E23C4E0DBE23D437C0750DCD0318772', 'D4D3D3E3790E274CE0533315A8C0ACDD', '基本信息', '/pmkpi/prorevision/report/proedit', 'proinfo', 2, 'v_perf_t_provisiondeclare', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('E304624229F35A3187385252CD43B3B7', 'D4D3D3E378F8274CE0533315A8C0ACDD', '绩效目标修订', '/pmkpi/prorevision/report/proedit', 'progoal', 2, 'v_perf_provision_goal_info', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('757409A3EA80C049FC511E2EA544CA9C', 'D4D3D3E378F9274CE0533315A8C0ACDD', '绩效指标修订', '/pmkpi/prorevision/report/proedit', 'proindex', 2, 'v_perf_provision_indicator', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('EDB658F2C52A4F29ADD176DE967C51CE', 'D4D3D3E378FA274CE0533315A8C0ACDD', '附件管理', '/pmkpi/prorevision/report/proedit', 'file', 2, 'v_perf_file', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('F473EF200CF65DB17E011C2F1CFA6EE7', 'D4D3D3E3790F274CE0533315A8C0ACDD', '资金明细', '/pmkpi/prorevision/report/proedit', 'bugamt', 2, null, to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');

--6、绩效目标调整填报-送审校验
--6-1、项目支出
delete from perf_t_uitabpage_chec where key = '/pmkpi/adjust/report/proedit';
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('FC6DBC2EAD7AA38CDFA30CA8E3F95F47', 'D4D3D3E37A5E274CE0533315A8C0ACDD', '基本信息', '/pmkpi/adjust/report/proedit', 'proinfo', 2, 'v_perf_t_adjust', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('669D904BB307B8E59284AA5415B0C420', 'D4D3D3E37A5F274CE0533315A8C0ACDD', '绩效目标调整', '/pmkpi/adjust/report/proedit', 'progoal', 2, 'v_perf_t_adjustgoal', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('22794A2772821770172B2C7C02BB69BC', 'D4D3D3E37A60274CE0533315A8C0ACDD', '绩效指标调整', '/pmkpi/adjust/report/proedit', 'proindex', 2, 'v_perf_t_adjustindex', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2163B2546ECD0078F87575B84F152094', 'D4D3D3E37A61274CE0533315A8C0ACDD', '附件管理', '/pmkpi/adjust/report/proedit', 'file', 2, 'v_perf_file', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('AE37572C2EEE5F2531444CFA63EC895F', 'D4D3D3E37A62274CE0533315A8C0ACDD', '资金明细', '/pmkpi/adjust/report/proedit', 'bugamt', 2, null, to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('235A62C0E9A287A68D024CD50046CE09', '8962EFA18F4B4F60B01869EB7BFC023D', '绩效目标指标调整(湖北)', '/pmkpi/adjust/report/proedit', 'goalindex', 2, null, to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
--6-2、部门整体
delete from perf_t_uitabpage_chec where key = '/pmkpi/adjust/report/deptedit';
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('8E4EC5B1A34156F60E60F743878D87FB', 'D4D3D3E378D6274CE0533315A8C0ACDD', '基本信息', '/pmkpi/adjust/report/deptedit', 'deptinfo', 2, 'v_perf_t_adjust', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('5C181E998DA952E199F5FC485E61A4F3', 'D4D3D3E378D7274CE0533315A8C0ACDD', '年度任务', '/pmkpi/adjust/report/deptedit', 'yeartask', 2, null, to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('3CB552409D1C413FD847CD41C3C783A5', 'D4D3D3E378D9274CE0533315A8C0ACDD', '绩效目标调整', '/pmkpi/adjust/report/deptedit', 'deptgoal', 2, 'v_perf_t_adjustgoal', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('FF1EA8CA1E6B953C893E7B23D8332D48', 'D4D3D3E378DA274CE0533315A8C0ACDD', '绩效指标调整', '/pmkpi/adjust/report/deptedit', 'deptindex', 2, 'v_perf_t_adjustindex', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
insert into perf_t_uitabpage_chec (GUID, MAINGUID, TABNAME, KEY, CODE, ISCHECKTAB, CHECKTABLE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2DF40A013E59970D05DC15A291CD30A2', 'D4D3D3E378DB274CE0533315A8C0ACDD', '附件管理', '/pmkpi/adjust/report/deptedit', 'file', 2, 'v_perf_file', to_char(SYSDATE,'yyyyMMddHH24miss'), to_char(SYSDATE,'yyyyMMddHH24miss'), '2016', '87');
