if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.perfprogram){
	Ext.lt.pmkpi.perfprogram = {};
}
if(!Ext.lt.pmkpi.perfprogram.reportservice){
	Ext.lt.pmkpi.perfprogram.reportservice = {};
}

Ext.lt.pmkpi.perfprogram.reportservice = function(config, service){
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
    var _elementcode = config["elementcode"];
    var _columncode = config["columncode"];
    var isfirst=true;//首次进入
    var serviceid = service;
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
        params.nodeguid = _nodeguid;
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
        params.beanid = "pmkpi.perfprogram.TlpProgramBO";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
        	Ext.lt.ui.loadingClose();
        });
    }

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        cmp.query();
    });

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

    Ext.lt.message.hook("perfcommon", "tablequery",function(){
        Ext.lt.pmkpi.query();
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
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if(col["colcode"] == "pro_name"){
                col.fn = function(l,c,data,col){
                    return "<a herf='#' style='color:#468ac9'>" + data.pro_name + "</a>";
                }
                col.onclick = function(td, el, l, c, d) {
                    var url = "/pmkpi/program/report/edit.page";
                    var params = {};
                    params.pagetype = "editreport";
                    params.mainguid = d.guid;
                    params.agency = d.agencyguid;
                    params.pro_code = d.pro_code;
                    params.viewtype = "query";
                    params.workflow = _workflow;
                    url = Ext.lt.pmkpi.genPageUrl(url, params);
                    Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"项目绩效目标申报");
                };
            }
        }
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
            params.mainguid = data[0].guid;
            params.procode = data[0].pro_code;//项目编码
            params.columncode = _columncode; //左侧树要素保存字段.
            params.viewtype = "mod";
            params.prolev = _prolev;
		} else {
			Ext.lt.ui.alert("请选择一条要修改的数据！",function(){});
            return;
		}
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"项目绩效目标申报");
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
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"项目绩效目标申报");
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
    	if (!isfirst){
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

    //送审情况
    cmp.showwfinfo = function (){
        commoncmp.auditquery(datatable);
    }

    $(function (){
        //处理首页代办点击后跳转页签问题
        commoncmp.initDatatable();
        commoncmp.pendingtasktab(config);
        isfirst = false;
        Ext.lt.pmkpi.query();
    })

    return cmp;
}

