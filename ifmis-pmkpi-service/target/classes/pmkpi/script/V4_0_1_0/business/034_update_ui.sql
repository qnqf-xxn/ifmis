begin
--评审取消确认评审按钮修改action
UPDATE P#busfw_t_Uifunction t set t.action='pmkpireviewreport.unconfirm' where t.key='/pmkpi/review/report/list' and t.code='unconfirm';

--绩效目标评审 “ 是否确认”改成“是否提交”
UPDATE P#busfw_t_Uicolumn t set t.name='是否提交' where t.key='/pmkpi/review/report/program' and t.columncode='ISCONFIRM';
UPDATE P#busfw_t_Uicolumn t set t.name='是否提交' where t.key='/pmkpi/review/report/dept' and t.columncode='ISCONFIRM';

--绩效目标评审 删除创建人
DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/review/report/list' and t.columncode='CREATER';


