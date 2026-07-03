if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}
if (!Ext.lt.pmkpi.proseo) {
    Ext.lt.pmkpi.proseo = {};
}

Ext.lt.pmkpi.proseo.index = function (config, service) {
    var cmp = {};
    var commoncmp = Ext.lt.pmkpi.perfcommon(config, service);
    var _menuid = config.menuid,
        _type = config.type,  // 1-事前绩效评估查询；2-项目绩效目标查询
        _agency,
        _tablecode,
        _tabfilter,
        _tabcode,
        _name,
        _defquery,
        _wheresql,
        _orderby,
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;

    $(function () {
        var page = {};
        page.columns = "*";
        datatable.setPage(page);
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw();
        cmp.query();
    })

    //查询
    cmp.query = function () {
        commoncmp.initDatatable();
        Ext.lt.pmkpi.query();
    }

    Ext.lt.pmkpi.query = function () {
        if (!_agency) {
            _agency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.agency = _agency;
        params.isleaf = Ext.lt.pmkpi.isleaf + "";
        params.menuid = _menuid;
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        params.pagetype = "report";
        params.tabfilter = _tabfilter;
        params.tabcode = _tabcode;
        params.menuid = _menuid;
        params.orderby = _orderby;
        params.beanid = "pmkpi.allseo.ProSeoBOTX";
        params.type = _type;
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params, function () {
            Ext.lt.ui.loadingClose();
        });
    }

    /**
     * 查询区查询
     */
    Ext.lt.message.hook("queryform", "doquery",function(obj){
        cmp.query();
    });

    /**
     * 左侧树
     */
    Ext.lt.message.hook("left", "click", function (obj) {
        var treeNode = obj.node.data;
        if (treeNode) {
            _agency = treeNode.guid;
            _name = treeNode.name;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _agency = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
        }
        cmp.query();
    });

    /**
     * 表格
     */
    Ext.lt.message.hook("datatable", "beforesetcols", function (obj) {
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
        _wheresql = config.wheresql;
    });

    /**
     * 查看项目全过程详情
     */
    cmp.allinfo = function(){
        var data = datatable.getSelected();
        if(data.size()==1){
            var params = {};
            params.pro_code = data[0].pro_code;
            params.proguid = data[0].guid;
            var url = "/pmkpi/allseo/project/allinfo.page";
            url = Ext.lt.pmkpi.genPageUrl(url, params);
            Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"项目绩效全信息");
        } else if(data.size() > 1) {
            Ext.lt.ui.alert('每次只能查看一条项目！',function(){});
        } else {
            Ext.lt.ui.alert('请选择要查看的项目！',function(){});
        }
    }

    return cmp;
}