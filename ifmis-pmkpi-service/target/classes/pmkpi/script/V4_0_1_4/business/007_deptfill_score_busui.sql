begin
--部门评分表03
--预算绩效-财政评价管理-预算部门自评-部门整体填报-评分表   部门评分表展示列注册
delete from p#Busfw_t_Uicolumn t where key = '/pmkpi/evaluation/financial/deptfill/score' and COLUMNCODE in('TARGETVALUE','EVALUATIONRULE','REMARKS');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2AA4FE69B24C439D927DF05D10FFE84C', '/pmkpi/evaluation/financial/deptfill/score', 'TARGETVALUE', '目标值或目标来源', 30, 0, 1, 0, null, 0, null, null, null, null, null, 50, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('EB14384F47AE4B078CD1B4DB0D1C4B24', '/pmkpi/evaluation/financial/deptfill/score', 'EVALUATIONRULE', '评扣分细则', 31, 0, 1, 0, null, 0, null, null, null, null, null, 50, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('E821F790EFE74F80979BD073ADC6B6FC', '/pmkpi/evaluation/financial/deptfill/score', 'REMARKS', '备注', 32, 0, 1, 0, null, 0, null, null, null, null, null, 50, 0, 's', null, null);
