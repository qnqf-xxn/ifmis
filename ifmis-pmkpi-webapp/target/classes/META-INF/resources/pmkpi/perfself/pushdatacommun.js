if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}

Ext.lt.pmkpi.perfselfqueryservice = function (config, service) {
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var
        _menuid = config.menuid,
        _agency,
        _tablecode,
        _queryConfig, //查询区配置
        _querySql, //查询区条件
        _tabfilter,
        _isfirst = false;

    //查询
    cmp.query = function () {
        //获取选中的左侧树code
        if (!_agency) {
            _agency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.agency = _agency;
        params.isleaf = Ext.lt.pmkpi.isleaf + "";
        params.menuid = _menuid;
        params.querySql = _querySql;
        params.tablecode = _tablecode;
        params.tabfilter = _tabfilter;
        params.beanid = "pmkpi.perfself.PushDataCommunBOTX";
        datatable.queryData(params, function () {
            Ext.lt.ui.loadingClose();
        });
    }

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        cmp.setTableColum();
        Ext.lt.pmkpi.querytree();
        cmp.query();
        _isfirst = true;
    })

    //页签方法
    cmp.clickTabpage = function (obj) {
        _tabfilter = obj.filter;
        common.changTooltoolbuttontCode(obj.hidebtns);
        if (_isfirst) {
            cmp.query();
        }
    }

    Ext.lt.pmkpi.querytree = function () {
        var params = {};
        params.menuid = _menuid;
        params.tablecode = _tablecode;
        var datalist = Ext.lt.RCP.asyncall(service, "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
        return datalist;
    }

    cmp.add = function () {
        var datas = datatable.getSelected();
        if (!datas || datas.length == 0) {
            Ext.lt.ui.alert('请选择要推送的数据！',function(){
            });
            return;
        }
        Ext.lt.ui.confirm('是否推送选择的数据？',{icon: "warn"},function(is){
            if(is){
                Ext.lt.ui.loadingShow();
                var params = {};
                params.datas = datas;
                Ext.lt.RCP.call(service , "add", params, function(rs){
                    if (rs.success) {
                        Ext.lt.ui.alert('推送成功！',function(){
                            cmp.query();
                        });
                    } else {
                        Ext.lt.ui.alert('推送失败，请联系管理员！',function(){
                        });
                    }
                    Ext.lt.ui.loadingClose();
                },function(rs){
                    Ext.lt.ui.loadingClose();
                    Ext.lt.ui.alert('推送失败，原因：' + rs,function(){
                    });
                });
            }
        })
    }

    /**
     * 动态配置表格的列.
     *
     * @param data --
     */
    cmp.setTableColum = function () {
        var page = {};
        page.columns = "*";
        datatable.setPage(page);
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw(); //从新绘制表格
    }

    Ext.lt.message.hook("left", "click", function (obj) {
        var treeNode = obj.node.data;
        if (treeNode) {
            _agency = treeNode.guid;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _agency = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
        }
        cmp.query();
    });

    Ext.lt.message.hook("queryform", "doquery", function (obj) {
        _queryConfig = queryform.getQueryParam();
        _querySql = queryform.getQuerySQL();
        cmp.query();
    });

    Ext.lt.message.hook("perfcommon", "auditquery", function () {
        cmp.query();
    });

    Ext.lt.message.hook("datatable", "beforesetcols", function (obj) {
        var uiconfig = obj.table.uiconfig;
        _tablecode = uiconfig.tablecode;
        var cols = obj.cols;
        if (!Ext.lt.isArray(cols))
            cols = [cols];
        for (var i = 0; i < cols.length; i++) {
            var col = cols[i];
            if (col["colcode"] == "warn") { //目标值构建符号和单位
                col.cseditfn = function (i, j, rs, style) { //列的单元格样式.
                    style = 'style="text-align:center;"';
                    return style;
                }
                col.fn = function (l, c, data, val) {
                    var warn = !data.warn ? "" : data.warn;
                    if (warn == "red") {
                        warn = '3';
                    } else if (warn == "yellow") {
                        warn = '1';
                    } else if (warn == "green") {
                        warn = '0';
                    } else if (warn == "blue") {
                        warn = '4';
                    } else {
                        return "";
                    }
                    return '<img id="image" style="vertical-align:middle;margin-top:9px;" src="/pmkpi/themes/images/' + warn + '.gif"/>';
                }
            }
        }
    });


    return cmp;
}
