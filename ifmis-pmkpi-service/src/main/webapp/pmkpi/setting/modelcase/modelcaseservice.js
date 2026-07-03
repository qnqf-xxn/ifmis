if(!Ext.lt.pmkpi)
    Ext.lt.pmkpi = {};
if(!Ext.lt.pmkpi.modelcase)
    Ext.lt.pmkpi.modelcase = {};

Ext.lt.pmkpi.modelcase = function(config, service){
    var commoncmp = Ext.lt.pmkpi.perfcommon(config, service);
    var _nodeguid,
        _tablecode,
        _wheresql,
        _orderby,
        _uikey,
        _deltables,
        _delcols = config.delcols,
        _scrWidth =document.body.clientWidth,
        _scrHeight =document.body.clientHeight;
    var cmp = {};
    var serviceid = service;

    $(function () {
        commoncmp.initDatatable();
        cmp.query();
    })

    Ext.lt.pmkpi.query = function(){
        if(!_nodeguid){
            _nodeguid = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.nodeguid = _nodeguid;
        params.isleaf = Ext.lt.pmkpi.isleaf + "";
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.tablesql = _wheresql;
        params.orderby = _orderby;
        params.beanid = "pmkpi.setting.modelcase.ModelCaseBOTX";
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params,function(){
            Ext.lt.ui.loadingClose();
        });
    }
    cmp.query = function(){
        Ext.lt.pmkpi.query();
    }
    /**
     * 查询消息
     */
    Ext.lt.message.hook("perfcommon", "tablequery",function(){
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    /**
     *
     */
    Ext.lt.message.hook("busdatatable", "drawed",function (obj) {
        _tablecode = obj.uiconfig.tablecode;
        _wheresql = obj.uiconfig.defquery;
        _orderby = obj.uiconfig.orderby;
        var config = obj.config;
        _uikey = config.uikey;
        _deltables = config.deltables;
    });

    /**
     * 新增
     */
    cmp.add = function(){
        if(!_nodeguid || _nodeguid == "treeroot" || Ext.lt.pmkpi.isleaf != "1"){
            Ext.lt.ui.alert("请选择左侧树末级节点数据！",function(){});
            return;
        }
        var params = {};
        var url = _uikey + ".page";
        var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
        params.framesystem = _nodeguid;
        params.mainguid = newguid;
        params.pageurl = _uikey; //弹出的url.
        params.viewtype = "add";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,_scrWidth,_scrHeight,"编辑");
    }

    /**
     *修改
     */
    cmp.update = function(){
        var selDatas = datatable.getSelected();
        if (selDatas.length != 1) {
            Ext.lt.ui.alert("请选择一条数据修改！",function(){});
            return;
        }
        var params = {};
        var url = _uikey + ".page";
        var newguid = Ext.lt.RCP.asyncall(serviceid , "getCreateguid", null);
        params.framesystem = selDatas[0].framesystem;
        params.mainguid = selDatas[0].guid;
        params.pageurl = _uikey; //弹出的url.
        params.viewtype = "mod";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,_scrWidth,_scrHeight,"项目绩效目标申报");
    }

    /**
     * 删除
     */
    cmp.del = function() {
        var params = {};
        params.tablecode = _tablecode;
        params.delcols = _delcols;
        params.deltables = _deltables;
        commoncmp.deltable(datatable, params);
    }

    /**
     * 左侧树点击事件
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
    return cmp;
}