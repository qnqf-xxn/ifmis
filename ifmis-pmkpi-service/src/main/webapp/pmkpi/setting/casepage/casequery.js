if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.case){
    Ext.lt.pmkpi.case = {};
}

Ext.lt.pmkpi.case.queryservice = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};

    var _menuid = config.menuid,//菜单id
        _tablecode,
        _workflow,//工作流guid
        _lefttreename,//左侧评价对象树名称 默认项目支出
        _lefthidebtn,//左侧树隐藏按钮
        _tabhidtbtn,//右侧页签隐藏按钮
        _leftmenuid,//隐藏菜单
        _lefttab = config.lefttab,//左侧树第一个页签
        _lefttabtype = _lefttab.code,//左侧树页签类型
        _defquery,//列表查询条件
        _tabcode,//页签编码
        _nodeguid,//左侧树选择单位
        _isCasetype,//是否是分类
        _leftsource,
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;

    /**
     * 左侧页签切换触发函数.
     */
    tabChange = function (obj) {
        _nodeguid = "treeroot";
        Ext.lt.pmkpi.isleaf = '0';
        _lefttabtype = obj["code"];
        _lefttreename = obj["name"];
        _workflow = obj.leftwfid;
        _lefthidebtn = obj.hidebtns;
        _leftmenuid = obj.leftmenuid;
        var _leftconfig = eval('(' + obj.config + ')');
        _leftsource = _leftconfig.leftsource;
        common.changTooltoolbuttontStatus(0,  _lefthidebtn);
        var params = {};
        params.menuid = _menuid;
        params.tablecode = _tablecode;
        params.lefttabtype = _lefttabtype;
        params.leftmenuid = _leftmenuid;
        params.leftsource = _leftsource;
        var rt = Ext.lt.RCP.asyncall(service , "getTreeData", params);
        lefttree.setRecordset(rt.treeDatas, 0);
        _isCasetype = rt.isCasetype;
        Ext.lt.pmkpi.query();
        obj.datas = rt.treeDatas;
        return obj;
    }


    $(function (){
        common.initDatatable();
        var _lefttab = lefttree.getActiveTabCfg();
        tabChange(_lefttab);
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
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        params.menuid = _menuid;
        params.tabcode = _tabcode;
        params.nodeguid = _nodeguid;
        params.isCasetype = _isCasetype;
        params.leftsource = _leftsource;
        params.isleaf = Ext.lt.pmkpi.isleaf+"";
        params.workflow = _workflow;
        params.lefttabtype = _lefttabtype;
        params.leftmenuid =_leftmenuid;
        params.beanid = "pmkpi.casepage.query.CaseQueryBOTX";
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
            _nodeguid = treeNode.guid;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _nodeguid = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
        }
        cmp.query();
    });

    //送审情况
    cmp.queryaudit = function (){
        common.auditquery(datatable);
    }

    /**
     * 查看明细
     */
    cmp.detailed = function () {
        var data = datatable.getSelected();
        if (!data || data.length != 1) {
            Ext.lt.ui.alert("请选中一条数据进行查看！", function () {
            });
            return;
        }
        var params = {};
        params.mainguid = data[0].guid;
        params.viewtype = "query";
        params.workflow = _workflow;
        params.bustype = _lefttabtype;
        var url = "";
        if (_lefttabtype && "PM001" == _lefttabtype) { //项目支出
            url = "/pmkpi/setting/caseinfo/edit.page";
        } else if (_lefttabtype && "DEPT" == _lefttabtype) { //部门整体
            url = "/pmkpi/case/deptedit.page";
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "案例明细-" + _lefttreename);
    }

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        //表配置
        _tablecode = uiconfig.tablecode;
        _defquery = uiconfig.defquery;
    });

    return cmp;
}