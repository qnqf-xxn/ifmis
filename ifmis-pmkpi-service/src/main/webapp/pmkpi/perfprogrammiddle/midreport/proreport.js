if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.midperfprogram){
	Ext.lt.pmkpi.midperfprogram = {};
}
if(!Ext.lt.pmkpi.midperfprogram.midreportservice){
	Ext.lt.pmkpi.midperfprogram.midreportservice = {};
}

Ext.lt.pmkpi.midperfprogram.midreportservice = function(config, service){
    var commoncmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _workflow = config.workflow,
        _menuid = config.menuid,
        _prolev = config.prolev, //项目级别
        _nodeguid, //左侧树节点
        _tablecode, //业务表
        _tabfilter, //页签过滤条件
        _tabcode, //页签
        _uikey, //
        _defquery, //表格过滤条件
        _orderby, //排序
        _deltables, //主表删除要删除的明细
        _delcols, //
        scrWidth =document.body.clientWidth,
        scrHeight =document.body.clientHeight;
    var _columncode = config["columncode"];

    var serviceid = service;
    var isfirst = true;//首次进入
    //查询
    cmp.query = function (obj){
        Ext.lt.pmkpi.query();
    }

    Ext.lt.pmkpi.query = function(){
        if(!_nodeguid){
        	_nodeguid = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.saveAgency = _nodeguid;
        params.isleaf = Ext.lt.pmkpi.isleaf + "";
        params.menuid = _menuid;
        params.prolev = _prolev; //项目级别
        params.workflow = _workflow;
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.tabfilter = _tabfilter;
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.tabcode = _tabcode;
        params.beanid = "pmkpi.midperfprogram.MidProgramBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
        	Ext.lt.ui.loadingClose();
        });
    }
    /**
     * 点击左侧树.
     */
    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if(treeNode){
        	_nodeguid = treeNode.guid;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
        	_nodeguid = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
        }
        cmp.query();
    });

    Ext.lt.message.hook("perfcommon", "auditquery",function(){
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        cmp.query();
    });

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
        _uikey = config.uikey;
        _deltables = config.deltables;
        _delcols = config.delcols;
    });

    /**
     * 修改
     */
    cmp.save = function (obj){
        var data = datatable.getSelected();
        if(data.length == 0){
        	Ext.lt.ui.alert("请选择要修改的数据！",function(){});
            return;
        }
        var params = {};
        var url = _uikey + ".page";
		if (data.length == 1) {
		    params.saveAgency = data[0].agencyguid; //虽然是agency也有可能是处室
            params.mainguid = data[0].proguid;
            params.procode = data[0].pro_code;//项目编码
            params.proguid = data[0].proguid;//项目ID
            params.projectkind = data[0].projectkind;//项目类型
            params.columncode = _columncode; //左侧树要素保存字段.
            params.viewtype = "mod";
            params.prolev = _prolev;
            params.isnzzj = "true";// 是否年中追加
		} else {
			Ext.lt.ui.alert("请选择一条要修改的数据！",function(){});
            return;
		}
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"年中追加项目绩效目标填报");
    }
    /**
     * 新增
     */
    cmp.add = function(){
        if(!_nodeguid || _nodeguid == "treeroot" || Ext.lt.pmkpi.isleaf != "1"){
             Ext.lt.ui.alert("请选择左侧树末级节点数据！",function(){});
             return;
        }
        var params = {};
        params.workflow = _workflow;
        var url = _uikey + ".page";
		var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
		params.workflow = _workflow;
		params.prolev = _prolev;
        params.saveAgency = _nodeguid;
        params.mainguid = newguid;
        params.pageurl = _uikey; //弹出的url.
        params.viewtype = "add";
        params.columncode = _columncode; //左侧树字段.
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"年中追加项目绩效目标填报");
    }

    /**
     * 修改项目
     */
    cmp.modproinfo = function (){
        var params = {};
        var data = datatable.getSelected();
        params.submenu = _menuid;
        params.pro_code = data[0].pro_code;
        commoncmp.modproinfo(datatable,params);
    }

    /**
     * 修改一级项目
     */
    cmp.promainedit = function (){
        var params = {};
        var data = datatable.getSelected();
        params.proguid = data[0].proguid;
        var xmxxEditobject = Ext.lt.RCP.asynserver("pmkpi.doubleprocess.TlpJxAuditService", "getProInfo", params);
        params.submenu = _menuid;
        params.pro_code = data[0].pro_code;
        params.vchtypeid = xmxxEditobject[0].vchtypeid;
        params.projectkind = xmxxEditobject[0].projectkind;
        commoncmp.editPromain(datatable,params);
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
        commoncmp.queryPromain(datatable,params);
    }

    /**
     * 查看项目明细
     */
    cmp.prodetailed = function (){
        var params = {};
        var data = datatable.getSelected();
        params.submenu = _menuid;
        params.pro_code = data[0].pro_code;
        commoncmp.proinfoview(datatable,params);
    }
    /**
     * 删除
     */
    cmp.del = function() {
        var params = {};
        params.workflow = _workflow;
        params.tablecode = _tablecode;
        params.deltables = _deltables;
        params.delcols = _delcols;
        commoncmp.deltable(datatable, params);
    }
    //送审/审核
    cmp.wfAudit = function (obj){
        var datas = datatable.getSelected();
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择要" + obj["name"] + "的数据！",function(){});
            return;
        }
        if (!commoncmp.checkwfstatus(datas)) return false;//先校验审核状态是否一致
        var params = {};
        params.datas = datas;
        params.tablecode = _tablecode;
        params.workflow = _workflow;
        params.busguid = _menuid + "_" + datas[0].wfstatus;
        // 校验页签参数
        params.checktable = _tablecode;
        params.checkkey = _uikey;
        if (obj.code == "sendaudit" && !commoncmp.checkTabPageData(params)) return false;//先校验
        commoncmp.doAction(obj, params);
    }
    //送审情况
    cmp.queryaudit = function (){
    	commoncmp.auditquery(datatable);
    }

    //页签方法
    cmp.clickTabpage = function(obj){
        changToolbuttonStatus(toolbutton, parseInt(obj.ordernum), obj.hidebtns);
        _tabfilter = obj.filter;
        _tabcode = obj.code;
    	if(!_nodeguid){return;}
    	if (!isfirst) {
            Ext.lt.pmkpi.query();
        }
    }

    Ext.lt.message.hook("perfcommon", "auditquery",function(){
        Ext.lt.pmkpi.query();
    });
    /**
     * 查询消息
     */
    Ext.lt.message.hook("perfcommon", "tablequery",function(){
        Ext.lt.pmkpi.query();
    });
    /**
     * 选择项目
     */
    cmp.checkpro = function(){
        var params = {};
        params.workflow = _workflow;
        params.prolev = _prolev;
        params.saveAgency = _nodeguid;
        params.nodeguid = _nodeguid;
        params.bustype = "program";
        params.tablecode = _tablecode;
        params.menuId = _menuid;
        params.isleaf = Ext.lt.pmkpi.isleaf + "";
        if(_nodeguid==null){
            Ext.lt.ui.alert("请选择预算单位!");
            return ;
        }
        var url = "";//项目支出
        url = "/pmkpi/midprogram/report/procheck.page";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth * 0.9, scrHeight * 0.9,"选择项目-"+"项目支出");
    }
    /**
     * 查看明细
     */
    cmp.detailed = function (){
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据进行查看！",function(){});
            return;
        }
        var params = {};
        var url = _uikey + ".page";
        if (data.length == 1) {
            params.saveAgency = data[0].agencyguid; //虽然是agency也有可能是处室
            params.procode = data[0].pro_code;//项目编码
            params.proguid = data[0].proguid;//项目ID
            params.mainguid = data[0].proguid;
            params.columncode = _columncode; //左侧树要素保存字段.
            params.viewtype = "query";
            params.prolev = _prolev;
            params.isnzzj = "true";// 是否年中追加
        } else {
            Ext.lt.ui.alert("请选择一条要修改的数据！",function(){});
            return;
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"年中追加项目绩效目标");
    }

    //送审情况
    cmp.showwfinfo = function (){
        commoncmp.auditquery(datatable);
    }

    $(function(){
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        commoncmp.initDatatable();
        commoncmp.pendingtasktab(config);
        cmp.query();
        isfirst = false;
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

