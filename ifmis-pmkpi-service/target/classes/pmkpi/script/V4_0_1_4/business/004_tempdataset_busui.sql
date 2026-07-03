begin
--评分模板表01
-- 预算绩效管理-预算绩效配置管理-模板配置-评分表  展示列配置
delete from p#Busfw_t_Uicolumn t where key = '/pmkpi/setting/tempdataset' and COLUMNCODE in('TARGETVALUE','EVALUATIONRULE');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D5A7A2CB6C0444118E639AF1EB657B61', '/pmkpi/setting/tempdataset', 'TARGETVALUE', '目标值或目标来源', 30, 0, 1, 0, null, 0, null, null, null, null, null, 50, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('A08859283A08464EB9939782BCB79892', '/pmkpi/setting/tempdataset', 'EVALUATIONRULE', '评扣分细则', 31, 0, 1, 0, null, 0, null, null, null, null, null, 50, 0, 's', null, null);

