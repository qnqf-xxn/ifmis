if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.midperfprogram){
	Ext.lt.pmkpi.midperfprogram = {};
}
if(!Ext.lt.pmkpi.midperfprogram.midpauditservice){
    Ext.lt.pmkpi.midperfprogram.midpauditservice = {};
}
Ext.lt.pmkpi.midperfprogram.midpauditservice = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};
    var _workflow = config.workflow,
        _menuid = config.menuid,
        _prolev = config.prolev,
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
    var isfirst = true;//首次进入
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
        params.beanid = "pmkpi.midperfprogram.MidProgramAuditBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        cmp.query();
    });
    
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
        params.pagetype = "editreport";
        params.procode = data[0].pro_code;
        params.proguid = data[0].proguid;//项目ID
        params.saveAgency = data[0].agencyguid; //虽然是agency也有可能是处室
        params.mainguid = data[0].proguid;
        params.agency = data[0].agencyguid;
        params.guid = data[0].guid;
        params.projectkind = data[0].projectkind;//项目类型
        params.prolev = _prolev;
        params.viewtype = "query";
        params.workflow = _workflow;
        params.isnzzj = "true";// 是否年中追加
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight,"绩效审核");
    }

    /**
     * 修改
     */
    cmp.update = function (obj){
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
            params.proguid = data[0].proguid;//项目ID
            params.procode = data[0].pro_code;//项目编码
            params.projectkind = data[0].projectkind;//项目类型
            params.viewtype = "mod";
            params.prolev = _prolev;
            params.isnzzj = "true";// 是否年中追加
        } else {
            Ext.lt.ui.alert("请选择一条要修改的数据！",function(){});
            return;
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"项目绩效目标申报");
    }

    /**
     * 修改项目
     */
    cmp.modproinfo = function (){
        var params = {};
        var data = datatable.getSelected();
        params.submenu = _menuid;
        params.pro_code = data[0].pro_code;
        common.modproinfo(datatable,params);
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
        params.vchtypeid = "EFD92E71A414005286FB8EB3E708C1F2";
        params.projectkind = xmxxEditobject[0].projectkind;
        common.editPromain(datatable,params);
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
        params.vchtypeid = "EFD92E71A414005286FB8EB3E708C1F2";
        params.projectkind = xmxxEditobject[0].projectkind;
        common.queryPromain(datatable,params);
    }

    /**
     * 查看项目明细
     */
    cmp.prodetailed = function (){
        var params = {};
        var data = datatable.getSelected();
        params.submenu = _menuid;
        params.pro_code = data[0].pro_code;
        common.proinfoview(datatable,params);
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
            if(col["colcode"] == "pro_name11"){
                col.fn = function(l,c,data,col){
                    return "<a herf='#' style='color:#468ac9'>" + data.pro_name + "</a>";
                }
                col.onclick = function(td, el, l, c, d) {
                    var params = {};
                    var url = _uikey + ".page";
                    params.pagetype = "editreport";
                    params.mainguid = d.guid;
                    params.guid = d.guid;
                    params.agency = d.agencyguid;
                    params.saveAgency = d.agencyguid;
                    params.prolev = _prolev;
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
        var wfstatus = datas[0].wfstatus;
        var actioncode = obj.code;
        if (actioncode == "cancelaudit"){
            if("011" == wfstatus){
                Ext.lt.ui.alert( "流程已终审，无法取消！",function(){
                });
                return;
            }
        }
        var params = {};
        params.datas = datas;
        params.tablecode = _tablecode;
        params.workflow = _workflow;
        params.auditdata = Ext.lt.pmkpi.auditdata;
        params.mainguid = datas[0].guid;
        params.procode = datas[0].pro_code;
        params.busguid = _menuid + "_" + wfstatus;
        if (actioncode == "audit" || actioncode == "auditbatch") {
            params.modeltype = "1";  //年中追加、绩效目标修订、绩效目标调整数据终审时提示不能取消终审
            var resulemap = Ext.lt.RCP.asyncall(serviceid, "queryWfstatusType", [datas[0].wfid, wfstatus]);
            params.isconts = resulemap.isconts;
        }
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
        var params = {};Ext.lt.pmkpi.auditservice
        params.guid = data[0].guid;
        params.agency = data[0].agencyguid;
        params.workflow = data[0].wfid;
        params.wfstatus = data[0].wfstatus;
        params.procode = data[0].pro_code;
        params.projguid = data[0].proguid;
        params.projectkind = data[0].projectkind;//项目类型
        params.isnzzj = "true"; // 是否年中追加
        params.uikey = _uikey;
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
        if (!nodemap.audittype || nodemap.audittype == "" || nodemap.audittype == "null") {
            Ext.lt.ui.alert( "请对流程审核节点进行配置！",function(){
            });
            return;
        }
        params.agency = data[0].agencyguid;
        params.guid = data[0].guid;
        var url = "/pmkpi/audit/index/" + nodemap.audittype + ".page";
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
    /**
     * 页面初始化加载，查看的话不显示按钮
     */
    $(function(){
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        common.pendingtasktab(config);
        cmp.query();
        isfirst = false;
    });

    Ext.lt.message.hook("perfcommon", "auditquery",function(){
        query();
        try {
            Ext.lt.ui.closeModalWindow();
        } catch (e) {
            Ext.lt.ui.modalWindow.close();
        }
    });

    /**
     * 纳入案例库
     */
    cmp.intocase = function () {
        var datas = datatable.getSelected();
        if(datas.length == 0){
            Ext.lt.ui.alert( "请最少选择一条数据！",function(){
            });
            return;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.datas = datas;
        Ext.lt.RCP.call(serviceid , "intoCase", params, function(rs){
            if (rs.success) {
                Ext.lt.ui.alert('纳入成功！',function(){
                    cmp.query();
                });
            } else {
                Ext.lt.ui.alert("纳入失败，请联系管理员！",function(){
                });
            }
            Ext.lt.ui.loadingClose();
        },function(rt){
            Ext.lt.ui.loadingClose();
            Ext.lt.ui.alert('纳入失败:' + rt,function(){
            });
        });
    }

    return cmp;
}