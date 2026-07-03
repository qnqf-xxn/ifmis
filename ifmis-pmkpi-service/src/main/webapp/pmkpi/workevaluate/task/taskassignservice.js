if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.workevaluate){
    Ext.lt.pmkpi.workevaluate = {};
}
Ext.lt.pmkpi.workevaluate.taskassignservice = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var filter,
        _tabfilter,
        _tablecode,
        _componentid,
        _guid = config.guid,
        _tasktype = config.tasktype,
        _bustype = config.bustype,
        _tabData = config.tabData;

    /**
     * 下达
     */
    cmp.assign = function(){
        var datas = datatable.getSelected();
        if(!datas || datas.length == 0){
            Ext.lt.ui.alert("请选择下达的数据！");
            return
        }
        Ext.lt.ui.confirm('是否下达？',null,function(is){
            if(is){
                var params = {};
                params.datas = datas;
                params.bustype = _bustype;
                params.tasktype = _tasktype;
                params.guid = _guid;
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(service , "assignTask", params, function(rs) {
                    if(rs && rs.success){
                        Ext.lt.ui.alert('下达成功！',function(){
                            Ext.lt.pmkpi.query();
                        });
                    }
                    Ext.lt.ui.loadingClose();
                }, function() {
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('下达失败！',function(){
                    });
                });
            }
        })
    }

    /**
     * 取消下达
     */
    cmp.unassign = function(){
        var datas = datatable.getSelected();
        if(!datas || datas.length == 0){
            Ext.lt.ui.alert("请选择取消下达的数据！");
            return
        }
        Ext.lt.ui.confirm('是否取消下达？',null,function(is){
            if(is){
                var params = {};
                params.datas = datas;
                Ext.lt.ui.loadingShow();
                Ext.lt.RCP.call(service , "unassignTask", params, function(rs) {
                    if(rs && rs.success){
                        Ext.lt.ui.alert('取消下达成功！',function(){
                            Ext.lt.pmkpi.query();
                        });
                    }
                    Ext.lt.ui.loadingClose();
                }, function() {
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('取消下达失败！',function(){
                    });
                });
            }
        })
    }

    /**
     * 关闭页面
     */
    cmp.close = function () {
        Ext.lt.ui.closeModalWindow();
    }

    Ext.lt.pmkpi.query = function(){
        var params = {};
        params.tabfilter = _tabfilter;
        params.guid = _guid;
        params.bustype = _bustype;
        params.tasktype = _tasktype;
        params.tablecode = _tablecode;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(service , "getDatas", params, function(rs) {
            if(rs && rs.success){
                datatable.setDatas(rs.data);
            }
            Ext.lt.ui.loadingClose();
        }, function() {
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }
    /**
     * 页签方法
     */
    cmp.clickTabpage = function(obj){
        var config = eval('(' + obj.config + ')');
        changToolbuttonStatus(toolbutton, parseInt(obj.ordernum), obj.hidebtns);
        _tabfilter = obj.filter;
        _tablecode = config.tablecode;
        Ext.lt.pmkpi.query();
    }

    return cmp;
}