if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}
if (!Ext.lt.pmkpi.perfprotrace) {
    Ext.lt.pmkpi.perfprotrace = {};
}

Ext.lt.pmkpi.perfprotrace.keytasksendservice = function (config, service) {
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _menuid = config.menuid,//菜单id
        _pagetype = config.pagetype,//菜单类型，部门、财政
        _taskguid = config.taskguid,//任务guid
        _tasktype = config.tasktype,//任务类型，项目/部门/政策
        _wheresql, //配置查询条件
        _tablecode,
        _tabfilter,//页签查询条件
        _tabcode,//页签编码
        _prolev = config.prolev,
        _defquery,
        _orderby,
        _uikey,
        _treeid,
        _isleaf,
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;

    var serviceid = service;
    var isfirst = true;

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        if (isfirst) {
            isfirst = false;
        }
        Ext.lt.pmkpi.query();
    })

    //查询
    cmp.query = function (obj) {
        Ext.lt.pmkpi.query();
    }

    Ext.lt.pmkpi.query = function () {
        if (!_treeid) {
            _treeid = "treeroot";
            _isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.treeid = _treeid;
        params.isleaf = _isleaf + "";
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        params.menuid = _menuid;
        params.tabcode = _tabcode;
        params.pagetype = _pagetype;
        params.taskguid = _taskguid;
        params.prolev = _prolev;
        params.tasktype = _tasktype;
        params.wheresql = _wheresql;
        params.beanid = "pmkpi.perfprotrace.deptsend.DeptKeyTaskSendBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params, function () {
            Ext.lt.ui.loadingClose();
        });
    }

    //页签方法
    cmp.clickTabpage = function (obj) {
        changToolbuttonStatus(toolbutton, parseInt(obj.ordernum), obj.hidebtns);
        _tabfilter = obj.filter;
        _tabcode = obj.code;
        if (!isfirst) {
            Ext.lt.pmkpi.query();
        }
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

    Ext.lt.message.hook("perfcommon", "tablequery", function () {
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("queryform", "doquery", function (obj) {
        cmp.query();
    });

    Ext.lt.message.hook("datatable", "beforesetcols", function (obj) {
        var uiconfig = obj.table.uiconfig;
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
    });

    /**
     * 下达任务
     */
    cmp.sendtask = function () {
        var datas = datatable.getSelected();
        if (!datas.length || datas.length <= 0) {
            Ext.lt.ui.alert("请选择要下达的项目！", function () {
            });
            return;
        }
        Ext.lt.ui.confirm('是否下达任务？', {icon: "warn"}, function (is) {
            if (is) {
                var params = {};
                params.pagetype = _pagetype;
                params.datas = datas;
                params.taskguid = _taskguid;
                params.tabcode = _tabcode;
                params.tasktype = _tasktype;
                params.provincetask = 1;
                Ext.lt.RCP.call(service, "sendtask", params, function (rs) {
                    if (rs && rs.flg == "1") {
                        Ext.lt.ui.alert('下达成功！', function () {
                            Ext.lt.pmkpi.query();
                        });
                    }
                }, function () {
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('下达失败！', function () {
                    });
                });
            }
        })
    }

    /**
     * 取消下达
     */
    cmp.cencelsend = function () {
        var datas = datatable.getSelected();
        if (!datas.length || datas.length <= 0) {
            Ext.lt.ui.alert("请选择要取消下达的项目！", function () {
            });
            return;
        }
        var params = {};
        params.selDatas = datas;
        Ext.lt.ui.confirm('是否取消下达？', {icon: "warn"}, function (is) {
            if (is) {
                var params = {};
                params.pagetype = _pagetype;
                params.datas = datas;
                params.taskguid = _taskguid;
                params.tabcode = _tabcode;
                params.tasktype = _tasktype;
                params.provincetask = 3;
                Ext.lt.RCP.call(service, "sendtask", params, function (rs) {
                    if (rs && rs.flg == "1") {
                        Ext.lt.ui.alert('取消成功！', function () {
                            Ext.lt.pmkpi.query();
                        });
                    }
                }, function () {
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('取消失败！', function () {
                    });
                });
            }
        })
    }

    /**
     * 查看明细
     */
    cmp.detailed = function () {
        var data = datatable.getSelected();
        if (!data || data.length != 1) {
            Ext.lt.ui.alert("请选中一条数据进行查看！", function () {
            });
            return;
        }
        var url = "/pmkpi/program/trace/report/edit.page";
        var params = {};
        params.saveAgency = data[0].agencyguid;
        params.taskguid = data[0].taskguid;//监控任务guid
        params.prolev = _prolev;
        params.bustype = "program";
        params.mainguid = data[0].moniguid;
        params.agency = data[0].agencyguid;
        params.viewtype = "query";
        params.projguid = data[0].proguid;
        params.procode = data[0].pro_code;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "部门重点监控下发");
    }

    /**
     * 查看项目
     */
    cmp.showProjView = function (obj) {
        var params = {};
        var data = datatable.getSelected();
        params.proguid = data[0].projguid;
        var xmxxEditobject = Ext.lt.RCP.asynserver("pmkpi.doubleprocess.TlpJxAuditService", "getProInfo", params);
        params.submenu = _menuid;
        params.pro_code = data[0].pro_code;
        var pro_lev = xmxxEditobject[0].pro_lev;
        if (pro_lev && pro_lev == "2") {
            common.proinfoview(datatable, params);
        } else {
            params.vchtypeid = xmxxEditobject[0].vchtypeid;
            params.projectkind = xmxxEditobject[0].projectkind;
            common.queryPromain(datatable, params);
        }
    }

    return cmp;
}