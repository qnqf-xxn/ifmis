begin

--更新绩效指标编辑页签【总体绩效】，隐藏【复制总体绩效目标（不带指标值）】按钮hidebtns
update p#busfw_t_uitabpage set hidebtns = hidebtns||',复制总体绩效目标（不带指标值）' where key ='/pmkpi/program/report/treeindex' and hidebtns is not null and instr(hidebtns,'复制总体绩效目标（不带指标值）')=0 and code ='total';