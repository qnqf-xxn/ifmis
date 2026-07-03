if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}
if (!Ext.lt.pmkpi.financialevaluation) {
    Ext.lt.pmkpi.financialevaluation = {};
}

Ext.lt.pmkpi.financialevaluation.prorelation = function (config, service) {
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var serviceid = service,
        _leftmenuid = config.leftmenuid,
        _mainguid = config.mainguid,
        _proguid = config.proguid,//关联项目id
        _procode = config.procode,//关联项目code
        _saveAgency = config.saveAgency,
        _viewtype = config.viewtype,
        _tablecode,//表名
        _defquery,//表配置过滤条件
        _orderby,//表排序sql
        _busguid = config.busguid,//审核定义
        _findex,//一级指标
        _uikey,
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;
    var cmp = {};

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        if (_viewtype == "query") {
            common.changTooltoolbuttontStatus(0, "选择关联项目,取消关联");
        }
        Ext.lt.pmkpi.query();
    })

    Ext.lt.pmkpi.query = function () {
        var params = {};
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.tablecode = _tablecode;
        params.mainguid = _mainguid;
        params.proguid = _proguid;
        params.procode = _procode;
        params.beanid = "pmkpi.financial.relation.ProRelationBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params, function () {
            Ext.lt.ui.loadingClose();
        });
    }

    /**
     *
     */
    Ext.lt.message.hook("busdatatable", "drawed", function (obj) {
        var config = obj.config;
        _tablecode = obj.uiconfig.tablecode;
        _defquery = obj.uiconfig.defquery;
        _orderby = obj.uiconfig.orderby;
        _uikey = config.uikey;
        _findex = config.findex;
    });

    Ext.lt.message.hook("datatable", 'beforesetcols', function (obj) {
        var cols = obj.cols;
        if (!Ext.lt.isArray(cols))
            cols = [cols];
        for (var i = 0; i < cols.length; i++) {
            var col = cols[i];
            if (_viewtype == 'query' && col["name"] != "check") {
                col.style = "background-color:#f2f2f2;";
                col.oneditstart = function (table, e, l, c, d) {
                    return false;
                }
            }
        }
    });
    Ext.lt.message.hook("queryform", "doquery", function (obj) {
        Ext.lt.pmkpi.query();
    });

    /**
     * 删除
     */
    cmp.del = function () {
        var datas = datatable.getSelected();
        if (!datas || datas.length <= 0) {
            Ext.lt.ui.alert("请选择要删除的数据！", function () {
            });
            return;
        }
        Ext.lt.ui.confirm('是否删除已选择数据？', null, function (is) {
            if (is) {
                var params = {};
                params.datas = datas;
                Ext.lt.RCP.call(service, "del", params, function (rs) {
                    if (rs.flg == "1") {
                        Ext.lt.ui.alert('删除成功！', function () {
                            Ext.lt.pmkpi.query();
                        });
                    }
                }, function () {
                    Ext.lt.ui.alert('删除失败！', function () {
                    });
                });
            }
        })
    }

    /**
     * 选择项目
     */
    cmp.checkprogram = function () {
        var params = {};
        // params.workflow = _workflow;
        // params.prolev = _prolev;
        // params.saveAgency = _saveAgency;
        // params.leftmenuid = _leftmenuid;
        // params.bustype = _lefttabtype;
        params.mainguid = _mainguid;
        params.leftmenuid = _leftmenuid;
        var url = "/pmkpi/evaluation/finconfirm/prorelation/procheck.page";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth - 200, scrHeight - 50, "选择关联项目");
    }

    return cmp;
}

