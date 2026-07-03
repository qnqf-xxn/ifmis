if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.doubleprocess){
	Ext.lt.pmkpi.doubleprocess = {};
}

Ext.lt.pmkpi.doubleprocess.tlpauditservice = function(config, service){
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

    $(function () {
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        deptcmp.initDatatable();
        cmp.query();
    });

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
        params.beanid = "pmkpi.doubleprocess.TlpProgramAuditBOTX";
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
        //山西调用双流程判断
        if (obj["code"] == "sendaudit" || obj["code"] == "audit") {
            var bdmobj = cmp.findPdmWfstatus(datas);
            if (bdmobj.bool){
                //Ext.lt.ui.alert(bdmobj.mesg,function(){});
                //return;
            } else {
                Ext.lt.ui.alert(bdmobj.mesg,function(){});
                return;
            }
        }
        var pdmcheck = cmp.checkPdmCapital(datas);
        if (!pdmcheck.bool){
            Ext.lt.ui.alert(pdmcheck.mesg,function(){});
            return;
        }
        var params = {};
        params.datas = datas;
        params.tablecode = "v_perf_project_infodp";
        params.workflow = _workflow;
        params.auditdata = Ext.lt.pmkpi.auditdata;
        params.mainguid = datas[0].guid;
        params.proguid = datas[0].pro_id;
        params.busguid = _menuid + "_" + datas[0].wfstatus;
        params.agency = datas[0].agencyguid;
        var nodemap = Ext.lt.RCP.asyncall(serviceid , "queryPrevAuditType", [datas[0].wfid, datas[0].wfstatus]);
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
        params.projguid = data[0].pro_id; //项目id.
        params.agency = data[0].agencyguid;
        params.workflow = data[0].wfid;
        params.pagetype = "audit";
        params.wfstatus = data[0].wfstatus;
        params.uikey = "/pmkpi/program/report/dpedit";
        var nodemap = Ext.lt.RCP.asyncall(serviceid , "queryPrevAuditType", [data[0].wfid, data[0].wfstatus]);
        params.nodeguid = nodemap.nodeguid;
        params.audittype = nodemap.audittype;
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

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        cmp.query();
    });

    /**
     * 处理获取绩效目标参数。
     *@params programs -- 项目目标
     */
    cmp.findPdmWfstatus = function(programs) {
        var params = {};
        params.programs = programs;
        if (programs.length == 0){return true};
        var backobj = Ext.lt.RCP.asyncall(serviceid , "getBdmWfstatus", params);
        return backobj;
    }

    /**
     * 处理获取绩效目标参数。
     *@params programs -- 项目目标
     */
    cmp.checkPdmCapital = function(programs) {
        var params = {};
        params.datas = programs;
        if (programs.length == 0){return true};
        var pdmcheck = Ext.lt.RCP.asyncall(serviceid , "checkPdmCapital", params);
        return pdmcheck;
    }

    /**
     * 修改项目
     */
    cmp.modproinfo = function (){
        var params = {};
        var data = datatable.getSelected();
        params.submenu = _menuid;
        params.pro_code = data[0].pro_code;
        deptcmp.modproinfo(datatable,params);
    }


    /**
     * 查看项目明细
     */
    cmp.detailed = function (){
        var params = {};
        var data = datatable.getSelected();
        params.submenu = _menuid;
        params.pro_code = data[0].pro_code;
        deptcmp.proinfoview(datatable,params);
    }

    /**
     * 项目绩效目标审核(绩效处退回)
     */
    cmp.backjxaudit = function(obj){
        ajax();
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