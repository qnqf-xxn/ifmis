if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.doubleprocess){
	Ext.lt.pmkpi.doubleprocess = {};
}

Ext.lt.pmkpi.doubleprocess.tlpjxaudit = function(config, service){
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
        _uikey;
    scrWidth =document.body.clientWidth,
    scrHeight =document.body.clientHeight;
    var serviceid = service;
    var isfirst=true;//首次进入
    //查询
    cmp.query = function (obj){
        query();
    }

    $(function () {
        var page = {};
        page.columns = "*";
        datatable.setPage(page);
        datatable.redraw();
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        deptcmp.initDatatable();
        query();
    })

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
        params.beanid = "pmkpi.doubleprocess.TlpJxAuditBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params, function () {
            Ext.lt.ui.loadingClose();
        });
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
        // if (datas.length>1) {
        //     Ext.lt.ui.alert('只能选中一条进行操作');
        //     return;
        // }
        var params = {};
        params.datas = datas;
        params.tablecode = "v_perf_t_review";
        params.workflow = _workflow;
        params.auditdata = Ext.lt.pmkpi.auditdata;
        params.mainguid = datas[0].guid;
        params.busguid = _menuid + "_" + datas[0].wfstatus;
        params.proguid = datas[0].proguid;
        params.agency = datas[0].agencyguid;
        var nodemap = Ext.lt.RCP.asyncall(serviceid , "queryPrevAuditType", ["B9C7D80EC0188933E053B11FA8C0A5D6", datas[0].wfstatus]);
        params.nodeguid = nodemap.nodeguid;
        params.audittype = nodemap.audittype;
        params.jxaudit = "jxaudit";
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
        params.projguid = data[0].proguid;
        params.agency = data[0].agencyguid;
        params.workflow = data[0].wfid;
        params.pagetype = "audit";
        params.wfstatus = data[0].wfstatus;
        params.uikey = "/pmkpi/program/report/dpedit";
        var nodemap = Ext.lt.RCP.asyncall(serviceid , "queryPrevAuditType", ["B9C7D80EC0188933E053B11FA8C0A5D6", data[0].wfstatus]);
        params.nodeguid = nodemap.nodeguid;
        params.audittype = nodemap.audittype;
        params.jxaudit = "jxaudit";
        if (!nodemap.audittype || nodemap.audittype == "" || nodemap.audittype == "null") {
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
        if (!nodemap.audittype || nodemap.audittype == "" || nodemap.audittype == "null") {
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

    /**
     * 修改项目
     */
    cmp.modproinfo = function (){
        var data = datatable.getSelected();
        var proguid = data[0].proguid;
        //根据projguid获取项目code
        var proinfoMap = {};
        proinfoMap.proguid = proguid;
        var proInfo = Ext.lt.RCP.asyncall(serviceid , "getProInfo", proinfoMap);
        var pro_code = null;
        if (proInfo != null){
            pro_code = proInfo[0].pro_code;
        }
        var params = {};
        params.submenu = _menuid;
        params.pro_code = pro_code;
        deptcmp.modproinfo(datatable,params);
    }


    /**
     * 查看项目明细
     */
    cmp.detailed = function (){
        var data = datatable.getSelected();
        var proguid = data[0].proguid;
        //根据projguid获取项目code
        var proinfoMap = {};
        proinfoMap.proguid = proguid;
        var proInfo = Ext.lt.RCP.asyncall(serviceid , "getProInfo", proinfoMap);
        var pro_code = null;
        if (proInfo != null){
            pro_code = proInfo[0].pro_code;
        }
        var params = {};
        params.submenu = _menuid;
        params.pro_code = pro_code;
        deptcmp.proinfoview(datatable,params);
    }

    //页签方法
    cmp.clickTabpage = function(obj){
        changToolbuttonStatus(toolbutton,parseInt(obj.ordernum),obj.hidebtns);
        _tabfilter = obj.filter;
        _tabcode = obj.code;
        query();
    }

    Ext.lt.message.hook("perfcommon", "auditquery",function(){
        query();
        Ext.lt.ui.closeModalWindow();
    });

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

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        cmp.query();
    });

    /**
     * 项目绩效目标审核(绩效处退回)
     */
    cmp.backjxaudit = function(obj){
        var actionname = obj.name;
        var datas = datatable.getSelected();
        if (datas.length <= 0) {
            Ext.lt.ui.alert("请选择要" + actionname + "的数据！",function(){});
            return;
        }
        var params = {};
        params.datas = datas;
        params.tablecode = "v_perf_t_review";
        params.workflow = _workflow;
        params.auditdata = Ext.lt.pmkpi.auditdata;
        params.mainguid = datas[0].guid;
        params.busguid = _menuid + "_" + datas[0].wfstatus;
        deptcmp.doAction(obj,params);
    }


    function ajax() {
        var selUrl = "/pmkpi/doubleprocess/backDoublePress.do?tokenid="+Ext.lt.token.getTokenid();
        var _win = $("#_audit_iframe_")[0].contentWindow;
        var maindata = _win.Ext.lt.pmkpi.editmap||{};
        _win.editform && (jQuery.extend(maindata, _win.editform.getEditFormValues()));
        _win.datatable && (parms.datas = _win.datatable.getRecordSet().toArray());
        Ext.lt.ui.loadingShow();
        maindata["type"] = _auditype;
        var remark = maindata.remark;
        var list = [];
        list.push({
            "mainguid": _projguid,
            "remark": remark
        });
        var params = {};
        params.backData = JSON.stringify(list);
        params.remark = remark;
        $.ajax({
            type: "post",
            url: selUrl,
            data: JSON.stringify(params),
            dataType: "text",
            contentType: "application/json",
            success: function (data) {
                var data = JSON.parse(data);
                if (true== data.result) {
                    Ext.lt.ui.alert(("退回成功！"),{}, function(ret) {
                    });
                    Ext.lt.message.send("perfcommon", "auditquery",{});
                    Ext.lt.ui.closeModalWindow;
                } else {
                    Ext.lt.ui.alert('退回失败！',function(){
                    });
                }
                Ext.lt.ui.loadingClose();
            }
        });
    }

    return cmp;
}