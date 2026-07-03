if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}

Ext.lt.pmkpi.deptTJtofinintorg = function(config, service){
    var commoncmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var serviceid = service;
    var _mainguid = config.mainguid,
        _tabfilter, //页签过滤条件
        _tabcode, //页签
        _defquery, //表格过滤条件
        _orderby; //排序;

    $(function(){
        commoncmp.initDatatable();
        Ext.lt.pmkpi.query();
    });

    //查询
    cmp.query = function (obj){
        Ext.lt.pmkpi.query();
    }

    Ext.lt.pmkpi.query = function(){
        Ext.lt.ui.loadingShow();
        var params = {};
        params.tabfilter = _tabfilter;
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.tabcode = _tabcode;
        params.mainguid = _mainguid;
        params.beanid = "pmkpi.deptTJformance.DeptTJPerftofinintorgBO";
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }

    /**
     * 确认分发/取消分发
     */
    cmp.tofinintorg = function (obj){
        var datas = datatable.getSelected();
        if(datas.length == 0){
        	Ext.lt.ui.alert("请选择要"+obj.name+"的数据！",function(){});
            return;
        }
        Ext.lt.ui.confirm(obj.name+"？",{icon:"warn"},function(ret){
            if(ret){
                Ext.lt.ui.loadingShow();
                var params = {};
                params.mainguid =_mainguid;
                params.seldatas = datas;
                params.actioncode = obj.code;
                Ext.lt.RCP.call(serviceid, "tofinintorg", params, function (rs) {
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('操作成功！', function () {
                        Ext.lt.pmkpi.query();
                    });
                }, function () {
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('操作失败！', function () {
                    });
                });
            }
        });
    }

    //页签方法
    cmp.clickTabpage = function(obj){
        changToolbuttonStatus(toolbutton, parseInt(obj.ordernum), obj.hidebtns);
        _tabfilter = obj.filter;
        _tabcode = obj.code;
        Ext.lt.pmkpi.query();
    }

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
    });

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    return cmp;
}

