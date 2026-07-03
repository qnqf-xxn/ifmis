if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}

Ext.lt.pmkpi.deptTJauditlist = function(config, service){
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
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

    $(function(){
        deptcmp.initDatatable();
    });

    //查询
    cmp.query = function (obj){
        Ext.lt.pmkpi.query();
    }

    Ext.lt.pmkpi.query = function(){
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
        params.beanid = "pmkpi.deptTJformance.DeptTJPerfAuditBO";
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

    /**
     * 分发处室审阅
     */
    cmp.tofinintorg = function (obj){
        var data = datatable.getSelected();
        if(data.length != 1){
            Ext.lt.ui.alert( "请选择一条数据进行分发！",function(){
            });
            return;
        }
        var url = "/pmkpi/deptTJformance/audit/tofinintorg.page";
        var params = {};
        params.mainguid = data[0].guid;
        params.agency = data[0].agencyguid;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth-100, scrHeight-100,"分发处室审阅");
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

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
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
        if (!deptcmp.checkwfstatus(datas)) return false;//先校验审核状态是否一致
        var params = {};
        params.datas = datas;
        params.tablecode = _tablecode;
        params.workflow = _workflow;
        params.auditdata = Ext.lt.pmkpi.auditdata;
        params.mainguid = datas[0].guid;
        params.busguid = _menuid + "_" + datas[0].wfstatus;
        deptcmp.doAction(obj,params);
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
        deptcmp.auditquery(datatable);
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
        cmp.query();
    }

    Ext.lt.message.hook("perfcommon", "auditquery",function(){
        Ext.lt.pmkpi.query();
        try {
            Ext.lt.ui.closeModalWindow();
        } catch (e) {
            Ext.lt.ui.modalWindow.close();
        }
    });

    Ext.lt.message.hook("perfcommon", "tablequery",function(){
        Ext.lt.pmkpi.query();
    });

    //导出
    cmp.export = function () {
        if (datatable.getRecordset().size() != 0) {
            var data = datatable.getSelected();
            var cfg = {};
            cfg.key = datatable.key;//datatable的key值
            cfg.bustable = datatable;
            if (data.size() == 0) {
                alert("请选择数据进行导出！");
                return;
                // if (Ext.lt.ui.confirm("是否导出当前全部数据？")) {
                //     cfg.hassql = 1;
                //     cfg.beanid = config.bobeanid;//业务具体的bo  主要用到 bo中getvodsql()方法
                //     if (typeof (queryform) != 'undefined') {
                //         cfg.isHaveQueryForm = true;//是否有查询区
                //         cfg.queryConfig = queryform.getQueryParam();//查询区条件
                //     }
                //     cfg.isHaveTabPage = true;
                //     cfg.filter = " 1=1 ";
                //     cfg.downtype = 'xls';
                //     dataexport.excelexport(cfg);
                // } else {
                //     return;
                // }
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
     * 页面布局完成.
     */
    Ext.lt.message.hook("layout", "endlayout2",function(){
        //处理首页代办点击后跳转页签问题
        if (isfirst) {
            isfirst = false;
            deptcmp.pendingtasktab(config);
        }
    });

    return cmp;
}

