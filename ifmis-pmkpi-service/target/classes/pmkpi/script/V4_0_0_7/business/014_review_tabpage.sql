begin
  
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/review/report/proedit';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/review/report/proedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,editform,goaleditform]}', null, null, 0);

UPDATE P#busfw_t_Uitabpage t set t.isvisiable='0' where t.key='/pmkpi/review/report/proedit' and t.code='bugamt' and t.guid='B9BA5CC53EFF2EB4E053B11FA8C08954';
