if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.perfprotrace){
    Ext.lt.pmkpi.perfprotrace = {};
}
if(!Ext.lt.pmkpi.perfprotrace.managetaskcopy){
    Ext.lt.pmkpi.perfprotrace.managetaskcopy = {};
}

Ext.lt.pmkpi.perfprotrace.managetaskcopy = function(config, service){
    var cmp = {};
    var _menuid = config.menuid,//菜单id
        _pagetype = config.pagetype,//部门/财政
        _taskguid = config.taskguid,//任务guid
        _tabcode = config.tabcode,//页签编码
        _prolev = config.prolev,//项目级次
        _tasktype = config.tasktype,//任务类型
        _tablecode = config.tablecode,//复制任务查询表
        _taskstage = config.taskstage,//任务阶段
        _tasksname = config.tasksname,//任务名称
        _tasksenddate = config.tasksenddate,//任务结束时间
        _seltaskguid;//
    window.parent.Ext.lt.pmkpi.childwindow = window;

    Ext.lt.message.hook("editform", "drawed",function(resp){
        var table_eva={
            taskguid:{
                asyncloaddata:function(param){
                        var taskdatas = Ext.lt.RCP.asyncall(service , "getTaskByBusType", [_taskguid]);
                        param.data = taskdatas;
                },
                change: function(param){
                    if (param.sels && param.sels.length == 1) {
                        _seltaskguid = param.sels[0].itemid;
                    } else {
                        _seltaskguid = "";
                    }
                }
            }
        }
        resp.editformpanel.attachEvent(table_eva);
    });

    /**
     * 确认
     */
    cmp.taskcopy = function (){
        if (!_seltaskguid || _seltaskguid == "") {
            Ext.lt.ui.alert("请选择要复制的任务！",function(){});
            return;
        }
        Ext.lt.ui.confirm('是否确认进行任务复制？',{icon: "warn"},function(is){
            if(is){
                var params = {};
                params.pagetype = _pagetype;
                params.taskguid = _taskguid;
                params.tabcode = _tabcode;
                params.seltaskguid = _seltaskguid;
                params.menuid = _menuid;
                params.prolev = _prolev;
                params.tasktype = _tasktype;
                params.tablecode = _tablecode;
                params.taskstage = _taskstage;
                params.tasksname = _tasksname;
                params.tasksenddate = _tasksenddate;
                Ext.lt.RCP.call(service , "taskCopy", params, function(rs){
                    if (rs && rs.flg == "1") {
                        Ext.lt.ui.alert('任务复制成功！',function(){
                            parent.Ext.lt.ui.modalWindow.close();
                            parent.Ext.lt.pmkpi.query();
                        });
                    }
                },function(){
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('任务复制失败！',function(){
                    });
                });
            }
        })

    }
    return cmp;
}