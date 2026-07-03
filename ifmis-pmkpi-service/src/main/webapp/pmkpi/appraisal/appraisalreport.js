if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}
if (!Ext.lt.pmkpi.appraisalreport) {
    Ext.lt.pmkpi.appraisalreport = {};
}

Ext.lt.pmkpi.appraisalreport = function (config, service) {
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var _viewtype = "",
        _workflow = config.workflow,
        _menuid = config.menuid,
        _finintorgs = config.finintorgs,
        _tabcode = "",
        _tablecode,
        _defquery,
        _orderby,
        _treeid,
        _isleaf,
        _treename,
        _colcode = "",
        _scrWidth = document.body.clientWidth,
        _scrHeight = document.body.clientHeight;
    var cmp = {};
    var _isFirst = true;
    var _delguids = [];
    var _treedata;

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        cmp.query();
        _isFirst = false;
        _treedata = lefttree.qtree.getAllData();
    });

    //页签方法
    cmp.clickTabpage = function (obj) {
        _tabcode = obj.code;
        common.changTooltoolbuttontCode(obj.hidebtns);
        if (!_isFirst) {
            cmp.query();
        }
    }

    /**
     * 查询信息.
     */
    cmp.query = function () {
        if (!_treeid) {
            _treeid = "treeroot";
            _isleaf = "0";
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.querySql = queryform.getQuerySQL();
        params.menuid = _menuid;
        params.workflow = _workflow;
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        params.tabcode = _tabcode;
        params.agencyguid = _treeid;
        params.isleaf = _isleaf;
        params.beanid = "pmkpi.appraisal.AppraisalReportBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params, function () {
            Ext.lt.ui.loadingClose();
        });
    }

    cmp.save = function (obj, upload, data) {
        var datas;
        if (data && data.length > 0) {//上传附件时，保存单个
            datas = data;
        } else {
            datas = datatable.getRecordSet().toArray();
        }
        if (!datas || datas.length == 0) {
            return true;
        }
        var params = {};
        params.datas = datas;
        params.workflow = _workflow;
        params.tablecode = _tablecode;
        Ext.lt.ui.loadingShow();
        Ext.lt.RCP.call(service, "save", params, function (rs) {
            Ext.lt.ui.loadingClose();
            if (!upload) {
                Ext.lt.ui.alert(rs.msg, function () {
                    if (rs.success) {
                        cmp.query();
                    }
                });
            } else {
                cmp.query();
            }
        }, function (rs) {
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('保存失败！' + rs, function () {
            });
        });
    }

    /**
     * 表格获取.
     */
    Ext.lt.message.hook("busdatatable", "drawed", function (obj) {
        _tablecode = obj.uiconfig.tablecode;
        _defquery = obj.uiconfig.defquery;
        _orderby = obj.uiconfig.orderby;
    });

    Ext.lt.message.hook("queryform", "doquery", function (obj) {
        cmp.query();
    });

    Ext.lt.message.hook("datatable", 'beforesetcols', function (obj) {
        var cols = obj.cols;
        if (!Ext.lt.isArray(cols))
            cols = [cols];
        for (var i = 0; i < cols.length; i++) {
            var col = cols[i];
            if (col["colcode"] && col["colcode"].indexOf("fileguid") != -1) {
                col.style = " text-align:center;";
                col.fn = function(l, c, data, val){
                    var tc = datatable.getCol(c);
                    var name = ""
                    if (!data[tc.colcode] && _tabcode == "waitaudit") {
                        name = "上传附件";
                    } else {
                        name = data[tc.colcode] == undefined ? "" : data[tc.colcode];
                    }
                    var html = '<a title = ' + name + ' style="color:#468ac9;cursor:pointer;">' + name + '</a>';
                    return html;
                }
                col.onclick = function(td, el, l, c, d) {
                    var tc = datatable.getCol(c);
                    _colcode = tc.colcode;
                    var params = {};
                    params.mainguid = d.guid;
                    params.filetype = tc.colcode + "appraisalfile";
                    params.viewtype = _tabcode == "waitaudit" || _tabcode == "back" ? "" : "query";
                    if (isGreyStyle()) {
                        Ext.lt.pmkpi.newfilePanelInit(params);
                    }else{
                        var url = '/pmkpi/file/index.page';
                        url = Ext.lt.pmkpi.genPageUrl(url, params);
                        Ext.lt.ui.openModalWindow(url,_scrWidth * 0.8, _scrHeight * 0.8,"附件管理");
                    }
                };
            }

            if (col["colcode"] == "agencyguid") {
                col.fn = function(l, c, data, val){
                    var td = _treedata["PK_" + data.agencyguid];
                    var name = ""
                    if (td) {
                        name = td.guid + "-" + td.name;
                    }
                    return name;
                }
            }
        }
    });

    /**
     * 点击左侧树.
     */
    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if(treeNode){
            _treeid = treeNode.guid;
            _treename = treeNode.name;
            _isleaf = treeNode.isleaf;
        } else {
            _treeid = "treeroot";
            _isleaf = "0";
        }
        cmp.query();
    });

    /**
     * 新增
     */
    cmp.add = function () {
        if (!_treeid || _treeid == "treeroot") {
            alert("请选择左侧部门进行新增操作！");
            return;
        }
        var params = {};
        params.agencyguid = _treeid;
        params.tablecode = _tablecode;
        //校验部门是否已填报数据后在新增
        Ext.lt.RCP.call(service, "getDataByAgencyCode", params, function (datas) {
            Ext.lt.ui.loadingClose();
            if (Object.keys(datas).length > 0) {
                alert("部门已存在数据，不能进行新增操作！");
                return;
            }
            var newdata ={};
            newdata.guid = createUUID().replace(/-/g, '');
            newdata.rowtype = "add";
            newdata.agencyguid = _treeid;
            newdata.finintorgguid = _finintorgs[_treeid];
            datatable.getRecordSet().addData(newdata,999);
        }, function (rs) {
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('校验失败，请联系管理员！' + rs, function () {
            });
        });

    };

    /**
     * 刪除表格.
     */
    cmp.del = function () {
        var selDatas = datatable.getSelected();
        if (selDatas.size() == 0) {
            alert("请选择要删除的数据！");
            return;
        }
        Ext.lt.ui.confirm('是否删除已选择数据？',null,function(is){
            if(is){
                for(var i=0; i<selDatas.length; i++){
                    _delguids.push(selDatas[i].guid);
                }
                datatable.removeData(selDatas);
                var params = {};
                params.delguids = _delguids;
                params.tablecode = _tablecode;
                Ext.lt.ui.loadingShow();
                var rs = Ext.lt.RCP.asyncall(service, "del", params);
                if (rs.flg == "1") {
                    alert("删除成功！");
                } else {
                    alert("删除失败！");
                }
                Ext.lt.ui.loadingClose();
            }
        })
    };

    //送审/审核
    cmp.wfAudit = function (obj) {
        var seldatas = datatable.getSelected();
        if (seldatas.length == 0) {
            Ext.lt.ui.alert("请选择要" + obj.name + "的数据！", function () {
            });
            return;
        }
        var params = {};
        params.datas = seldatas;
        params.workflow = _workflow;
        params.tablecode = _tablecode;
        params.busguid = _menuid + "_" + seldatas[0]["wfstatus"];
        // 校验页签参数
        common.doAction(obj, params);
    }

    Ext.lt.message.hook("perfcommon", "auditquery", function () {
        cmp.query();
        Ext.lt.ui.loadingClose();
    });

    //送审情况
    cmp.queryaudit = function () {
        common.auditquery(datatable);
    }

    /**
     * 列表附件名称显示进行刷新
     * @param filenames
     * @param billguid
     */
    Ext.lt.pmkpi.setFileName = function (filenames, billguid){
        var parent_sel_rows = datatable.getRecordset().query({guid:billguid});
        var parent_sel_obj = parent_sel_rows[0];
        //文件无修改，不处理
        if ((filenames != "" && parent_sel_obj[_colcode] != filenames) || (parent_sel_obj[_colcode] && filenames == "")) {
            var _sortid = parent_sel_obj._sortid;
            parent_sel_obj[_colcode] = filenames;
            datatable.reflash(_sortid);
            cmp.save(null, true, parent_sel_rows);
        }
    }

    return cmp;
}