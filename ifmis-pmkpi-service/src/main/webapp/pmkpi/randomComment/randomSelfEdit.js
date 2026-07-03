if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.randomSelfEdit){
    Ext.lt.pmkpi.randomSelfEdit = {};
}
var serviceid;
var _mainguid;
Ext.lt.pmkpi.randomSelfEdit = function(config, service){
    var commoncmp = Ext.lt.pmkpi.perfcommon(config, service);
    var
        _saveAgency = config.saveAgency,
        _viewtype = config.viewtype,
        _tabcode,
        _tablecode,//表名
        _defquery,//表配置过滤条件
        _orderby,//表排序sql
        _busguid,//审核定义
        _modelguid//指标模板guid
    ;
    var cmp = {};
    serviceid = service;
    _mainguid = config.mainguid;
    _projguid = config.projguid;
    _scrWidth =document.body.clientWidth;
    _scrHeight =document.body.clientHeight;
    /**
     *
     */
    Ext.lt.message.hook("busdatatable", "drawed",function (obj) {
        var config = obj.config;
        _tablecode = obj.uiconfig.tablecode;
        _defquery = obj.uiconfig.defquery;
        _orderby = obj.uiconfig.orderby;
        //审核定义guid，perf_t_busauditdefine表budguid
        _busguid = config.busguid;
        _modelguid = config.modelguid;
    });

    cmp.query = function(){
        var params = {};
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.tabcode = _tabcode;
        params.tablecode = _tablecode;
        params.mainguid = _mainguid;
        params.projguid = _projguid;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
            datatable.setDatas(rs.data);
            setTimeout(function(){
                amtTotal(datatable);
            },100);
            Ext.lt.ui.loadingClose();
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }

    cmp.save = function(){
        if (!datatable.checkAll()) return false;//先校验
        var params = {};
        params.datas = datatable.getRecordSet().toArray();
        params.updatas = datatable.getUpdataData();
        params.deldatas = datatable.getRemoveData();
        params.tablecode = _tablecode;
        params.busguid = _busguid;
        var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
        cmp.query();
        return rs;
    }

    $(function () {
        debugger
        commoncmp.initDatatable();
        cmp.query();
    })
    
	
    Ext.lt.message.hook("datatable", 'beforesetcols',function(obj){
        var cols = obj.cols;
        var config = obj.table.config;
        var uiconfig = obj.table.uiconfig;
        _tabcode = config.tabcode;
        _tablecode = uiconfig.tablecode;
    });

    return cmp;
}