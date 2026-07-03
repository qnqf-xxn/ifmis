if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}

if(!Ext.lt.pmkpi.performanceopen){
    Ext.lt.pmkpi.performanceopen = {};
}

Ext.lt.pmkpi.performanceopen.reportservice = function(config, service) {
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _viewtype = config.viewtype,
        _agencys = config.agencys,
        _leftdatas = config.leftdatas,
        _deldatas = [],
        _tablecode,
        _leftguid = "open",
        _leftcode,
        _superguid,
        _finintorgguid,
        _leftisleaf,
        _leftmenuid,
        _scrWidth = document.body.clientWidth,
        _scrHeight = document.body.clientHeight;
    var _displaycols = [];

    Ext.lt.message.hook("busdatatable", "drawed", function (obj) {
        _tablecode = obj.uiconfig.tablecode;
    });

    $(function (){
        common.initDatatable();
        var _lefttab = lefttree.getActiveTabCfg();
        tabChange(_lefttab);
        Ext.lt.pmkpi.doMapper(_agencys, datatable.getCol("dept_code"));
        lefttree.cfg.trees[0].qtree.selectedNode("open");
    });

    /**
     * 左侧页签切换触发函数.
     */
    tabChange = function (obj) {
        _leftmenuid = obj.leftmenuid;
        lefttree.setRecordset(_leftdatas);
        obj.data = _leftdatas;
        return obj;
    };

    Ext.lt.pmkpi.query = function(){
        if (!_leftcode) {
            return;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.menuid = _leftmenuid;
        params.leftcode = _leftcode;
        params.leftisleaf = _leftisleaf;
        params.leftguid = _leftguid;
        params.superguid = _superguid;
        params.beanid = "pmkpi.performanceopen.NXPerfOpenBOTX";
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
            cmp.add(params);
        });
    }

    /**
     * 新增
     * @param params
     */
    cmp.add = function (params){
        var data = datatable.getRecordset().toArray();
        if (data.length == 0 && _superguid != "00") {
            var rs = Ext.lt.RCP.asyncall(service, "getAddData", params);
            var data = {};
            data = rs;
            data.guid = createUUID().replace(/-/g, '');
            data.agencyguid = _leftcode;
            data.agency_code = _leftcode;
            data.dept_code = _leftcode;
            data.bustype = _superguid;
            data.type = "add";
            data.manage_mof_dep_code = _finintorgguid;
            datatable.getRecordSet().addData(data, 999);
        }
    }

    /**
     * 左侧树点击
     */
    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if (!treeNode) {
            return;
        }
        if (treeNode.superguid == "00" || _superguid != treeNode.superguid) {
            _superguid = treeNode.superguid;
            _leftguid = treeNode.guid;
            cmp.setTableColum();
        } else {
            _superguid = treeNode.superguid;
            _leftguid = treeNode.guid;
        }
        _leftcode = treeNode.code;
        _leftisleaf = treeNode.isleaf;
        _finintorgguid = treeNode.finintorgguid;
        Ext.lt.pmkpi.query();
    });

    /**
     * 保存
     */
    cmp.save = function() {
        if (!datatable.checkAll()) {
            return;
        }
        var datas = datatable.getRecordSet().toArray();
        if (datas.length > 0 || _deldatas.length > 0) {
            var params = {};
            params.datas = datas;
            Ext.lt.RCP.call(serviceid, "save", params, function (rs) {
                if (rs.success) {
                    Ext.lt.pmkpi.query();
                    Ext.lt.ui.alert('保存成功！', function () {
                    });
                }
            }, function (rs) {
                Ext.lt.ui.alert('保存失败：' + rs, function () {
                });
            });
        } else {
            Ext.lt.ui.alert('页面无数据！', function () {
            });
        }
    }

    /**
     * 删除
     * @param obj
     */
    cmp.del = function () {
        var datas = datatable.getSelected();
        if (datas.length == 0) {
            Ext.lt.ui.alert("请选择需要删除的指标！", function () {
            });
            return;
        }
        Ext.lt.ui.confirm("确认要删除选中数据？", {icon: "warn"}, function (ret) {
            if (ret) {
                for (var i=0; i<datas.length;i++) {
                    _deldatas.push(datas[i].guid);
                }
                var params = {};
                params.deldatas = _deldatas;
                params.datas = [];
                Ext.lt.RCP.call(serviceid, "save", params, function (rs) {
                    if (rs.success) {
                        Ext.lt.pmkpi.query();
                        Ext.lt.ui.alert('删除成功！', function () {
                        });
                    }
                }, function (rs) {
                    Ext.lt.ui.alert('删除成功：' + rs, function () {
                    });
                });
            }
        });
    }

    /**
     * 动态配置表格的列.
     *
     * @param data --
     */
    cmp.setTableColum = function(){
        var cols = datatable.getCols(); //获取列表所有列
        cols.push.apply(cols, _displaycols);
        _displaycols = [];
        for (var i = 0, len = cols.length; i < len; i++) {
            var col = cols[i];
            var cfg = eval(col.config);
            if (cfg && !$.isEmptyObject(cfg) && col.alias != "序号") {
                if (cfg.bustype == _leftguid || cfg.bustype == _superguid) {
                    col.display = true;
                    col.isvisiable = 1;
                } else {
                    _displaycols.push(col); //隐藏前暂存至sfagency;
                    col.display = false; //display置为false，隐藏
                    col.isvisiable = 0;
                }
            }
        }
        var page = {};
        page.columns = "*";
        datatable.setPage(page);
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw();
    }

    Ext.lt.message.hook("datatable", 'beforesetcols', function(data){
        var cols = data.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for (var i= 0; i < cols.length; i++) {
            var col = cols[i];
            if (col["colcode"] == "openamt" || col["colcode"] == "openpronum") {
                col.oneditend = function (table, el, l, c, d) {
                    if (d.bustype == 'open') {
                        d.openrate = floatMul(floatDiv(d.openamt, d.bgtamt, 4), 100);
                    } else if (d.bustype == 'self') {
                        d.openrate = floatMul(floatDiv(d.openpronum, d.evaluatedpronum, 4), 100);
                    }
                    if (d.openrate > 100) {
                        d.openrate = 100;
                    }
                }
            }
            if (col["colcode"]=="file") {
                col.style = " text-align:center;";
                col.fn = function(l, c, data, val){
                    var name = "上传附件"
                    var html = '<a title = ' + name + ' style="color:#468ac9;cursor:pointer;">' + name + '</a>';
                    return html;
                }
                col.onclick = function(td, el, l, c, d) {
                    var params = {};
                    params.mainguid = d.guid;
                    params.filetype = "perfopen";
                    params.viewtype = _viewtype;
                    if (isGreyStyle()) {
                        Ext.lt.pmkpi.newfilePanelInit(params,Ext.lt.pmkpi.setFileName);
                    }else{
                        var url = '/pmkpi/file/index.page';
                        url = Ext.lt.pmkpi.genPageUrl(url, params);
                        Ext.lt.ui.openModalWindow(url,_scrWidth * 0.8, _scrHeight * 0.8,"附件管理");
                    }
                };
            }
        }
    });

    /**
     * 列表附件名称显示进行刷新
     * @param filenames
     * @param billguid
     */
    Ext.lt.pmkpi.setFileName = function (filenames, billguid){
        var parent_sel_rows = datatable.getRecordset().query({guid:billguid});
        var parent_sel_obj = parent_sel_rows[0];
        var _sortid = parent_sel_obj._sortid;
        parent_sel_obj["filename"] = filenames;
        datatable.reflash(_sortid);
    }


    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    return cmp;
}