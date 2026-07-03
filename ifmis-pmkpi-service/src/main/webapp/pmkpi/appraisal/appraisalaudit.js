if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}
if (!Ext.lt.pmkpi.appraisalaudit) {
    Ext.lt.pmkpi.appraisalaudit = {};
}

Ext.lt.pmkpi.appraisalaudit = function (config, service) {
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var _workflow = config.workflow,
        _menuid = config.menuid,
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
        params.beanid = "pmkpi.appraisal.AppraisalAuditBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params, function () {
            Ext.lt.ui.loadingClose();
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
                    var name = data[tc.colcode] == undefined ? "" : data[tc.colcode];
                    var html = '<a title = ' + name + ' style="color:#468ac9;cursor:pointer;">' + name + '</a>';
                    return html;
                }
                col.onclick = function(td, el, l, c, d) {
                    var tc = datatable.getCol(c);
                    _colcode = tc.colcode;
                    var params = {};
                    params.mainguid = d.guid;
                    params.filetype = tc.colcode + "appraisalfile";
                    params.viewtype = "query";
                    if (isGreyStyle()) {
                        Ext.lt.pmkpi.newfilePanelInit(params);
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
     * 批量导出指标完成情况及其他附件
     */
    cmp.expfile = function(obj) {
        var buttonconfig = eval('(' + obj.config + ')');
        var datas = datatable.getSelected();
        if(datas.length < 1){
            Ext.lt.ui.alert( "请选择数据进行附件导出！",function(){
            });
            return;
        }
        var list = [];
        var name = ""
        for (var i = 0; i < datas.size(); i++) {
            var params = {};
            params.guid = datas[i].guid;//数据id
            var td = _treedata["PK_" + datas[i].agencyguid];
            if (td) {
                name = td.name;
            }
            params.name = name;//名称
            params.agency = datas[i].agencyguid;//单位
            list.push(params);
        }
        var params = {};
        params.bustype =  "appraisalfile" ; // 文件表类型
        params.fileexptype = "appraisal"; //附件导出类型: 绩效考核
        params.list = list;
        params.tokenid = Ext.lt.token.getTokenid();
        params.zipname = buttonconfig.zipname;
        params.rcp = true;
        Ext.lt.RCPConsole.processdown("pmkpi.perfcommon.fileexp.FileExpService",'indexFileExp&rcpconsole=process&noserveranalyselog=true',params,'downframe');
        setTimeout(common.colspross_function(1),1000);
    }

    return cmp;
}