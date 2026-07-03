if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.casemarkedindi){
    Ext.lt.pmkpi.casemarkedindi = {};
}
Ext.lt.pmkpi.casemarkedindi.casemarkedindiprolist = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};

    var _menuid = config.menuid,//菜单id
        _tablecode,
        _indi_code = config.indi_code,
        _queryYear = config.queryYear,
        _defquery;//列表查询条件
    var _scrHeight = Math.floor(document.documentElement.clientHeight * 0.95);
    var _scrWidth =  Math.floor(document.documentElement.clientWidth * 0.95);

    $(function (){
        common.initDatatable();
        Ext.lt.pmkpi.query();
    })

    /**
     * 查询
     */
    Ext.lt.pmkpi.query = function(){
        Ext.lt.ui.loadingShow();
        var params = {};
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        params.menuid = _menuid;
        params.indi_code = _indi_code;
        params.queryYear = _queryYear;
        params.type = "prolist";
        params.beanid = "pmkpi.casemarkedindi.CasemarkedIndiBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }

    /**
     * 查看项目年度绩效详情
     */
    cmp.queryPerfView = function (data){
        var url = "/pmkpi/yearprogram/query/edit.page";
        var params = {};
        params.mainguid = data.guid;
        params.agency = data.agency_code;
        params.pro_code = data.pro_code;
        params.projectkind = data.projectkind;//项目类型
        params.viewtype = "query";
        //跨年度区划查询参数
        params.queryYear = _queryYear;
        params.queryProvince = data.mof_div_code;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, _scrWidth, _scrHeight, "项目绩效目标查看");
    }

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        //表配置
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
        var cols = obj.cols;
        if (!Ext.lt.isArray(cols))
            cols = [cols];
        for (var i = 0; i < cols.length; i++) {
            var col = cols[i];
            if (col["colcode"] == "pro_codename") {
                col.style = " text-align:center;";
                col.fn = function(l, c, data, val){
                    var html = '<a title = ' + val + ' style="color:#468ac9;cursor:pointer;">' + val + '</a>';
                    return html;
                }
                col.onclick = function(td, el, l, c, d) {
                    cmp.queryPerfView(d);
                };
            }
        }
    });

    return cmp;
}