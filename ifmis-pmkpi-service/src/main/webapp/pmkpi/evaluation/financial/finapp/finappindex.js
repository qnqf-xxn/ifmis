if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.finappindex){
    Ext.lt.pmkpi.finappindex = {};
}
var serviceid;
var _mainguid;
Ext.lt.pmkpi.finappindex = function(config, service){
    var commcmp = Ext.lt.pmkpi.perfcommon(config, serviceid);
    var
        _saveAgency = config.saveAgency,
        _bustype = config.bustype,
        _tablecode,//表名
        _defquery,//表配置过滤条件
        _orderby,//表排序sql
        _busguid = config.busguid;
    serviceid = service;
    _mainguid = config.mainguid;

    var cmp = {};
    /**
     * 获取表的查询.
     */
    Ext.lt.message.hook("busdatatable", "drawed",function (obj) {
        var config = obj.config;
        _tablecode = obj.uiconfig.tablecode;
        _defquery = obj.uiconfig.defquery;
        _orderby = obj.uiconfig.orderby;
    });

    cmp.query = function(){
        var params = {};
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.tablecode = _tablecode;
        params.saveAgency = _saveAgency; //单位.
        params.mainguid = _mainguid;
        params.bustype = _bustype;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid , "getDatas", params, function(rs){
            datatable.setDatas(rs.data);
            Ext.lt.ui.loadingClose();
            setTimeout(function(){
                amtTotal(datatable);
            },300);
        },function(){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！',function(){
            });
        });
    }

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
        _tablecode = uiconfig.tablecode;
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
        }
    });

    cmp.save = function(){
        if (!datatable.checkAll()) return false;//先校验
        var params = {};
        params.datas = datatable.getRecordSet().toArray();
        params.updatas = datatable.getUpdataData();
        params.deldatas = datatable.getRemoveData();
        params.tablecode = _tablecode;
        params.busguid = _busguid;
        params.mainguid = _mainguid;
        params.bustype = _bustype;
        var rs = Ext.lt.RCP.asyncall(serviceid , "save", params);
        cmp.query();
        return rs;
    }

    $(function () {
        commcmp.initDatatable();
        cmp.query();
    })

    return cmp;
}