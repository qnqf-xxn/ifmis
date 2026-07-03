if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.midperfprogram){
	Ext.lt.pmkpi.midperfprogram = {};
}
if(!Ext.lt.pmkpi.midperfprogram.midpqueryservice){
    Ext.lt.pmkpi.midperfprogram.midpqueryservice = {};
}

Ext.lt.pmkpi.midperfprogram.midpqueryservice = function(config, service){
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _workflow = config.workflow,
        _menuid = config.menuid,
        _agency,
        _tablecode,
        _tabfilter,
        _tabcode,
		_name,
        _uikey,
        _pagetype,
        _defquery, //表格过滤条件
        _orderby, //排序
    scrWidth =document.body.clientWidth,
    scrHeight =document.body.clientHeight;

    var serviceid = service;

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
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.tabcode = _tabcode;
        params.menuid = _menuid;
        params.nodeguid = _agency;
        params.beanid = "pmkpi.midperfprogram.MidProgramQueryBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        cmp.query();
    });

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
    /**
     * 查看明细
     */
    cmp.detailed = function (){
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据进行查看！",function(){});
            return;
        }
        var url = _uikey + ".page";
        var params = {};
        params.pagetype = "editreport";
        params.saveAgency = data[0].agencyguid; //虽然是agency也有可能是处室
        params.procode = data[0].pro_code;//项目编码
        params.proguid = data[0].proguid;//项目ID
        params.mainguid = data[0].proguid;
        params.projectkind = data[0].projectkind;//项目类型
        params.viewtype = "query";
        params.isnzzj = "true";// 是否年中追加
        params.workflow = _workflow;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"项目绩效目标查看");
    }

    /**
     * 查看一级项目明细
     */
    cmp.queryPromain = function (){
        var params = {};
        var data = datatable.getSelected();
        params.proguid = data[0].proguid;
        var xmxxEditobject = Ext.lt.RCP.asynserver("pmkpi.doubleprocess.TlpJxAuditService", "getProInfo", params);
        params.submenu = _menuid;
        params.pro_code = data[0].pro_code;
        params.vchtypeid = xmxxEditobject[0].vchtypeid;
        params.projectkind = xmxxEditobject[0].projectkind;
        deptcmp.queryPromain(datatable,params);
    }

    /**
     * 查看项目明细
     */
    cmp.prodetailed = function (){
        var params = {};
        var data = datatable.getSelected();
        params.submenu = _menuid;
        params.pro_code = data[0].pro_code;
        deptcmp.proinfoview(datatable,params);
    }

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
            if(col["colcode"] == "pro_name1111"){
                col.fn = function(l,c,data,col){
                    return "<a herf='#' style='color:#468ac9'>" + data.pro_name + "</a>";
                }
                col.onclick = function(td, el, l, c, d) {
                    var url = _uikey + ".page";
                    var params = {};
                    params.pagetype = "editreport";
                    params.mainguid = d.guid;
                    params.agency = d.agencyguid;
                    params.viewtype = "query";
                    params.workflow = _workflow;
                    url = Ext.lt.pmkpi.genPageUrl(url, params);
                    Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"项目绩效目标查看");
                };
            }
        }
    });


    //山西导出报告
    cmp.expdoc = function(btn, table){
        var btnconfig = eval('(' + btn.config + ')');
        var _tempatecode = btnconfig.tempatecode;
        var _rows;
        if (table){
            _rows = table.getSelected();
        } else {
            _rows = datatable.getSelected();
        }
        if(_rows.length <= 0){
            Ext.lt.ui.alert("请选择数据！", function () {
            });
            return;
        }
        var guids = [];
        var projguids = [];
        for (var i=0; i<_rows.length;i++){
            guids.push(_rows[i]["guid"]);
            projguids.push(_rows[i]["proguid"]);
        }
        var param = {};
        param.guids = projguids;
        param.projguids = projguids;
        param.templatecode = _tempatecode;
        param.bobeanid = "pmkpi.perfcommon.expdoc.ExpDocBOTX";
        param.rcp = true;
        if (_rows.length >= 5) {
            if (Ext.lt.ui.confirm("当前导出数据较多，需时间较长，导出完成后自行关闭进度窗口，是否确认导出！")) {
                Ext.lt.RCPConsole.processdown("pmkpi.perfcommon.expdoc.ExpDocService",'createWord&rcpconsole=process&noserveranalyselog=true',param,"downframe");
                colspross_time = 1;
                setTimeout(colspross_function,1100);
            } else {
                return;
            }
        } else {
            param.rcp = false;
            Ext.lt.RCPConsole.processdown("pmkpi.perfcommon.expdoc.ExpDocService",'createWord',param,"downframe");
            var rcpconsole=document.getElementsByClassName('rcpconsole');
            for(i=0;i<rcpconsole.length;i++){
                rcpconsole.item(i).style.display = 'none';
            }
            Ext.lt.ui.loadingClose();
        }
    }
    
    return cmp;
}