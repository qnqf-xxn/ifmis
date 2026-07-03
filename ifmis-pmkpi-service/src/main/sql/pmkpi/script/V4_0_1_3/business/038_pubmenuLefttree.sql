--绩效枚举表 --- 左侧树可多选
begin
update bus_t_pageconsolecomconfig t set t.config = '{selectmode:n}' where t.url ='/pmkpi/setting/perfenumset' and t.componentid = 'buslefttree';
