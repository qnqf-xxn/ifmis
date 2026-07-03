if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.perfreview){
    Ext.lt.pmkpi.perfreview = {};
}

Ext.lt.pmkpi.perfreview.queryservice = function(config, service){
    var common = Ext.lt.pmkpi.perfcommon(config, service);
    var serviceid = service;
    var cmp = {};
    var _menuid = config.menuid,//菜单id
        _busguid = config.busguid,//审核定义guid
        _workflow = config.workflow,//工作流guid
        _tablecode,
        _prolev = config.prolev,//项目级次
        _deptcoldatas = config.deptcoldatas,//部门列数据
        _depttabledata = config.depttabledata,//部门表数据
        _procoldatas = config.procoldatas,//项目列数据
        _protabledata = config.protabledata,//项目表数据
        _deptqfdatas = config.deptqfdatas,//部门查询区数据
        _proqfdatas = config.proqfdatas,//项目查询区数据
        _defquery,//列表查询条件
        _tabfilter,//页签查询条件
        _tabcode,//页签编码
        _saveAgency,//左侧树选择单位
        _uikey,//跳转url
        _lefttabtype = "PMKPIAGENCYPROGRAM",//左侧页签类型
        _lefttreename = "项目支出",//左侧评价对象树名称 默认项目支出
        _lefttreeid = "protrace",//评价对象guid 默认项目支出
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;

    /**
     * 左侧页签切换触发函数.
     */
    tabChange = function (obj) {
        _saveAgency = "treeroot";
        Ext.lt.pmkpi.isleaf = '0';
        _lefttabtype = obj["code"];
        var data;
        if (_lefttabtype == "PMKPIAGENCYPROGRAM") {
            _lefttreename = "项目支出";
            _defquery = _protabledata.defquery;
            _tablecode = _protabledata.tablecode;
            cmp.setTableColum(_procoldatas);
            data = _proqfdatas;
            key = '/pmkpi/review/report/program';
            cmp.query();
        }else if(_lefttabtype == "PMKPIAGENCYEDIT"){
            _lefttreename = "部门整体";
            _defquery = _depttabledata.defquery;
            _tablecode = _depttabledata.tablecode;
            cmp.setTableColum(_deptcoldatas);
            data = _deptqfdatas;
            key = '/pmkpi/review/report/dept';
            cmp.query();
        }
        queryfrom(data,key);
    }

    function queryfrom(data, key) {
        var configqueryform = {
            id: "queryform",
            fastquery : true,
            datatable : 'datatable',
            drawmode :'div',
            key: key,
            label: "快速查询",
            labelwidth: "120",
            appid: "pmkpi",
            config: null,
            serverid: key,
            amtmaxlength:18,
            columnsize: 5,
            data: data
        }
        queryform = new Ext.lt.bus.ui.querypanel(configqueryform);
        queryform.draw($(".busquerypanel_outline")[0]);
    }

    //查询
    cmp.query = function (obj){
        Ext.lt.pmkpi.query();
    }

    $(function (){
        //组件配置，service不放到第一位时，组件初始化消息不走问题
        common.initDatatable();
        cmp.setTableColum(_procoldatas);
        var node = lefttree.qtree.getNode(_lefttreeid);
        if(node != null) {
            lefttree.qtree.selectedNode(node)
        }
    })

    /**
     * 查询
     */
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
        params.tablesql = _defquery;
        params.menuid = _menuid;
        params.tabcode = _tabcode;
        params.prolev = _prolev;
        params.saveAgency = _saveAgency;
        params.isleaf = Ext.lt.pmkpi.isleaf+"";
        params.tabfilter = _tabfilter;
        params.workflow = _workflow;
        params.beanid = "pmkpi.perfreview.ReviewQueryBOTX";
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
        if (_lefttabtype == "PMKPIAGENCYPROGRAM") {
            _defquery = _protabledata.defquery;
            _tablecode = _protabledata.tablecode;
            _saveAgency = treeNode.code;
        }else if(_lefttabtype == "PMKPIAGENCYEDIT"){
            _defquery = _depttabledata.defquery;
            _tablecode = _depttabledata.tablecode;
            _saveAgency = treeNode.code;
        }
        cmp.query();
    });

    Ext.lt.message.hook("datatable", "beforesetcols",function(obj){
        var uiconfig = obj.table.uiconfig;
        var config = obj.table.config;
        _defquery = uiconfig.defquery;
        _tablecode = uiconfig.tablecode;
        _uikey = config.uikey;
        var cols = obj.cols;
        if(!Ext.lt.isArray(cols))
            cols = [cols];
        for(var i=0; i<cols.length; i++){
            var col = cols[i];
            if(col["colcode"] == "pro_name"){
                col.fn = function(l,c,data,col){
                    return "<a herf='#' style='color:#468ac9'>" + data.pro_name + "</a>";
                }
                col.onclick = function(td, el, l, c, d) {
                    var url = _uikey + ".page";
                    var params = {};
                    params.pagetype = "editreport";
                    params.mainguid = d.guid;
                    params.agency = d.agencyguid;
                    params.viewtype = "query";
                    params.workflow = _workflow;
                    url = Ext.lt.pmkpi.genPageUrl(url, params);
                    Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"项目绩效目标查看");
                };
            }
        }
    });

    /**
     * 动态配置表格的列.
     *
     * @param data --
     */
    cmp.setTableColum = function(cols){
        var c = [];
        var tmainCol = datatable.getCols();
        c.push(tmainCol[0]);
        c.push(tmainCol[1]);
        for (var i=0; i<cols.length; i++) {
            c.push(cols[i]);
        }
        datatable.setCols(c);
        var h = $("#queryform .busquerypanel").height();
        var buttonH = $('.busnomalbtn_outline').height();
        var tableh = scrHeight - h- buttonH-20;
        datatable.resize(scrWidth,tableh);
        datatable.headsort(false);
        datatable.setAllowcustom(false);
        datatable.setAllowClock(false);
        var page = {};//datatable.getPage();
        page.columns = "*";
        datatable.setPage(page);
        datatable.setSelfdefconfig({config: "{}"});
        datatable.redraw();
    }

    //送审情况
    cmp.showwfinfo = function (){
        common.auditquery(datatable);
    }

    //页签方法
    cmp.clickTabpage = function(obj){
        var tabcode = obj.code;
        if (tabcode == "PMKPIAGENCYPROGRAM" || tabcode == "PMKPIAGENCYEDIT") {
            return;
        }
        // changToolbuttonStatus(toolbutton, parseInt(obj.ordernum), obj.hidebtns);
        common.changTooltoolbuttontStatus(0,obj.hidebtns);
        _tabfilter = obj.filter;
        _tabcode = obj.code;
        Ext.lt.pmkpi.query();
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
        params.saveAgency = data[0].agencyguid;
        params.mainguid = data[0].proguid;
        params.workflow = _workflow;

        params.projguid = data[0].proguid;
        params.viewtype = "query";
        var url = "";
        if (_lefttabtype && "PMKPIAGENCYPROGRAM" == _lefttabtype) { //项目支出
            url = "/pmkpi/review/report/proedit.page";
        } else if (_lefttabtype && "PMKPIAGENCYEDIT" == _lefttabtype) { //部门整体
            url = "/pmkpi/review/report/deptedit.page";
        }
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        Ext.lt.ui.openModalWindow(url,scrWidth,scrHeight,"绩效目标调整-"+_lefttreename);
    }

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    return cmp;
}

