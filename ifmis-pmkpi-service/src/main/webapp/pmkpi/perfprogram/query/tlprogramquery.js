if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}
if (!Ext.lt.pmkpi.perfprogram) {
    Ext.lt.pmkpi.perfprogram = {};
}

Ext.lt.pmkpi.perfprogram.tlpqueryservice = function (config, service) {
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _workflow = config.workflow,
        _menuid = config.menuid,
        _type = config.type,  // 1-事前绩效评估查询；2-项目绩效目标查询
        _agency,
        _tablecode,
        _tabfilter,
        _tabcode,
        _name,
        _defquery,
        _orderby,
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;

    $(function () {
        common.initDatatable();
        if ("2" == _type) {
            common.changTooltoolbuttontStatus(0, "导出报告");
        }
        Ext.lt.pmkpi.querytree();
        cmp.query();
    });

    Ext.lt.pmkpi.querytree = function (){
        var params = {};
        params.menuid = _menuid;
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        var datalist = Ext.lt.RCP.asyncall(service , "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
        return datalist;
    }

    //查询
    cmp.query = function (obj) {
        if (!_agency) {
            _agency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.agency = _agency;
        params.isleaf = Ext.lt.pmkpi.isleaf + "";
        params.menuid = _menuid;
        params.workflow = _workflow;
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        params.pagetype = "report";
        params.tabfilter = _tabfilter;
        params.tabcode = _tabcode;
        params.menuid = _menuid;
        params.orderby = _orderby;
        params.beanid = "pmkpi.perfprogram.TlpProgramQueryBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        params.type = _type;
        datatable.queryData(params, function () {
            Ext.lt.ui.loadingClose();
        });
    }

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        cmp.query();
    });

    //送审情况
    cmp.queryaudit = function () {
        common.auditquery(datatable);
    }

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
     * 一级项目指标汇总
     */
    cmp.sumindex = function () {
        var data = datatable.getSelected();
        if (!data || data.length != 1) {
            Ext.lt.ui.alert("请选中一条数据！", function () {
            });
            return;
        }
        var url = "/pmkpi/program/query/sumindex.page";
        var params = {};
        params.pro_code = data[0].pro_code;//一级项目编码
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "一级项目指标汇总");
    }

    Ext.lt.message.hook("datatable", "beforesetcols", function (obj) {
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
        _pagetype = config.pagetype;
        _uikey = config.uikey;
        var cols = obj.cols;
        if (!Ext.lt.isArray(cols))
            cols = [cols];
        // for (var i = 0; i < cols.length; i++) {
        //     var col = cols[i];
        //     if (col["colcode"] == "pro_name") {
        //         col.fn = function (l, c, data, col) {
        //             return "<a herf='#' style='color:#468ac9'>" + data.pro_name + "</a>";
        //         }
        //         col.onclick = function (td, el, l, c, d) {
        //             var url = _uikey + ".page";
        //             var params = {};
        //             params.pagetype = "editreport";
        //             params.mainguid = d.guid;
        //             params.agency = d.agencyguid;
        //             params.viewtype = "query";
        //             params.workflow = _workflow;
        //             url = Ext.lt.pmkpi.genPageUrl(url, params);
        //             Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "项目绩效目标查看");
        //         };
        //     }
        // }
    });

    //导出
    cmp.export = function () {
        if (datatable.getRecordset().size() != 0) {
            var data = datatable.getSelected();
            var cfg = {};
            cfg.key = datatable.key;//datatable的key值
            cfg.bustable = datatable;
            if (data.size() == 0) {
                if (Ext.lt.ui.confirm("是否导出当前全部数据？")) {
                    cfg.hassql = 1;
                    cfg.beanid = config.bobeanid;//业务具体的bo  主要用到 bo中getvodsql()方法
                    if (typeof (queryform) != 'undefined') {
                        cfg.isHaveQueryForm = true;//是否有查询区
                        cfg.queryConfig = queryform.getQueryParam();//查询区条件
                    }
                    cfg.isHaveTabPage = true;
                    cfg.filter = " 1=1 ";
                    cfg.downtype = 'xls';
                    dataexport.excelexport(cfg);
                } else {
                    return;
                }
            } else {
                cfg.downtype = 'xls';//下载  类型
                dataexport.excelexport(cfg);
            }
        } else {
            Ext.lt.ui.alert("页面无数据！", {timeout: 1}, function () {
            });
            return;
        }
    }

    cmp["showProjView"] = function(){
        var data = datatable.getSelected();
        if(data.size()==1){
            var params = {};
            params.submenu = _menuid;
            params.pro_code = data[0].pro_code;
            common.proinfoview(datatable,params);
        } else if(data.size() > 1) {
            Ext.lt.ui.alert('每次只能查看一条数据！',function(){});
        } else {
            Ext.lt.ui.alert('请选择要查看的数据！',function(){});
        }
    }

    cmp.queryView = function (){
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据查看项目明细！",function(){});
            return;
        }
        var url = _uikey + ".page";
        var params = {};
        params.pagetype = "editreport";
        params.mainguid = data[0].guid;
        params.agency = data[0].agencyguid;
        params.pro_code = data[0].pro_code;
        params.viewtype = "query";
        params.workflow = _workflow;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "项目绩效目标查看");
    }

    /**
     * 导出目标支出表
     * @param obj
     */
    cmp.hbexpdoc = function(obj){
        var data = datatable.getSelected();
        if (data.size() == 0) {
            alert("请选择数据进行导出！");
            return;
        }
        var guids = [];
        for(var i=0;i<data.length;i++){
            guids.push(data[i].guid);
        }
        var btnconfig = eval('(' + obj.config + ')');
        var templatecode = btnconfig.tempatecode;
        var bobeanid = "pmkpi.perfcommon.expdoc.ExpDocBOTX";
        var parammap = new Map();
        parammap.set("templatecode", templatecode);
        parammap.set("guids", guids);
        parammap.set("bobeanid", bobeanid);
        common.hbExpdocFile(parammap);
    }

    /**
     * 导出目标批复表
     * @param obj
     */
    cmp.hbexpdocpf = function(obj){
        var data = datatable.getSelected();
        if (data.size() == 0) {
            alert("请选择数据进行导出！");
            return;
        }
        var guids = [];
        for(var i=0;i<data.length;i++){
            guids.push(data[i].guid);
        }
        var btnconfig = eval('(' + obj.config + ')');
        var templatecode = btnconfig.tempatecode;
        var bobeanid = "pmkpi.perfcommon.expdoc.ExpDocBOTX";
        var parammap = new Map();
        parammap.set("templatecode", templatecode);
        parammap.set("guids", guids);
        parammap.set("bobeanid", bobeanid);
        common.hbExpdocFile(parammap);
    }

    /**
     * 查看项目资金来源
     */
    cmp.querySourceFund = function (){
        var cols = [];
        cols.push("agency_code");
        cols.push("guid");
        cols.push("pro_code");
        var url = "/pmkpi/program/sourcefund.page";
        common.queryDataList(cols, url);
    }

    return cmp;
}