if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.deptperformance){
    Ext.lt.pmkpi.deptperformance = {};
}

Ext.lt.pmkpi.deptperformance.deptequeryservice = function(config, service){
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _workflow = config.workflow,
        _menuid = config.menuid,
        _agency,
        _tablecode,
        _tabfilter,
        _defquery,
        _orderby,
        _pagetype,
        _uikey,
		_name,
    scrWidth =document.body.clientWidth,
    scrHeight =document.body.clientHeight;
    var menutype = config["menutype"];

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        deptcmp.initDatatable();
        cmp.query();
    })
    //查询
    cmp.query = function (obj){
        query();
    }

    function query(){
        if(!_agency){
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
        params.pagetype = "report";
        params.tabfilter = _tabfilter;
        params.beanid = "pmkpi.deptperformance.DeptPerformanceQueryBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }

    //送审情况
    cmp.queryaudit = function (){
        deptcmp.auditquery(datatable);
    }
    
    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if(treeNode){
            _agency = treeNode.guid;
            _name=treeNode.name;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _agency = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
        }
        cmp.query();
    });

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        _tablecode = uiconfig.tablecode;
    });

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        _tablecode = uiconfig.tablecode;
        _defquery=uiconfig.defquery;
        _orderby=uiconfig.orderby;
        _pagetype = config.pagetype;
        _uikey = config.uikey;
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if(col["colcode"] == "name"){
                col.fn = function(l,c,data,col){
                    return "<a herf='#' style='color:#468ac9'>" + data.name + "</a>";
                }
                col.onclick = function(td, el, l, c, d) {
                    var params = {};
                    if ("zjdept" == menutype){
                        _uikey = "/pmkpi/deptZJformance/report/edit";
                        params.saveAgency = d.agencyguid;
                    }
                    var url = _uikey + ".page";
                    params.pagetype = "editreport";
                    params.mainguid = d.guid;
                    params.agency = d.agencyguid;
                    params.saveAgency = d.agencyguid;  //坑-部门整体绩效资金列取不到值(因为获取不到saveAgency)
                    params.viewtype = "query";
                    params.workflow = _workflow;
                    url = Ext.lt.pmkpi.genPageUrl(url, params);
                    Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"部门绩效目标查看");
                };
            }
        }
    });

    //导出
    cmp.export = function () {
        if (datatable.getRecordset().size() != 0) {
            var data = datatable.getSelected();
            var cfg = {};
            cfg.key = '/pmkpi/deptperformance/query/index';
            cfg.bustable = datatable;
            if (data.size() == 0) {
                alert("请选择数据进行导出！");
                return;
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

    /**
     * 导出部门整体申报表(河北)
     * @param obj
     */
    cmp.hbexport = function(obj){
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
        deptcmp.hbExpdocFile(parammap);
    }

    /**
     * 导出部门整体批复表(河北)
     * @param obj
     */
    cmp.hbexportpf = function(obj){
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
        deptcmp.hbExpdocFile(parammap);
    }

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        cmp.query();
    });

    return cmp;
}


