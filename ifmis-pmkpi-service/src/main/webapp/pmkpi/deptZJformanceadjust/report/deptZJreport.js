if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}

Ext.lt.pmkpi.deptZJlist = function(config, service){
    var commoncmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _workflow = config.workflow,
        _menuid = config.menuid,
        _nodeguid, //左侧树节点
        _tabfilter, //页签过滤条件
        _tabcode, //页签
        _defquery, //表格过滤条件
        _orderby, //排序
        scrWidth =document.body.clientWidth,
        scrHeight =document.body.clientHeight;
    var _tablecode = "V_PERF_T_ADJUST";

    var serviceid = service;

    $(function () {
        commoncmp.initDatatable();
        commoncmp.pendingtasktab();
        isfirst = false;
        cmp.query();
    })

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
        params.workflow = _workflow;
            //"BBC128805C506A0AE053B11FA8C04258";
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tabfilter = _tabfilter;
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.tabcode = _tabcode;
        params.beanid = "pmkpi.deptZJformanceadjust.DeptPerfBO";
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

    Ext.lt.message.hook("perfcommon", "tablequery",function(){
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
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
        var url = "/pmkpi/deptZJformanceadjust/report/edit.page";
		if (data.length == 1) {
		    params.saveAgency = data[0].agencyguid; //虽然是agency也有可能是处室
            params.mainguid = data[0].guid;
            params.projguid = data[0].proguid;
            params.viewtype = "add";
		} else {
			Ext.lt.ui.alert("请选择一条要修改的数据！",function(){});
            return;
		}
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth-5,scrHeight-6,"部门整体绩效目标申报");
    }


    /**
     * 删除
     */
    cmp.del = function() {
        var params = {};
        params.workflow = _workflow;
        params.tablecode = _tablecode;
        commoncmp.deltable(datatable, params);
    }
    //送审/审核
    cmp.wfAudit = function (obj){
        var datas = datatable.getSelected();
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择要" + obj["name"] + "的数据！",function(){});
            return;
        }
        var params = {};
        params.datas = datas;
        params.tablecode = _tablecode;
        params.workflow = _workflow;
        params.busguid = _menuid + "_" + datas[0].wfstatus;
        // 校验页签参数
        params.checktable = "V_PERF_T_ADJUST";
        params.checkkey = "//pmkpi/deptZJformanceadjust/report/edit";
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
        Ext.lt.pmkpi.query();
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

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    cmp.checkprogram = function () {
        var params = {};
        params.workflow = _workflow;
        params.saveAgency = "treeroot";
        params.bustype = "dept";
        params.leftmenuid = _menuid;
        var url = "/pmkpi/adjust/report/deptcheck.page";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth * 0.9, scrHeight * 0.9, "选择项目-部门整体");
    }

    //送审情况
    cmp.showwfinfo = function (){
        commoncmp.auditquery(datatable);
    }

    return cmp;
}

