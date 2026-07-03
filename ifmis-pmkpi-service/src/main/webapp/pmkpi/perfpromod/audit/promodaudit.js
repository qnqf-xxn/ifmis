if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.promod){
    Ext.lt.pmkpi.promod = {};
}

Ext.lt.pmkpi.promod.promodaudit = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};

    var _menuid = config.menuid,//菜单id
        _workflow = config.workflow,//项目工作流guid
        _tablesql,
        _tabcode,
        _tablecode,
        _datasource,//数据源集合
        _prolev = config.prolev,//项目级次
        _modtype = config.modtype,
        _defquery,//列表查询条件
        _tabfilter,//页签查询条件
        _saveAgency,//左侧树选择单位
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;

    var isfirst = true;

    $(function (){
        common.initDatatable();
        cmp.query();
        isfirst = false;
    })

    //查询
    cmp.query = function (){
        Ext.lt.pmkpi.query();
    }

    Ext.lt.pmkpi.query = function(){
        if(!_saveAgency){
            _saveAgency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.tablesql = _tablesql;
        params.menuid = _menuid;
        params.tabcode = _tabcode;
        params.prolev = _prolev;
        params.saveAgency = _saveAgency;
        params.tabfilter = _tabfilter;
        params.workflow = _workflow;
        params.tablesql = _tablesql
        params.modtype = _modtype;
        params.viewtype = "query";
        params.isleaf = Ext.lt.pmkpi.isleaf+"";
        common.setColDatasource(_datasource, datatable);
        params.beanid = "pmkpi.perfpromod.ProModAuditBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }

    /**
     * 左侧树点击
     */
    Ext.lt.message.hook("left", "click",function(obj){
        var treeNode = obj.node.data;
        if(treeNode){ //不选择预算单位按类型查询
            _saveAgency = treeNode.guid;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _saveAgency = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
        }
        cmp.query();
    });

    //送审情况
    cmp.queryaudit = function (){
        common.auditquery(datatable);
    }

    //页签方法
    cmp.clickTabpage = function(obj){
        common.changTooltoolbuttontStatus(0,obj.hidebtns);
        _tabfilter = obj.filter;
        _tabcode = obj.code;
        if (!isfirst) {
            Ext.lt.pmkpi.query();
        }
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
        params.mainguid = data[0].guid;
        params.saveAgency = data[0].agencyguid;
        params.projguid = data[0].proguid;
        params.viewtype = "query";
        params.workflow = _workflow;
        params.prolev = _prolev;
        var url;
        if(_modtype == 'total'){
            url = "/pmkpi/program/mod/totaledit.page";
        }else {
            url = "/pmkpi/program/mod/yearedit.page";
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"绩效修订");
    }

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
        params.proguid = datas[0].proguid;
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
        params.projguid = data[0].proguid;
        params.agency = data[0].agencyguid;
        params.workflow = data[0].wfid;
        params.wfstatus = data[0].wfstatus;
        params.viewtype = "query";
        if(_modtype == 'total'){
            params.uikey = "/pmkpi/program/mod/totaledit";
        }else {
            params.uikey = "/pmkpi/program/mod/yearedit";
        }
        var nodemap = Ext.lt.RCP.asyncall(service, "queryPrevAuditType", [data[0].wfid, data[0].wfstatus]);
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

    Ext.lt.message.hook("perfcommon", "auditquery",function(){
        Ext.lt.pmkpi.query();
        try {
            Ext.lt.ui.closeModalWindow();
        } catch (e) {
            Ext.lt.ui.modalWindow.close();
        }
    });

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        _tablecode = uiconfig.tablecode;
        if(_modtype == "total"){
            _tablesql = config.totalwheresql;
        }else {
            _tablesql = config.yearwheresql;
        }
    });

    return cmp;
}