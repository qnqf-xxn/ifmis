if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.deptperformance){
    Ext.lt.pmkpi.deptperformance = {};
}

Ext.lt.pmkpi.deptperformance.depteauditservice = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _workflow = config.workflow,
        _menuid = config.menuid,
        _agency,
        _tablecode,
        _tabfilter,
        _tabcode,
		_defquery,
		_orderby,
		_pagetype,
        _uikey,
    scrWidth =document.body.clientWidth,
    scrHeight =document.body.clientHeight;
    var serviceid = service;
    var isfirst=true;//首次进入
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
        params.pagetype = "audit";
        params.tabfilter = _tabfilter;
        params.tabcode = _tabcode;
        params.orderby=_orderby;  //排序
        params.tablesql=_defquery;//查询条件
        params.beanid = "pmkpi.deptperformance.DeptPerformanceAuditBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }

    /**
     * 修改
     */
    cmp.addOredit = function (obj){
        var data = datatable.getSelected();
        if(_agency == "treeroot" && data.length != 1){
            Ext.lt.ui.alert("请选择左侧部门或选中一条数据进行填报/修改！",function(){});
            return;
        }
        var params = {};
        params.workflow = _workflow;
        var url = _uikey + ".page";
        if (data.length == 1) {
            params.saveAgency = data[0].agencyguid;
            params.mainguid = data[0].guid;
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"绩效目标申报");
    }

    
    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if(treeNode){
            _agency = treeNode.guid;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _agency = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
        }
        cmp.query();
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
                    var url = _uikey + ".page";
                    params.pagetype = "audit";
                    params.mainguid = d.guid;
                    params.agency = d.agencyguid;
                    params.saveAgency = d.agencyguid;
                    params.viewtype = "query";
                    params.workflow = _workflow;
                    url = Ext.lt.pmkpi.genPageUrl(url, params);
                    Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight,"绩效审核");
                };
            }
        }
    });

    Ext.lt.pmkpi.audit = function(obj) {
        cmp.wfAudit(obj);
    }
    
    //送审/审核
    cmp.wfAudit = function (obj){
        var actionname = obj.name;
        var datas = datatable.getSelected();
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择要" + actionname + "的数据！",function(){});
            return;
        }
        if (!common.checkwfstatus(datas)) return false;//先校验审核状态是否一致
        var params = {};
        params.datas = datas;
        params.tablecode = _tablecode;
        params.workflow = _workflow;
        params.auditdata = Ext.lt.pmkpi.auditdata;
        params.mainguid = datas[0].guid;
        params.busguid = _menuid + "_" + datas[0].wfstatus;
        common.doAction(obj,params);
    }

    //审核
    cmp.audit = function (obj){
        var data = datatable.getSelected();
        if(data.length != 1){
            Ext.lt.ui.alert( "请选择一条数据进行审核！",function(){
            });
            return;
        }
        var url = "/pmkpi/audit/view.page";
        var params = {};
        params.guid = data[0].guid;
        params.agency = data[0].agencyguid;
        params.saveAgency = data[0].agencyguid;
        params.workflow = data[0].wfid;
        params.wfstatus = data[0].wfstatus;
        params.uikey = _uikey;
        var nodemap = Ext.lt.RCP.asyncall(serviceid , "queryPrevAuditType", [data[0].wfid, data[0].wfstatus]);
        params.nodeguid = nodemap.nodeguid;
        params.audittype = nodemap.audittype;
        if (!nodemap.audittype || nodemap.audittype == "" || nodemap.audittype == "null" ) {
            Ext.lt.ui.alert( "请对流程审核节点进行配置！",function(){
            });
            return;
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight,"绩效审核");
    }
    
    //送审情况
    cmp.queryaudit = function (){
        common.auditquery(datatable);
    }

    /**
     * 审核信息
     */
    cmp.auditinfo = function(){
        var data = datatable.getSelected();
        if(data.length != 1){
            Ext.lt.ui.alert( "请选择一条数据进行查看！",function(){
            });
            return;
        }
        var params = {};
        params.workflow = _workflow;
        params.wfstatus = data[0].wfstatus;
        var nodemap = Ext.lt.RCP.asyncall(serviceid , "queryAuditType", [_workflow, data[0].wfstatus]);
        params.nodeguid = nodemap.nodeguid;
        params.audittype = nodemap.audittype;
        if (!nodemap.audittype || nodemap.audittype == "" || nodemap.audittype == "null" ) {
            Ext.lt.ui.alert( "请对流程审核节点进行配置！",function(){
            });
            return;
        }
        params.agency = data[0].agencyguid;
        params.guid = data[0].guid;
        url = "/pmkpi/audit/index/" + nodemap.audittype + ".page";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight,"审核信息");
    }

    //页签方法
    cmp.clickTabpage = function(obj){
        changToolbuttonStatus(toolbutton,parseInt(obj.ordernum),obj.hidebtns);
        _tabfilter = obj.filter;
        _tabcode = obj.code;
        if (!isfirst) {
            query();
        }
    }

    Ext.lt.message.hook("perfcommon", "auditquery",function(){
        query();
        try {
            Ext.lt.ui.closeModalWindow();
        } catch (e) {
            Ext.lt.ui.modalWindow.close();
        }
    });

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        cmp.query();
    });

    $(function (){
        //处理首页代办点击后跳转页签问题
        common.initDatatable();
        isfirst = false;
        common.pendingtasktab(config);
    })

    return cmp;
}

