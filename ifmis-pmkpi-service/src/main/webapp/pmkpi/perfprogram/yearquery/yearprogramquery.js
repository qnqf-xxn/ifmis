if (!Ext.lt.pmkpi) {
    Ext.lt.pmkpi = {};
}
if (!Ext.lt.pmkpi.perfprogram) {
    Ext.lt.pmkpi.perfprogram = {};
}
if (!Ext.lt.pmkpi.perfprogram.yearproqueryservice) {
    Ext.lt.pmkpi.perfprogram.yearproqueryservice = {};
}

Ext.lt.pmkpi.perfprogram.yearproqueryservice = function (config, service) {
    var cmp = {};
    var commoncmp = Ext.lt.pmkpi.perfcommon(config, service);
    var _menuid = config.menuid,
        _type = config.type,  // 1-事前绩效评估查询；2-项目绩效目标查询；yearprotablist-项目年度绩效查询（广西分页签）
        _agency,
        _tablecode,
        _tabfilter,
        _tabcode,
        _name,
        _defquery,
        _wheresql,
        _orderby,
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;
    var isfirst=true;//首次进入

    $(function () {
        commoncmp.initDatatable();
        isfirst = false;
        // cmp.query();
    })

    //查询
    cmp.query = function () {
        Ext.lt.pmkpi.query();
    }

    Ext.lt.pmkpi.query = function () {
        if (!_agency) {
            _agency = "treeroot";
            Ext.lt.pmkpi.isleaf = 0;
        }
        Ext.lt.ui.loadingShow();
        var params = {};
        params.agency = _agency;
        params.isleaf = Ext.lt.pmkpi.isleaf + "";
        params.menuid = _menuid;
        params.queryConfig = queryform.getQueryParam();
        params.querySql = queryform.getQuerySQL();
        params.tablecode = _tablecode;
        params.tablesql = _defquery;
        params.pagetype = "report";
        params.tabfilter = _tabfilter;
        params.tabcode = _tabcode;
        params.menuid = _menuid;
        params.orderby = _orderby;
        params.beanid = "pmkpi.perfprogram.YearProgramQueryBOTX";
        params.type = _type;
        Ext.lt.bus.exportBeanid = params.beanid;
        datatable.queryData(params, function () {
            Ext.lt.ui.loadingClose();
        });
    }

    /**
     * 查询区查询
     */
    Ext.lt.message.hook("queryform", "doquery",function(obj){
        cmp.query();
    });

    /**
     *送审情况
     */
    cmp.queryaudit = function () {
        commoncmp.auditquery(datatable);
    }

    /**
     * 左侧树
     */
    Ext.lt.message.hook("left", "click", function (obj) {
        var treeNode = obj.node.data;
        if (treeNode) {
            _agency = treeNode.guid;
            _name = treeNode.name;
            Ext.lt.pmkpi.isleaf = treeNode.isleaf;
        } else {
            _agency = "treeroot";
            Ext.lt.pmkpi.isleaf = '0';
        }
        cmp.query();
    });

    /**
     * 表格
     */
    Ext.lt.message.hook("datatable", "beforesetcols", function (obj) {
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        //yearprotablist 项目年度绩效分页签列表 表名在页签uitabpage中配置
        if(_type != 'yearprotablist'){
            _tablecode = uiconfig.tablecode;
        }
        _defquery = uiconfig.defquery;
        _orderby = uiconfig.orderby;
        _wheresql = config.wheresql;
    });

    /**
     * 查看项目详情
     */
    cmp.proinfoview = function(){
        var data = datatable.getSelected();
        if(data.size()==1){
            var params = {};
            params.submenu = _menuid;
            params.pro_code = data[0].pro_code;
            commoncmp.proinfoview(datatable,params);
        } else if(data.size() > 1) {
            Ext.lt.ui.alert('每次只能查看一条数据！',function(){});
        } else {
            Ext.lt.ui.alert('请选择要查看的数据！',function(){});
        }
    }

    cmp.queryView = function (){
        var data = datatable.getSelected();
        if(!data || data.length != 1){
            Ext.lt.ui.alert("请选中一条数据查看项目明细！",function(){});
            return;
        }
        var url = "/pmkpi/yearprogram/query/edit.page";
        var params = {};
        params.mainguid = data[0].guid;
        params.agency = data[0].agencyguid;
        params.pro_code = data[0].pro_code;
        params.projectkind = data[0].projectkind;//项目类型
        params.viewtype = "query";
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url, scrWidth, scrHeight, "项目绩效目标查看");
    }

    /**
     * 河北导出
     * @param obj
     */
    cmp.hbexpdoc = function(obj){
        var data = datatable.getSelected();
        if (data.size() == 0) {
            alert("请选择数据进行导出！");
            return;
        }
        var guids = [];
        for(var i=0;i<data.length;i++){
            guids.push(data[i].guid);
        }
        var btnconfig = eval('(' + obj.config + ')');
        var templatecode = btnconfig.tempatecode;
        var bobeanid = "pmkpi.perfcommon.expdoc.ExpDocBOTX";
        var parammap = new Map();
        parammap.set("templatecode", templatecode);
        parammap.set("guids", guids);
        parammap.set("bobeanid", bobeanid);
        commoncmp.hbExpdocFile(parammap);
    }

    /**
     * 导出目标批复表
     * @param obj
     */
    cmp.hbexpdocpf = function(obj){
        var data = datatable.getSelected();
        if (data.size() == 0) {
            alert("请选择数据进行导出！");
            return;
        }
        var guids = [];
        for(var i=0;i<data.length;i++){
            guids.push(data[i].guid);
        }
        var btnconfig = eval('(' + obj.config + ')');
        var templatecode = btnconfig.tempatecode;
        var bobeanid = "pmkpi.perfcommon.expdoc.ExpDocBOTX";
        var parammap = new Map();
        parammap.set("templatecode", templatecode);
        parammap.set("guids", guids);
        parammap.set("bobeanid", bobeanid);
        commoncmp.hbExpdocFile(parammap);
    }


    //页签方法
    cmp.clickTabpage = function(obj){
        changToolbuttonStatus(toolbutton, parseInt(obj.ordernum), obj.hidebtns);
        var config = eval('(' + obj.config + ')');
        _tablecode = config.tablecode;
        _tabfilter = obj.filter;
        _tabcode = obj.code;
        if (!isfirst){
            Ext.lt.pmkpi.querytree();
            Ext.lt.pmkpi.query();
        }
    }


    Ext.lt.pmkpi.querytree = function () {
        var params = {};
        params.menuId = _menuid;
        params.tablecode = _tablecode;
        params.type = _type;
        var datamap = Ext.lt.RCP.asyncall(service, "getTreeData", params);
        lefttree.setRecordset(datamap.datas, 0);
    }

    /**
     * 查看项目资金来源
     */
    cmp.querySourceFund = function (){
        var cols = [];
        cols.push("agency_code");
        cols.push("guid");
        cols.push("pro_code");
        var url = "/pmkpi/program/sourcefund.page";
        commoncmp.queryDataList(cols, url);
    }

    return cmp;
}