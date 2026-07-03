begin
  --层次分类维护，将按钮名称从复制上一年指标，更改为初始化
update p#busfw_t_uifunction  set name = '初始化数据',title='初始化数据' where key = 'pmkpi/arrangement/index' and name = '复制上一年指标';
