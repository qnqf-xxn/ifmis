if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}

Ext.lt.pmkpi.deptTJseltask = function(config, service){
    var commoncmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _mainguid = config.mainguid,
        _goalguid = config.goalguid;

    //查询
    cmp.query = function (obj){
        Ext.lt.pmkpi.query();
    }

    Ext.lt.pmkpi.query = function(){
        var _tasklist = parent.taskdatatable.getRecordset().query({isedit:"true"});
        datatable.setDatas(_tasklist);
    }

    $(function(){
        Ext.lt.pmkpi.query();
    });

    /**
     * 修改
     */
    cmp.save = function (obj){
        var data = datatable.getSelected();
        if(data.length == 0){
        	Ext.lt.ui.alert("请选择要关联的项目数据！",function(){});
            return;
        }
        var parent_sel_rows = parent.perfgoaldatatable.getRecordset().query({guid:_goalguid});
        var parent_sel_obj = parent_sel_rows[0];
        var _sortid = parent_sel_obj._sortid;
        if(parent_sel_obj.task_context!=null && parent_sel_obj.task_context!=""){
            Ext.lt.ui.confirm("该目标已关联任务，确认是否替换？",{icon:"warn"},function(ret){
                if(ret){
                    Ext.lt.ui.confirm("确认关联该任务？",{icon:"warn"},function(ret){
                        if(ret){
                            parent_sel_obj.taskguid = data[0].guid;
                            parent_sel_obj.task_context = data[0].context;
                            parent.perfgoaldatatable.reflash(_sortid);
                            Ext.lt.ui.closeModalWindow();
                        }
                    });
                }
            });
        }else{
            Ext.lt.ui.confirm("确认关联该任务？",{icon:"warn"},function(ret){
                if(ret){
                    parent_sel_obj.taskguid = data[0].guid;
                    parent_sel_obj.task_context = data[0].context;
                    parent.perfgoaldatatable.reflash(_sortid);
                    Ext.lt.ui.closeModalWindow();
                }
            });
        }
    }

    return cmp;
}

