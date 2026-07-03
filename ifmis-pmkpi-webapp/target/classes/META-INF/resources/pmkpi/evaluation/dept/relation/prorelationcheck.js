if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}

if (!Ext.lt.pmkpi.deptevaluation) {
    Ext.lt.pmkpi.deptevaluation = {};
}

Ext.lt.pmkpi.deptevaluation.prorelationcheck = function (config, service) {
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var serviceid = service,
        _workflow = config.workflow,//工作流guid
        _leftmenuid = config.leftmenuid,//隐藏菜单
        _mainguid = config.mainguid,
        _prolev = config.prolev,//项目级次
        _treeid,
        _isleaf,
        _orderby,
        _defquery,//表配置过滤条件
        _saveAgency = config.saveAgency,//单位
        _menuid = config.menuid,//菜单
        _bustype = config.bustype,//业务类型，项目/部门/政策
        _tablecode,//查询表名
        _wheresql,//项目过滤条件
        _tablesql   //表过滤条件
    ;
    window.parent.Ext.lt.pmkpi.childwindow = window;

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        cmp.query();
    })

    cmp.query = function () {
        if (!_treeid) {
            _treeid = "treeroot";
            _isleaf = 0;
        }
        var params = {};
        params.saveAgency = _saveAgency;
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.defquery = _defquery;
        params.tablesql = _tablesql;
        params.leftmenuid = _leftmenuid;
        params.prolev = _prolev;
        params.type = "check";
        // params.menuid = _menuid;
        params.leftmenuid = _leftmenuid;
        params.lefttabtype = _bustype;
        params.mainguid = _mainguid;
        params.treeid = _treeid;
        params.isleaf = _isleaf;
        params.orderby = _orderby;
        params.beanid = "pmkpi.dept.relation.ProRelationBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params, function () {
            Ext.lt.ui.loadingClose();
        });
    }

    Ext.lt.message.hook("left", "click", function (obj) {
        var treeNode = obj.node.data;
        if (treeNode) {
            _treeid = treeNode.guid;
            _isleaf = treeNode.isleaf;
        } else {
            _treeid = "treeroot";
            _isleaf = 0;
        }
        cmp.query();
    });

    Ext.lt.message.hook("queryform", "doquery", function (obj) {
        cmp.query();
    });

    Ext.lt.message.hook("datatable", "beforesetcols", function (obj) {
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;   //uitable.defquery
        _orderby = uiconfig.orderby;   //uitable.orderby
        // _wheresql = config.wheresql;      //datatable.config.wheresql
    });

    cmp.save = function () {
        var datas = datatable.getSelected();
        if (!datas || datas.length <= 0) {
            Ext.lt.ui.alert('请选择项目！', function () {
            });
            return;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.datas = datas;
        params.saveAgency = _saveAgency;
        params.workflow = _workflow;
        params.tablecode = _tablecode;
        params.bustype = _bustype;
        params.mainguid = _mainguid;
        Ext.lt.RCP.call(service, "saveProRelation", params, function (rs) {
            Ext.lt.ui.alert('确认成功！', function () {
                Ext.lt.ui.closeModalWindow();
                window.parent.Ext.lt.pmkpi.query();
            });
            Ext.lt.ui.loadingClose();
        }, function (rt) {
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('确认失败：' + rt, function () {
            });
        });
    }

    return cmp;
}