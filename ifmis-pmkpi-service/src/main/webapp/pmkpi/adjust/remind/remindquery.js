if(!Ext.lt.pmkpi){
    Ext.lt.pmkpi = {};
}
if(!Ext.lt.pmkpi.adjust){
    Ext.lt.pmkpi.adjust = {};
}

Ext.lt.pmkpi.adjust.remindService = function(config, service){
    var deptcmp = Ext.lt.pmkpi.perfcommon(config, service);
    var cmp = {};

    var _menuid = config.menuid,//菜单id
        _tablecode,
        _datasource,//数据源集合
        _prolev = config.prolev,//项目级次
        _deptcoldatas = config.deptcoldatas,//部门列数据
        _depttabledata = config.depttabledata,//部门表数据
        _deptqfdatas = config.deptqfdatas,//部门查询区数据
        _proqfdatas = config.proqfdatas,//项目查询区数据
        _procoldatas = config.procoldatas,//项目列数据
        _protabledata = config.protabledata,//项目表数据
        _defquery,//列表查询条件
        _tabfilter,//页签查询条件
        _tabcode,//页签编码
        _saveAgency,//左侧树选择单位
        _lefttreename = "项目支出",//左侧评价对象树名称 默认项目支出
        _lefttabtype = "program",//左侧树页签guid 默认项目支出
        scrWidth = document.body.clientWidth,
        scrHeight = document.body.clientHeight;
    var isfirst=true;

    /**
     * 左侧页签切换触发函数.
     */
    tabChange = function (obj) {
        var ordernum = obj.ordernum;
        _saveAgency = "treeroot";
        Ext.lt.pmkpi.isleaf = '0';
        _lefttabtype = obj["code"];
        var data;
        var key;
        var cols;
        if (_lefttabtype == "program"){
            // _defquery = _protabledata.defquery;
            _tablecode = _protabledata.tablecode;
            _lefttreename = "项目支出";
            //cols = _procoldatas;
            data = _proqfdatas;
            key = '/pmkpi/adjust/report/program';
        } else if (_lefttabtype == "dept") {
            _defquery = _depttabledata.defquery;
            _tablecode = _depttabledata.tablecode;
            key = '/pmkpi/adjust/report/dept';
            _lefttreename = "部门整体";
            cols = _deptcoldatas;
            data = _deptqfdatas;
        }
        /*var params = {};
        params.tablecode = _tablecode;
        params.cols = cols;
        try{
            _datasource = Ext.lt.RCP.asyncall(service , "getDataSource", params);
            deptcmp.setColMapper(cols);
        }catch (e) {}*/
        //cmp.setTableColum(cols);
        queryfrom(data,key);
        var params = {};
        params.menuid = _menuid;
        params.tablecode = _tablecode;
        params.lefttabtype = _lefttabtype;
        var datalist = Ext.lt.RCP.asyncall(service , "getTreeData", params);
        lefttree.setRecordset(datalist, 0);
        Ext.lt.pmkpi.query();
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

    $(function (){
        isfirst = false;
        var params = {};
        params.ordernum = 0;
        params.code = _lefttabtype;
        tabChange(params);
    })

    //查询
    cmp.query = function (obj){
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
        params.tablesql = _defquery;
        params.menuid = _menuid;
        params.tabcode = _tabcode;
        params.prolev = _prolev;
        params.saveAgency = _saveAgency;
        params.isleaf = Ext.lt.pmkpi.isleaf+"";
        params.tabfilter = _tabfilter;
        params.lefttabtype = _lefttabtype;
        deptcmp.setColDatasource(_datasource, datatable);
        params.beanid = "pmkpi.adjust.remind.AdjustRemindBOTX";
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

    /**
     * 确认
     */
    cmp.add = function(){
        var data = datatable.getSelected();
        if(data.length != 1){
            Ext.lt.ui.alert("请选择一条数据！",function(){});
            return;
        }
        var url = '/pmkpi/adjust/remind/add.page';
        var params = {};
        params.proguid = data[0].proguid;
        params.mainguid = data[0].guid;
        params.agencyguid = data[0].agencyguid;
        params.finintorgguid = data[0].finintorgguid;
        url = Ext.lt.pmkpi.genPageUrl(url, params);
        indexwindow = Ext.lt.ui.openModalWindow(url,1000,450,"确认调整");
    }

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



    Ext.lt.message.hook("perfcommon", "auditquery",function(){
        Ext.lt.pmkpi.query();
        Ext.lt.ui.closeModalWindow();
    });

    Ext.lt.message.hook("queryform", "doquery",function(obj){
        Ext.lt.pmkpi.query();
    });

    //页签方法
    cmp.clickTabpage = function(obj){
//        changToolbuttonStatus(toolbutton,parseInt(obj.ordernum),obj.hidebtns);
        deptcmp.changTooltoolbuttontStatus(0,obj.hidebtns);
        _tabfilter = obj.filter;
        _tabcode = obj.code;
        Ext.lt.pmkpi.query();
    }
    return cmp;
}