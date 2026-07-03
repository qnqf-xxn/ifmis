if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.protrace){
    Ext.lt.pmkpi.protrace = {};
}

Ext.lt.pmkpi.protrace.depttaskservice = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};

    var _menuid = config.menuid,//菜单id
        _proguid = config.proguid,//项目guid
        _mainguid = config.mainguid,//
        _defquery,//列表查询条件
        _orderby,//排序
        _tablecode;//表名

    $(function (){
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        Ext.lt.pmkpi.query(true);
    })

    Ext.lt.pmkpi.query = function(isquery){
        Ext.lt.ui.loadingShow();
        var params = {};
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        params.proguid = _proguid;
        params.beanid = "pmkpi.perfprotrace.depttask.DeptTaskBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
            setMidSaveHidButtons({hidButtons:"暂存"});
            parent._issavetmp = false;
            if (isquery) {
                parent._isQuery = true;
            }
        });
    }

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
        _tablecode = uiconfig.tablecode;
    });

    return cmp;
}