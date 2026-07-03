if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.workevaluate){
    Ext.lt.pmkpi.workevaluate = {};
}
Ext.lt.pmkpi.workevaluate.taskservice = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _tablecode,
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;

    $(function () {
        common.initDatatable();
        Ext.lt.pmkpi.query();
    })

    /**
     * 查询
     */
    Ext.lt.pmkpi.query = function(){
        Ext.lt.ui.loadingShow();
        var params = {};
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.beanid = "pmkpi.workevaluate.task.WorkEvaluateTaskBO";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }
    /**
     * 新增任务
     */
    cmp.add = function(){
        var newguid = Ext.lt.RCP.asyncall(service , "getGuid", null);
        var params = {};
        params.guid = newguid;
        params.mainguid = newguid;
        params.viewtype = 'add';
        var url = '/pmkpi/workevaluate/task/edit.page';
        url = Ext.lt.pmkpi.genPageUrl(url,params);
        Ext.lt.ui.openModalWindow(url, scrWidth*0.95, scrHeight*0.95, "绩效管理工作考核任务")
    }

    /**
     * 修改任务
     */
    cmp.mod = function(){
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据！");
            return
        }
        var params = {};
        params.guid = data[0].guid;
        params.viewtype = 'mod';
        params.mainguid = data[0].guid;
        params.bustype = data[0].bustype;
        params.year = data[0].year;
        params.province = data[0].province;
        var url = '/pmkpi/workevaluate/task/edit.page';
        url = Ext.lt.pmkpi.genPageUrl(url,params);
        Ext.lt.ui.openModalWindow(url, scrWidth*0.95, scrHeight*0.95, "绩效管理工作考核任务")
    }

    /**
     * 删除任务
     */
    cmp.del = function(){
        var data = datatable.getSelected();
        if(!data || data.length == 0){
            Ext.lt.ui.alert("请选中数据！");
            return
        }
        Ext.lt.ui.confirm('是否删除已选择数据？',null,function(is){
            if(is){
                var params = {};
                params.datas = data;
                params.tablecode = _tablecode;
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(service , "delTask", params, function(rs) {
                    if(rs && rs.success){
                        Ext.lt.ui.alert('删除成功！',function(){
                            Ext.lt.pmkpi.query();
                        });
                    }else {
                        Ext.lt.ui.alert(rs.code,function(){
                        });
                    }
                    Ext.lt.ui.loadingClose();
                });
            }
        })
    }

    /**
     * 下达任务
     */
    cmp.issued = function(){
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据！");
            return
        }
        var url;
        var bustype = data[0].bustype;
        var params = {};
        params.guid = data[0].guid;
        params.tasktype = data[0].tasktype;
        params.bustype = bustype;
        if(bustype == 'dept'){
            url = '/pmkpi/workevaluate/assign/agencylist.page';
        }else {
            url = '/pmkpi/workevaluate/assign/provincelist.page';
        }
        url = Ext.lt.pmkpi.genPageUrl(url,params);
        Ext.lt.ui.openModalWindow(url, scrWidth*0.75, scrHeight*0.75, "绩效管理工作考核任务下达")
    }

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        _tablecode = uiconfig.tablecode;
    });

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    return cmp;
}