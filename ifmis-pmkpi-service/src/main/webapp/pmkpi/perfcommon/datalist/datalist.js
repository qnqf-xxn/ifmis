if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}

if(!Ext.lt.pmkpi.tabfreamlist){
    Ext.lt.pmkpi.tabfreamlist = {};
}

Ext.lt.pmkpi.perfdatalist = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var
        _tablecode,//表名
        _defquery,//表配置过滤条件
        _querycols,//查询条件字段
        _treesource = config.treesource//左侧树数据源类型,部门/单位
    ;

    $(function (){
        common.initDatatable();
        cmp.query();
    });

    cmp.query = function (){
        Ext.lt.ui.loadingShow();
        var params = {};
        if (typeof (queryform) != 'undefined') {
            params.queryConfig = queryform.getQueryParam();
            params.querySql = queryform.getQuerySQL();
        }
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        params.querycols = _querycols;
        var tst = Object.keys(config);
        for(var j = 0,len=tst.length; j < len; j++) {
            var vualue = config[tst[j]];
            if (isString(vualue) || isNumber((vualue))) {
                params[tst[j]] = vualue;
            }
        }
        params.treesource = _treesource;
        params.beanid = "pmkpi.datalist.PerfDataListBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }

    Ext.lt.message.hook("datatable", "drawed",function(obj){
        var uiconfig = obj.uiconfig;
        //表配置
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
        var tableconfig = eval('(' + uiconfig.config + ')');
        _querycols = tableconfig.querycols;
    });

    Ext.lt.message.hook("queryform", "doquery", function (obj) {
        cmp.query();
    });

    return cmp;
}

