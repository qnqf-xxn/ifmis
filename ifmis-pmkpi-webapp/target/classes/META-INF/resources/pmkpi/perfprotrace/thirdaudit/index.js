if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}
if (!Ext.lt.pmkpi.index) {
    Ext.lt.pmkpi.index = {};
}
Ext.lt.pmkpi.index = function (config, service) {
    var commcmp = Ext.lt.pmkpi.perfcommon(config, serviceid);
    var  _tablecode,//表名
        _defquery,//表配置过滤条件
        _orderby,//表排序sql
        _mainguid = config.mainguid,
        _procode = config.procode;

    var serviceid = service;
    var cmp = {};

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        commcmp.initDatatable();
        cmp.query();
    })

    /**
     * 表格获取.
     */
    Ext.lt.message.hook("busdatatable", "drawed", function (obj) {
        var config = obj.config;
        _tablecode = obj.uiconfig.tablecode;
        _defquery = obj.uiconfig.defquery;
        _orderby = obj.uiconfig.orderby;
    });
    /**
     * 查询信息.
     */
    cmp.query = function () {
        var params = {};
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.tablecode = _tablecode;
        params.pro_code = _procode; //项目code
        params.mainguid = _mainguid;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(serviceid, "getDatas", params, function (rs) {
            datatable.setDatas(rs.data);
            Ext.lt.ui.loadingClose();
        }, function () {
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('查询失败！', function () {
            });
        });
    }



    Ext.lt.message.hook("datatable", 'beforesetcols', function (obj) {
        var cols = obj.cols;
        if (!Ext.lt.isArray(cols))
            cols = [cols];
        var upcols = [];
        var oldvalue;
        for (var i = 0; i < cols.length; i++) {
            var col = cols[i];
        }
    });

    return cmp;
}