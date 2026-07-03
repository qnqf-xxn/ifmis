if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}

Ext.lt.pmkpi.deptTJlist = function(config, service){
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
    var _tablecode;
    var _currenttab;
    var serviceid = service;

    $(function(){
        commoncmp.initDatatable();
        Ext.lt.pmkpi.query();
    });

    //查询
    cmp.query = function (obj){
        Ext.lt.pmkpi.query();
    }

    Ext.lt.pmkpi.query = function(dataguid){
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
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tabfilter = _tabfilter;
        params.tablesql = _defquery;
        params.orderby = _orderby;
        params.tabcode = _tabcode;
        params.tablecode = _tablecode;
        params.beanid = "pmkpi.deptTJformance.DeptTJPerfBO";
        datatable.queryData(params,function(){
        	Ext.lt.ui.loadingClose();
        	if(dataguid){
                var rows = datatable.getCheckRecordSet().query({guid: dataguid});
                rows[0].check = 1;
                cmp.save();
            }
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
        var config = obj.table.config;
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
        _pagetype = config.pagetype;
        _uikey = config.uikey;
        _tablecode = uiconfig.tablecode;
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
                    var url = _uikey + ".page";
                    params.pagetype = "report";
                    params.mainguid = d.guid;
                    params.agency = d.agencyguid;
                    params.saveAgency = d.agencyguid;
                    params.viewtype = "query";
                    params.workflow = _workflow;
                    url = Ext.lt.pmkpi.genPageUrl(url, params);
                    Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"部门绩效目标查看");
                };
            }
        }
    });

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    Ext.lt.pmkpi.edit = function (dataguid,currenttab){
        _currenttab = currenttab;
        Ext.lt.pmkpi.query(dataguid);
    }

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
        var url = "/pmkpi/deptTJformance/report/edit.page";
		if (data.length == 1) {
		    params.saveAgency = data[0].agencyguid; //虽然是agency也有可能是处室
            params.mainguid = data[0].guid;
            params.viewtype = "mod";
            params.currenttab = _currenttab;
            params.busguid = _menuid + "_" + data[0].wfstatus;
            params.menuid = _menuid;
		} else {
			Ext.lt.ui.alert("请选择一条要修改的数据！",function(){});
            return;
		}
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth-5,scrHeight-6,"部门整体绩效目标申报");
    }
    /**
     * 新增
     */
    cmp.add = function(){
        if(!_nodeguid || _nodeguid == "treeroot" || Ext.lt.pmkpi.isleaf != "1"){
             Ext.lt.ui.alert("请选择左侧树末级节点数据！",function(){});
             return;
        }
        var flag = Ext.lt.RCP.asyncall(serviceid , "findDeptPerformance", _nodeguid);
        if (flag == true){
            Ext.lt.ui.alert("部门已经存在编报，不可新增！",function(){});
            return;
        }
        var params = {};
        var url = "/pmkpi/deptTJformance/report/edit.page";
		var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
		params.workflow = _workflow;
        params.saveAgency = _nodeguid;
        params.mainguid = newguid;
        params.viewtype = "add";
        params.menuid = _menuid;
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
    	if(!_nodeguid){return;}
        Ext.lt.pmkpi.query();
    }

    //送审情况
    cmp.showwfinfo = function (){
        commoncmp.auditquery(datatable);
    }

    return cmp;
}

